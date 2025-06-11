import 'package:cleancode_app/core/errors/failures.dart';
import 'package:cleancode_app/core/usecase/usecase.dart';
// import 'package:cleancode_app/features/users/data/models/item_req_params.dart'; // Not needed anymore
import 'package:cleancode_app/features/users/domain/entities/pageable_users.dart';
import 'package:cleancode_app/features/users/domain/repositories/user_repository.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class GetAllUsersParams {
  final int? page;
  final int? pageSize;

  GetAllUsersParams({this.page, this.pageSize});
}

class GetAllUsersUsecase implements Usecase<Either<Failure, PageableUsers>, GetAllUsersParams> {
  @override
  Future<Either<Failure, PageableUsers>> call({GetAllUsersParams? params}) async {
    final result = await sl<UserRepository>().getAllItems(
      page: params?.page,
      pageSize: params?.pageSize,
    );

    return result.fold(
      (failure) {
        // Assuming the failure is already a Failure type or can be mapped to one
        // If it's a String message as seen in UserApiServiceImpl, map it to a ServerFailure
        if (failure is String) {
          return Left(ServerFailure(message: failure));
        }
        return Left(failure as Failure); // Or map appropriately
      },
      (response) {
        // Assuming response is a Dio Response object as per UserApiServiceImpl
        if (response is Response) {
          try {
            // Check if response.data is already a Map
            final responseData = response.data is Map<String, dynamic>
                ? response.data
                : (response.data is String ? {"message": response.data} : null); // Handle if data is a plain string

            if (responseData == null) {
               return Left(ServerFailure(message: "Invalid response data format"));
            }

            // The actual list of users might be nested, e.g., in responseData['data']
            // And pagination details might be at the top level of responseData
            // Adjust based on actual API structure.
            // For example, if API returns { "page": 1, "pageSize": 10, "totalItems": 100, "users": [...] }
            // And User.fromMap expects a map for a single user.

            final Map<String, dynamic> apiResponseMap = {
              'page': responseData['page'] ?? params?.page ?? 1, // Default if not in response
              'pageSize': responseData['pageSize'] ?? params?.pageSize ?? 10, // Default if not in response
              'totalItems': responseData['totalItems'] ?? (responseData['data'] as List?)?.length ?? 0, // Default if not in response
              'data': responseData['data'] ?? [], // Default to empty list
            };

            return Right(PageableUsers.fromMap(apiResponseMap));
          } catch (e) {
            return Left(ServerFailure(message: "Error parsing response: ${e.toString()}"));
          }
        }
        // If it's not a Dio Response, it might be an error or unexpected type
        return Left(ServerFailure(message: "Unexpected response type from repository"));
      },
    );
  }
}