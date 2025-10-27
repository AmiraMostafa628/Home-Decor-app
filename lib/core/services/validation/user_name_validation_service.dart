String? isUserNameValid({String? userName}) {
  if (userName == null || userName.isEmpty) {
    return 'Username is required';
  }
  else if (userName.length > 30) {
    return 'Username can\'t be larger than 30 letter';
  }
  else if (userName.length < 2) {
    return 'Username can\'t be less than 2 letter';
  }

  return null;
}