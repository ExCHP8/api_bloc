import 'package:example/src/get/get.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GetUserModel', () {
    test('Validate Type', () {
      const GetUserModel data = GetUserModel(
          id: 0,
          firstName: 'firstName',
          lastName: 'lastName',
          avatar: 'avatar');
      expect(data, isA<GetUserModel>());
    });
  });
}
