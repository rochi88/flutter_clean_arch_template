// Flutter imports:
import 'package:flutter/services.dart';

// EmailValidator
extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

// PhoneValidator
extension PhoneValidator on String {
  bool isValidPhone() {
    return RegExp(r'^[0-9]{10}$').hasMatch(this);
  }
}

// IFSC Validator
extension IFSCValidator on String {
  bool isValidIFSC() {
    return RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(this);
  }
}

// AadhaarValidator
extension AadhaarValidator on String {
  bool isValidAadhaar() {
    return RegExp(r'^[0-9]{12}$').hasMatch(this);
  }
}

// PanValidator
extension PanValidator on String {
  bool isValidPan() {
    return RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(this);
  }
}

// DrivingLicenceValidator
extension DrivingLicenceValidator on String {
  bool isValidDrivingLicence() {
    return RegExp(
            r'^(([A-Z]{2}[0-9]{2})( )|([A-Z]{2}-[0-9]{2}))((19|20)[0-9][0-9])[0-9]{7}$')
        .hasMatch(this);
  }
}

// Indian Password Validator
extension PassPortValidator on String {
  bool isValidPassPort() {
    return RegExp(r'^[A-PR-WY-Z][1-9]\\d\\s?\\d{4}[1-9]$').hasMatch(this);
  }
}

// Indian VoterId Validator
extension VoterIdValidator on String {
  bool isValidVoterId() {
    return RegExp(r'^[A-Z]{3}[0-9]{7}$').hasMatch(this);
  }
}

/// Credit Card Validators

var visaPattern = r'^(?:4[0-9]{12}(?:[0-9]{3})?)$';
var mastPattern = r'^(?:5[1-5][0-9]{14})$';
var amexPattern = r'^(?:3[47][0-9]{13})$';
var discPattern = r'^(?:6(?:011|5[0-9][0-9])[0-9]{12})$';

// UpperCaseTextFormatter
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

/// To Use This Extension
/// value.isValidEmail()
