import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_rnd/features/authentication/data/models/user.dart';
import 'package:test_rnd/features/authentication/data_sources/authentication_remote_data_source.dart';
import 'package:test_rnd/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:mockito/annotations.dart';

import 'authentication_cubit_test.mocks.dart';

class MockAuthenticationRemoteData extends Mock
    implements AuthenticationRemoteData {}

@GenerateMocks([MockAuthenticationRemoteData])
void main() {
  late MockMockAuthenticationRemoteData mockAuthenticationRemoteData;

  late AuthenticationCubit authenticationCubit;
  setUp(() {
    mockAuthenticationRemoteData = MockMockAuthenticationRemoteData();
    authenticationCubit =
        AuthenticationCubit(client: mockAuthenticationRemoteData);
  });

  test('Should show and exception for invalid credentials', () async {
    //Arrange
    String email = '';
    String password = '';
    when(mockAuthenticationRemoteData.login(email: email, password: password))
        .thenThrow(Exception('invalid credentials'));

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
    when(mockAuthenticationRemoteData.login(email: email, password: password))
        .thenAnswer((_) => Future.value(User(age: 12, id: '1', name: 'John')));

    //Act
    await authenticationCubit.login(email: email, password: password);

    //Assert
    expect(authenticationCubit.state.status, LoginStatus.success);
    expect(authenticationCubit.state.user, isA<User>());
  });
}
