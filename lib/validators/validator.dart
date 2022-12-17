class Validator {
  static String? validateEmail(String email) {
    if (email.trim().isEmpty) {
      return "required_email";
    }

    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
    if (!emailValid) {
      return "enter_valid_email";
    }
    return null;
  }

  static String? validatePassword(String password) {
    if (password.trim().isEmpty) {
      return "required_password";
    }

    if (password.length < 8) {
      return "enter_valid_password";
    }

    return null;
  }
}
