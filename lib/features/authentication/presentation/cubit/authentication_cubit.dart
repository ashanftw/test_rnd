import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_rnd/features/authentication/data/models/user.dart';
import 'package:test_rnd/features/authentication/data_sources/authentication_remote_data_source.dart';
import 'package:test_rnd/features/authentication/domain/authentication_domain.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(const AuthenticationState());

  AuthenticationDomain authentication =
      AuthenticationDomain(AuthenticationRemoteData());

  void login({required String email, required String password}) async {
    try {
      emit(state.copyWith(status: LoginStatus.loading));
      User user = await authentication.login(email: email, password: password);
      emit(state.copyWith(status: LoginStatus.success, user: user));
    } on Exception catch (error) {
      emit(state.copyWith(status: LoginStatus.failure, exception: error));
    }
  }
}
