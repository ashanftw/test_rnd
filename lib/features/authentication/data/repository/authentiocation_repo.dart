import 'package:test_rnd/features/authentication/data/models/user.dart';

abstract class AuthenticationRepo {
  Future<User> login({required String email, required String password});
}
