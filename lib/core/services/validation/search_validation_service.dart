String? searchValid({required String? value,}) {
  if (value == null || value.isEmpty) {
    return 'Please enter a search term.';
  }
  return null;
}