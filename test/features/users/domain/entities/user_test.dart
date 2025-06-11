import 'dart:convert';
import 'package:cleancode_app/features/users/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User Entity', () {
    // Sample Role data
    final tRoleModel = Role(id: 'role1', name: 'Admin', status: true, deleted: false, createdAt: '2023-01-01', updatedAt: '2023-01-01');
    final tRoleMap = {"_id": "role1", "name": "Admin", "status": true, "deleted": false, "createdAt": "2023-01-01", "updatedAt": "2023-01-01"};

    // Sample User data with Role object
    final tUserModelWithRoleObject = User(
      id: 'user1',
      name: 'Test User',
      email: 'test@example.com',
      image: 'test.png',
      role: tRoleModel, // Role as an object
      status: true,
      google: false,
      createdAt: '2023-01-01',
      updatedAt: '2023-01-01',
    );

    // Sample User data with Role as Map (might occur if role is just an ID string or a map from other sources)
     final tUserModelWithRoleMap = User(
      id: 'user2',
      name: 'Test User 2',
      email: 'test2@example.com',
      image: 'test2.png',
      role: tRoleMap, // Role as a Map
      status: true,
      google: true,
      createdAt: '2023-01-02',
      updatedAt: '2023-01-02',
    );

    // Sample User data with Role as String ID
    final tUserModelWithRoleIdString = User(
      id: 'user3',
      name: 'Test User 3',
      email: 'test3@example.com',
      image: 'test3.png',
      role: "role1_id_string", // Role as a String ID
      status: false,
      google: false,
      createdAt: '2023-01-03',
      updatedAt: '2023-01-03',
    );


    test('toMap() should return a valid map when role is an object', () {
      final result = tUserModelWithRoleObject.toMap();
      expect(result['_id'], 'user1');
      expect(result['name'], 'Test User');
      expect(result['email'], 'test@example.com');
      expect(result['role'], isA<Map<String, dynamic>>());
      expect(result['role']['_id'], 'role1');
      expect(result['role']['name'], 'Admin');
    });

    test('toMap() should return a valid map when role is already a map', () {
      final result = tUserModelWithRoleMap.toMap();
      expect(result['_id'], 'user2');
      expect(result['role'], isA<Map<String, dynamic>>());
      expect(result['role']['_id'], 'role1');
    });

    test('toMap() should return a valid map when role is a String ID', () {
      final result = tUserModelWithRoleIdString.toMap();
      expect(result['_id'], 'user3');
      expect(result['role'], "role1_id_string");
    });

    // Test data for fromMap
    final tUserMapWithRoleObject = {
      "_id": "user1",
      "name": "Test User",
      "email": "test@example.com",
      "image": "test.png",
      "role": tRoleMap, // Role as a map for parsing
      "status": true,
      "google": false,
      "createdAt": "2023-01-01",
      "updatedAt": "2023-01-01",
    };

    final tUserMapWithRoleIdString = {
      "_id": "user3",
      "name": "Test User 3",
      "email": "test3@example.com",
      "image": "test3.png",
      "role": "role1_id_string", // Role as a string
      "status": false,
      "google": false,
      "createdAt": "2023-01-03",
      "updatedAt": "2023-01-03",
    };

    test('fromMap() should return a valid User object when role is a map', () {
      final result = User.fromMap(tUserMapWithRoleObject);
      expect(result.id, 'user1');
      expect(result.name, 'Test User');
      expect(result.role, isA<Role>());
      expect((result.role as Role).id, 'role1');
      expect((result.role as Role).name, 'Admin');
    });

    test('fromMap() should return a valid User object when role is a String ID', () {
      final result = User.fromMap(tUserMapWithRoleIdString);
      expect(result.id, 'user3');
      expect(result.name, 'Test User 3');
      expect(result.role, "role1_id_string");
    });

    test('toJson() and fromJson() should correctly serialize and deserialize', () {
      // Test with Role as an object
      final jsonStringWithRoleObject = tUserModelWithRoleObject.toJson();
      final deserializedUserWithRoleObject = User.fromJson(jsonStringWithRoleObject);
      expect(deserializedUserWithRoleObject, tUserModelWithRoleObject);

      // Test with Role as a map (note: fromJson will parse this into a Role object)
      // So, we need to compare with a User object that has Role object after parsing
      final jsonStringWithRoleMap = tUserModelWithRoleMap.toJson(); // role here is a map
      final deserializedUserFromRoleMap = User.fromJson(jsonStringWithRoleMap);

      // Construct the expected User object after parsing (role map becomes Role object)
      final expectedUserFromRoleMap = User(
        id: 'user2', name: 'Test User 2', email: 'test2@example.com', image: 'test2.png',
        role: Role.fromMap(tRoleMap), // Parsed into Role object
        status: true, google: true, createdAt: '2023-01-02', updatedAt: '2023-01-02',
      );
      expect(deserializedUserFromRoleMap, expectedUserFromRoleMap);

       // Test with Role as a string ID
      final jsonStringWithRoleId = tUserModelWithRoleIdString.toJson();
      final deserializedUserFromRoleId = User.fromJson(jsonStringWithRoleId);
      expect(deserializedUserFromRoleId, tUserModelWithRoleIdString);
    });

    test('Equality operator should work correctly', () {
      final user1 = User(id: '1', name: 'A', email: 'a@a.com', role: Role(id: 'r1', name: 'R'));
      final user2 = User(id: '1', name: 'A', email: 'a@a.com', role: Role(id: 'r1', name: 'R'));
      final user3 = User(id: '2', name: 'B', email: 'b@b.com', role: Role(id: 'r2', name: 'S'));
      final user4 = User(id: '1', name: 'A', email: 'a@a.com', role: "r1_string_id");
      final user5 = User(id: '1', name: 'A', email: 'a@a.com', role: "r1_string_id");


      expect(user1, equals(user2));
      expect(user1, isNot(equals(user3)));
      expect(user4, equals(user5));
      expect(user1, isNot(equals(user4))); // Role object vs Role string id
    });

  });
}
