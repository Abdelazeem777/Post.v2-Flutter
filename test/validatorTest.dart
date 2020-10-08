import 'package:flutter_test/flutter_test.dart';
import 'package:post/utils/validator.dart';

main() {
  //Email validator test cases
  test('add empty email', () {
    String email = '';
    var result = Validator.validateEmail(email);
    expect(result, 'Empty field not valid');
  });
  test('add null value to email validator', () {
    String email;
    var result = Validator.validateEmail(email);
    expect(result, 'Empty field not valid');
  });
  test('add invalid email', () {
    String email = 'abdelazeemgmail.com';
    var result = Validator.validateEmail(email);
    expect(result, 'Invalid email address');
  });
  test('add invalid email', () {
    String email = 'abdelazeem@gmailcom';
    var result = Validator.validateEmail(email);
    expect(result, 'Invalid email address');
  });
  test('add valid email', () {
    String email = 'abdelazeem@gmail.com';
    var result = Validator.validateEmail(email);
    expect(result, null);
  });

  //Password validator test cases
  test('add empty password', () {
    String password = '';
    var result = Validator.validatePassword(password);
    expect(result, 'Empty field not valid');
  });
  test('add null value to password validator', () {
    String password;
    var result = Validator.validatePassword(password);
    expect(result, 'Empty field not valid');
  });
  test('add invalid password less than 8 digits', () {
    String password = '3333';
    var result = Validator.validatePassword(password);
    expect(result, 'Invalid password less than 8 characters');
  });
  test('add invalid password not containing chars ', () {
    String password = '15162634562323';
    var result = Validator.validatePassword(password);
    expect(result, 'Password must contains characters');
  });
  test('add invalid password not contains numbers ', () {
    String password = 'fkjshdjkfhsjkhdfkjsd';
    var result = Validator.validatePassword(password);
    expect(result, 'Password must contains numbers');
  });
  test('add valid password', () {
    String password = '12345abcde';
    var result = Validator.validatePassword(password);
    expect(result, null);
  });

  //Phone number validator test cases
  test('add empty phone number', () {
    String phoneNumber = '';
    var result = Validator.validatePhoneNumber(phoneNumber);
    expect(result, 'Empty field not valid');
  });
  test('add null value to phone number validator', () {
    String phoneNumber;
    var result = Validator.validatePhoneNumber(phoneNumber);
    expect(result, 'Empty field not valid');
  });
  test('add invalid phone number', () {
    String phoneNumber = '0111856310613';
    var result = Validator.validatePhoneNumber(phoneNumber);
    expect(result, 'Invalid phone number');
  });
  test('add invalid phone number', () {
    String phoneNumber = '011185a63106';
    var result = Validator.validatePhoneNumber(phoneNumber);
    expect(result, 'Invalid phone number');
  });
  test('add invalid phone number', () {
    String phoneNumber = '011185a63106';
    var result = Validator.validatePhoneNumber(phoneNumber);
    expect(result, 'Invalid phone number');
  });
  test('add valid phone number', () {
    String phoneNumber = '01118563106';
    var result = Validator.validatePhoneNumber(phoneNumber);
    expect(result, null);
  });

//Username validator test cases
  test('add empty userName', () {
    String userName = '';
    var result = Validator.validateUserName(userName);
    expect(result, 'Empty field not valid');
  });
  test('add null value to userName validator', () {
    String userName;
    var result = Validator.validateUserName(userName);
    expect(result, 'Empty field not valid');
  });

  test('add valid userName', () {
    String userName = 'Abdelazeem Kuratem';
    var result = Validator.validateUserName(userName);
    expect(result, null);
  });

//BirthDate validator test cases
  test('add empty birthDate', () {
    String birthDate = '';
    var result = Validator.validateBirthDate(birthDate);
    expect(result, 'Empty field not valid');
  });
  test('add null value to birthDate validator', () {
    String birthDate;
    var result = Validator.validateBirthDate(birthDate);
    expect(result, 'Empty field not valid');
  });

  test('add invalid birthDate for user younger than 18 years old', () {
    int _17YearsToDays = 356 * 17;
    DateTime birthDateOfUserWhoIs17YearsOld =
        DateTime.now().subtract(Duration(days: _17YearsToDays));
    String birthDateString = birthDateOfUserWhoIs17YearsOld.toString();
    var result = Validator.validateBirthDate(birthDateString);
    expect(result, "Not allowed for users under 18 years old");
  });

  test('add valid birthDate', () {
    int _21YearsToDays = 356 * 21;
    DateTime birthDateOfUserWhoIs21YearsOld =
        DateTime.now().subtract(Duration(days: _21YearsToDays));
    String birthDateString = birthDateOfUserWhoIs21YearsOld.toString();
    var result = Validator.validateBirthDate(birthDateString);
    expect(result, null);
  });
}
