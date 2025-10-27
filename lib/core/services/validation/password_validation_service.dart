String? isPasswordValid({String? password}) {
  if (password== null || password.isEmpty ) {
    return 'Password is required';
  }
  else if (password.length > 50) {
    return 'Password can\'t be larger than 50 digit';
  }
  else if (password.length < 6) {
    return 'Password can be at least 6 digit';
  }
  return null;
}