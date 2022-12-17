import 'package:flutter/material.dart';
import 'package:test_rnd/validators/validator.dart';

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
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: txtEmail,
              validator: (value) => Validator.validateEmail(value!),
            ),
            TextFormField(
              controller: txtPassword,
              validator: (value) => Validator.validatePassword(value!),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {}
              },
              child: const Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}
