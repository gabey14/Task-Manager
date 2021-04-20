
import 'package:flutter/material.dart';
import 'package:todo/app/sign_in/email_sign_in_model.dart';
import 'package:todo/app/sign_in/validators.dart';
import 'package:todo/services/auth.dart';



class EmailSignInChangeModel with EmailAndPasswordValidators, ChangeNotifier {
  EmailSignInChangeModel({
    @required this.auth,
    this.email = '',
     this.password = '',
      this.formType = EmailSIgnInFormType.signIn,
       this.isLoading = false,
        this.submitted = false,
   } );
   final AuthBase auth;

   String email;
   String password;
   EmailSIgnInFormType formType;
   bool isLoading;
   bool submitted;

   Future<void> submit() async {
     
     updateWith(submitted: true, isLoading: true);
     
     try{
       
     if (formType == EmailSIgnInFormType.signIn) {
       await auth.signInWithEmailAndPassword(email, password);
     } else {
       await auth.createUserWithEmailAndPassword(email,password);
     }
   
     }catch (e) {
       updateWith(isLoading: false);
       rethrow;
     } 
   }

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

void toggleFormType() {
      final formType = this.formType == EmailSIgnInFormType.signIn ?
        EmailSIgnInFormType.register : EmailSIgnInFormType.signIn;
      updateWith(
          email: '',
          password: '',
          formType: formType,
        isLoading: false,
        submitted: false,
      );
    }


  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String password) => updateWith(password: password);

  void updateWith({
    String email,
    String password,
    EmailSIgnInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    
      this.email = email ?? this.email;
      this.password = password ?? this.password;
      this.formType = formType ?? this.formType;
      this.isLoading = isLoading ?? this.isLoading;
      this.submitted = submitted ?? this.submitted;
      notifyListeners();
    
  }

  //model.copywith(email:email)
}