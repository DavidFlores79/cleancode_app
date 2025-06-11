import 'package:cleancode_app/core/errors/failures.dart';
import 'package:cleancode_app/features/users/domain/entities/pageable_users.dart';
import 'package:cleancode_app/features/users/domain/entities/user.dart';
import 'package:cleancode_app/features/users/domain/repositories/user_repository.dart';
import 'package:cleancode_app/features/users/domain/usecases/get_all_users_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Import service_locator and register mock
import 'package:cleancode_app/service_locator.dart' as di;

@GenerateMocks([UserRepository])
import 'get_all_users_usecase_test.mocks.dart';

void main() {
  late GetAllUsersUsecase usecase;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    // It's common for use cases to get repositories from a service locator.
    // If your use case directly takes it as a constructor param, adjust this.
    // For this example, assuming service locator is used as seen in the app.
    // We need to ensure 'sl' is initialized and can provide the mock.
    // A simple way for testing is to re-register the dependency.
    di.sl.registerSingleton<UserRepository>(mockUserRepository);
    usecase = GetAllUsersUsecase();
  });

  tearDown(() {
    // Unregister to avoid conflicts between tests if sl is reset elsewhere
    di.sl.unregister<UserRepository>();
  });

  final tUser1 = User(id: '1', name: 'User One', email: 'user1@example.com');
  final tUser2 = User(id: '2', name: 'User Two', email: 'user2@example.com');

  final tParams = GetAllUsersParams(page: 1, pageSize: 10);

  group('GetAllUsersUsecase', () {
    test(
      'should get pageable users from the repository and parse them correctly',
      () async {
        // Arrange: Mock the repository to return a successful Dio Response
        final apiResponseData = {
          "page": 1,
          "pageSize": 10,
          "totalItems": 2,
          "data": [
            {"_id": "1", "name": "User One", "email": "user1@example.com"},
            {"_id": "2", "name": "User Two", "email": "user2@example.com"}
          ]
        };
        // Create a Dio Response object similar to what the API would return
        final dioResponse = Response(
          data: apiResponseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        );

        when(mockUserRepository.getAllItems(page: tParams.page, pageSize: tParams.pageSize))
            .thenAnswer((_) async => Right(dioResponse));

        // Act
        final result = await usecase.call(params: tParams);

        // Assert
        result.fold(
          (failure) => fail('Test failed with a failure: $failure'),
          (pageableUsers) {
            expect(pageableUsers.page, 1);
            expect(pageableUsers.pageSize, 10);
            expect(pageableUsers.totalItems, 2);
            expect(pageableUsers.data.length, 2);
            expect(pageableUsers.data[0].id, tUser1.id);
            expect(pageableUsers.data[0].name, tUser1.name);
            expect(pageableUsers.data[1].id, tUser2.id);
          },
        );
        verify(mockUserRepository.getAllItems(page: tParams.page, pageSize: tParams.pageSize));
        verifyNoMoreInteractions(mockUserRepository);
      },
    );

    test(
      'should return ServerFailure when the repository call is unsuccessful (e.g. String error)',
      () async {
        // Arrange
        final errorMessage = 'Error fetching data';
        when(mockUserRepository.getAllItems(page: tParams.page, pageSize: tParams.pageSize))
            .thenAnswer((_) async => Left(errorMessage));

        // Act
        final result = await usecase.call(params: tParams);

        // Assert
        expect(result, Left(ServerFailure(message: errorMessage)));
        verify(mockUserRepository.getAllItems(page: tParams.page, pageSize: tParams.pageSize));
        verifyNoMoreInteractions(mockUserRepository);
      },
    );

    test(
      'should return original Failure when repository returns a Failure object',
      () async {
        // Arrange
        final tOriginalFailure = ServerFailure(message: 'Original Failure Object');
        when(mockUserRepository.getAllItems(page: tParams.page, pageSize: tParams.pageSize))
            .thenAnswer((_) async => Left(tOriginalFailure));

        // Act
        final result = await usecase.call(params: tParams);

        // Assert
        expect(result, Left(tOriginalFailure));
        verify(mockUserRepository.getAllItems(page: tParams.page, pageSize: tParams.pageSize));
        verifyNoMoreInteractions(mockUserRepository);
      },
    );

     test(
      'should handle parsing errors gracefully and return ServerFailure',
      () async {
        // Arrange: Response with malformed data
        final malformedApiResponseData = {
          "page": "not_an_int", // Malformed
          "pageSize": 10,
          "totalItems": 1,
          "data": [
            {"_id": "1", "name": "User One"} // Missing email for User.fromMap if strict
          ]
        };
        final dioResponse = Response(
          data: malformedApiResponseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        );

        when(mockUserRepository.getAllItems(page: tParams.page, pageSize: tParams.pageSize))
            .thenAnswer((_) async => Right(dioResponse));

        // Act
        final result = await usecase.call(params: tParams);

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) => expect(failure, isA<ServerFailure>()),
          (_) => fail('Should have returned a failure'),
        );
      },
    );
  });
}
