import 'package:flutter_test/flutter_test.dart';
import 'package:test_rnd/validators/validator.dart';

void main() {
  test("validate for empty email", () {
    // Arrange
    String email = "";
    // Act
    String? result = Validator.validateEmail(email);
    // Assert
    expect(result, "required_email");
  });

  test("validate for invalid email", () {
    // Arrange
    String email = "john mur";
    // Act
    String? result = Validator.validateEmail(email);
    // Assert
    expect(result, "enter_valid_email");
  });

  test("validate for valid email", () {
    // Arrange
    String email = "abc@gmail.com";
    // Act
    String? result = Validator.validateEmail(email);
    // Assert
    expect(result, null);
  });

  test("validate for empty password", () {
    // Arrange
    String password = "";
    // Act
    String? result = Validator.validatePassword(password);
    // Assert
    expect(result, "required_password");
  });

  test("validate for invalid password", () {
    // Arrange
    String password = "1234567";
    // Act
    String? result = Validator.validatePassword(password);
    // Assert
    expect(result, "enter_valid_password");
  });

  test("validate for valid password", () {
    // Arrange
    String password = "12345678";
    // Act
    String? result = Validator.validatePassword(password);
    // Assert
    expect(result, null);
  });
}
