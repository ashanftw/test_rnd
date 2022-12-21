import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_rnd/features/authentication/data/repository/authentiocation_repo.dart';
import 'package:test_rnd/features/authentication/data_sources/authentication_remote_data_source.dart';
import 'package:test_rnd/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:test_rnd/features/dashboard/data_sources/product_remote_data_source.dart';
import 'package:test_rnd/features/dashboard/presentation/home_screen.dart';
import 'package:test_rnd/validators/validator.dart';
import 'package:http/http.dart' as http;

import '../../dashboard/presentation/cubit/dashboard_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();

  @override
  void dispose() {
    txtEmail.dispose();
    txtPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthenticationCubit(client: AuthenticationRemoteData()),
      child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, authState) {
          if (authState.status == LoginStatus.success) {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => HomeScreen())));
          }
        },
        builder: (context, authState) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    key: const Key('email_id'),
                    controller: txtEmail,
                    validator: (value) => Validator.validateEmail(value!),
                  ),
                  TextFormField(
                    key: const Key('password'),
                    controller: txtPassword,
                    validator: (value) => Validator.validatePassword(value!),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthenticationCubit>().login(
                            email: txtEmail.text, password: txtPassword.text);
                      }
                    },
                    child: const Text('Login'),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
