class Validator {
  static String validateEmail(String email) {
    if (email == null || email.isEmpty)
      return "Empty field not valid";
    else if (_checkInvalidEmail(email))
      return "Invalid email address";
    else
      return null;
  }

  static bool _checkInvalidEmail(String email) {
    RegExp regExp = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return !regExp.hasMatch(email);
  }

  static String validatePassword(String password) {
    if (password == null || password.isEmpty)
      return "Empty field not valid";
    else if (password.length < 8)
      return 'Invalid password less than 8 characters';
    else if (!password.contains(RegExp(r'[a-zA-Z]')))
      return 'Password must contains characters';
    else if (!password.contains(RegExp(r'[0-9]')))
      return 'Password must contains numbers';
    else
      return null;
  }

  static String validatePhoneNumber(String phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty)
      return "Empty field not valid";
    else if (!RegExp(r"(01)[0-9]{9,9}$").hasMatch(phoneNumber))
      return 'Invalid phone number';
    else
      return null;
  }

  static String validateUserName(String userName) {
    if (userName == null || userName.isEmpty)
      return "Empty field not valid";
    else
      return null;
  }

  static String validateBirthDate(String birthdate) {
    if (birthdate == null || birthdate.isEmpty)
      return "Empty field not valid";
    else if (_checkIfNotAllowedAge(birthdate))
      return "Not allowed for users under 18 years old";
    else
      return null;
  }

  static bool _checkIfNotAllowedAge(String birthdate) {
    DateTime currentDate = DateTime.now();
    DateTime userBirthDate = DateTime.parse(birthdate);
    int userAge = (currentDate.difference(userBirthDate).inDays) ~/ 365;
    int allowedAge = 18;
    return userAge < allowedAge;
  }
}
