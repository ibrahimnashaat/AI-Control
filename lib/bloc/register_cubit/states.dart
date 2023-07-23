
abstract class RegisterStates {}

class RegisterInitialStates extends RegisterStates{}

class RegisterLoadingStates extends RegisterInitialStates {}

class RegisterSuccessStates extends RegisterInitialStates {}

class RegisterErrorStates extends RegisterInitialStates {
  late final String error;
  RegisterErrorStates(this.error);
}

class RegisterCreateUserSuccessStates extends RegisterInitialStates {

  late String uId;
  RegisterCreateUserSuccessStates ({required this.uId});
}

class RegisterCreateUserErrorStates extends RegisterInitialStates {
  late final String error;
  RegisterCreateUserErrorStates(this.error);
}

class PasswordStates extends RegisterInitialStates {}