import 'package:test_rnd/features/authentication/data/models/user.dart';
import 'package:test_rnd/features/authentication/data/repository/authentiocation_repo.dart';

class AuthenticationRemoteData implements AuthenticationRepo {
  @override
  Future<User> login({required String email, required String password}) async {
    if (email == 'mark@gmail.com' && password == 'mark123456') {
      return Future.value(User(age: 12, id: '003AF', name: 'Mark'));
    }

    throw Exception('invalid user credentials');
  }
}
