// Mixins are used as re-usable methods and can be passed into other classes

// Usage:
class ValidationMixin {
  String validateEmail(String value) =>
      !value.contains('@') ? 'Please enter a valid email address' : null;

  String validatePassword(String value) =>
      value.length < 4 ? 'Password must be at least 4 characters' : null;
}
