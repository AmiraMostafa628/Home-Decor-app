String? matchPassword({required String? value, required String password}) {
  if (value == null || value.isEmpty) {
    return 'Confirm password is required';
  }
  else if (value != password) {
    return 'Passwords do not match';
  }
  return null;
}