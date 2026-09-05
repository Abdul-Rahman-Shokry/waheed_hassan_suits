class AppValidators {
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final email = value.trim();

    if (email.length > 254) {
      return 'Email must not exceed 254 characters';
    }

    final parts = email.split('@');
    if (parts.length != 2) {
      return 'Please enter a valid email address';
    }

    final localPart = parts[0];
    final domainPart = parts[1];

    if (localPart.isEmpty || localPart.length > 64) {
      return 'Please enter a valid email address';
    }

    if (domainPart.isEmpty || domainPart.length > 255) {
      return 'Please enter a valid email address';
    }

    final localRegex = RegExp(r'^[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)*$');
    if (!localRegex.hasMatch(localPart)) {
      return 'Please enter a valid email address';
    }

    final domainRegex = RegExp(
      r'^[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?(\.[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?)+$',
    );
    if (!domainRegex.hasMatch(domainPart)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one digit';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=]').hasMatch(value)) {
      return 'Password must contain at least one special symbol';
    }
    return null;
  }
}