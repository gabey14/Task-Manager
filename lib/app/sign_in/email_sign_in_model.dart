
import 'package:todo/app/sign_in/validators.dart';

enum EmailSIgnInFormType {signIn, register}

class EmailSignInModel with EmailAndPasswordValidators {
  EmailSignInModel({
    this.email = '',
     this.password = '',
      this.formType = EmailSIgnInFormType.signIn,
       this.isLoading = false,
        this.submitted = false,
   } );

  final String email;
  final String password;
  final EmailSIgnInFormType formType;
  final bool isLoading;
  final bool submitted;

  String get primaryButtonText {
   return formType == EmailSIgnInFormType.signIn ?
           'Sign in' : 'Create an account';
  }

  String get secondaryButtonText {
     return formType == EmailSIgnInFormType.signIn ?
          'Need an account? Register' : 'Have an account? Sign in';
  }

  bool get cansubmit {
     return emailValidator.isValid(email) &&
      passwordValidator.isValid(password) && !isLoading;
  }

  String get passwordErrorText {
   bool showErrorText = 
    submitted && !passwordValidator.isValid(password);
    return showErrorText ? invalidPasswordErrorText : null;
  }

  String get emailErrorText {
      bool showErrorText = 
      submitted && !emailValidator.isValid(email);
      return showErrorText ? invalidEmailErrorText : null;
  }

  EmailSignInModel copyWith({
    String email,
    String password,
    EmailSIgnInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    return EmailSignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted,

    );
  }

  //model.copywith(email:email)
}