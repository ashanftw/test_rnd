import 'package:flutter_test/flutter_test.dart';
import 'package:test_rnd/features/authentication/data/models/user.dart';
import 'package:test_rnd/features/authentication/data_sources/authentication_remote_data_source.dart';
import 'package:test_rnd/features/authentication/domain/authentication_domain.dart';

void main() {
  late AuthenticationDomain authentication;
  setUp(() {
    authentication = AuthenticationDomain(AuthenticationRemoteData());
  });

  test('should throw an execption for invalid email and password', () {
    //Arrange
    String email = '';
    String password = '';

    //Act
    var result = authentication.login(email: email, password: password);

    //Assert
    expect(result, throwsException);
  });

  test('should return user model for correct email and password', () async {
    //Arrange
    String email = 'mark@gmail.com';
    String password = 'mark123';

    //Act
    var result = await authentication.login(email: email, password: password);

    //Assert
    expect(result, isA<User>());
  });
}
