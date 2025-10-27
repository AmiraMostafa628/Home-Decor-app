String? isMobileNumberValid({String? mobileNumber}) {
  if (mobileNumber == null ||mobileNumber.isEmpty) {
    return 'Mobile Number is required';
  }
  else if (mobileNumber.length > 11) {
    return 'Mobile Number can\'t be larger than 11 digits';
  }
  else if (mobileNumber.length <11) {
    return 'Mobile Number can\'t be less than 11 digits';
  }
  return null;
}