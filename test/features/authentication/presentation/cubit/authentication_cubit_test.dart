import 'package:flutter_test/flutter_test.dart';
import 'package:test_rnd/features/authentication/data/models/user.dart';
import 'package:test_rnd/features/authentication/data_sources/authentication_remote_data_source.dart';
import 'package:test_rnd/features/authentication/presentation/cubit/authentication_cubit.dart';

void main() {
  late AuthenticationCubit authenticationCubit;
  setUp(() {
    authenticationCubit =
        AuthenticationCubit(client: AuthenticationRemoteData());
  });

  test('Should show and exception for invalid credentials', () async {
    //Arrange
    String email = '';
    String password = '';

    //Act
    await authenticationCubit.login(email: email, password: password);

    //Assert
    expect(authenticationCubit.state.status, LoginStatus.failure);
    expect(authenticationCubit.state.exception, isA<Exception>());
  });

  test('Should get user details for valid credentials', () async {
    //Arrange
    String email = 'mark@gmail.com';
    String password = 'mark123';

    //Act
    await authenticationCubit.login(email: email, password: password);

    //Assert
    expect(authenticationCubit.state.status, LoginStatus.success);
    expect(authenticationCubit.state.user, isA<User>());
  });
}
