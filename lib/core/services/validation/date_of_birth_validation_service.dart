String? dateOfBirthValid ({String? dateOfBirth}){
  if(dateOfBirth == null || dateOfBirth.isEmpty){
    return 'Date of Birth is required';
  }
  else if (dateOfBirth.isNotEmpty){
    final DateTime date = DateTime.parse(dateOfBirth);
    final age = DateTime.now().difference(date).inDays ~/ 365;
    if(age < 18){
      return 'You must be at least 18 years old';
    }
    return null;
  }
  return null;
}