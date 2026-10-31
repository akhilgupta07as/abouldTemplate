import 'package:abould_ada/modules/authentication/presentation/utils/auth_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthValidators', () {
    test('username validation', () {
      expect(AuthValidators.username(null), 'Username is required');
      expect(AuthValidators.username('  '), 'Username is required');
      expect(AuthValidators.username('emilys'), isNull);
    });

    test('email validation', () {
      expect(AuthValidators.email(null), 'Email is required');
      expect(AuthValidators.email(''), 'Email is required');
      expect(AuthValidators.email('not-an-email'), 'Enter a valid email address');
      expect(AuthValidators.email('test@'), 'Enter a valid email address');
      expect(AuthValidators.email('test@company.com'), isNull);
    });

    test('password validation', () {
      expect(AuthValidators.password(null), 'Password is required');
      expect(AuthValidators.password('short'), 'Password must be at least 8 characters');
      expect(AuthValidators.password('12345678'), isNull);
      expect(AuthValidators.password('validStrongPassword!'), isNull);
    });

    test('confirmPassword validation', () {
      expect(AuthValidators.confirmPassword(null, 'pwd12345'), 'Please confirm your password');
      expect(AuthValidators.confirmPassword('pwd1', 'pwd2'), 'Passwords do not match');
      expect(AuthValidators.confirmPassword('pwd12345', 'pwd12345'), isNull);
    });

    test('name validation', () {
      expect(AuthValidators.name(null), 'Name is required');
      expect(AuthValidators.name('a'), 'Enter your full name');
      expect(AuthValidators.name('Jane Doe'), isNull);
    });

    test('otp validation', () {
      expect(AuthValidators.otp(null), 'Enter the verification code');
      expect(AuthValidators.otp('123'), 'Code must be 6 digits');
      expect(AuthValidators.otp('abcdef'), 'Code must be 6 digits');
      expect(AuthValidators.otp('123456'), isNull);
    });
  });
}
