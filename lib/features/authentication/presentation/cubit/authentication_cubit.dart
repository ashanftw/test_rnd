import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_rnd/features/authentication/data/models/user.dart';
import 'package:test_rnd/features/authentication/data/repository/authentiocation_repo.dart';
import 'package:test_rnd/features/authentication/data_sources/authentication_remote_data_source.dart';
import 'package:test_rnd/features/authentication/domain/authentication_domain.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  late AuthenticationRepo client;
  late AuthenticationDomain authentication;
  AuthenticationCubit({required this.client})
      : super(const AuthenticationState()) {
    authentication = AuthenticationDomain(client: client);
    //super(const AuthenticationState());
  }

  // AuthenticationCubit({required this.client})
  //     : super(const AuthenticationState());

  // AuthenticationRepo client;
  // AuthenticationDomain authentication = AuthenticationDomain(client: client);

  Future<void> login({required String email, required String password}) async {
    try {
      emit(state.copyWith(status: LoginStatus.loading));
      User user = await authentication.login(email: email, password: password);
      emit(state.copyWith(status: LoginStatus.success, user: user));
    } on Exception catch (error) {
      emit(state.copyWith(status: LoginStatus.failure, exception: error));
    }
  }
}
