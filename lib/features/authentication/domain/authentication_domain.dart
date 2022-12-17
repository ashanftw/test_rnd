import 'package:test_rnd/features/authentication/data/models/user.dart';
import 'package:test_rnd/features/authentication/data/repository/authentiocation_repo.dart';

class AuthenticationDomain implements AuthenticationRepo {
  final AuthenticationRepo client;
  AuthenticationDomain({required this.client});

  @override
  Future<User> login({required String email, required String password}) {
    return client.login(email: email, password: password);
  }
}
