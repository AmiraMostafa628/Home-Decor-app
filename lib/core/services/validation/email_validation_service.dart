String? isEmailValid({String? email}) {
  if (email != null){
    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
      return null;
    } else {
      return 'Enter a valid email';
    }
  }else{
    return null;
  }

}