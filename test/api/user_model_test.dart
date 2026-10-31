import 'package:abould_ada/modules/api_integration/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('UserModel.fromJson parses id as int or string', () {
    final fromInt = UserModel.fromJson({
      'id': 2,
      'firstName': 'Michael',
      'lastName': 'Owais',
      'email': 'm@x.com',
      'username': 'michael',
    });
    expect(fromInt.id, 2);
    expect(fromInt.lastName, 'Owais');

    final fromString = UserModel.fromJson({
      'id': '2',
      'firstName': 'Michael',
      'lastName': 'Owais',
      'email': 'm@x.com',
      'username': 'michael',
    });
    expect(fromString.id, 2);
  });
}
