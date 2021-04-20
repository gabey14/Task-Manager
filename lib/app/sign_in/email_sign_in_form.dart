

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/sign_in/email_sign_in_model.dart';
import 'package:todo/app/sign_in/validators.dart';
import 'package:todo/common_widgets/form_submit_button.dart';
import 'package:todo/common_widgets/show_exception_alert_dialog.dart';
import 'package:todo/services/auth.dart';






class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
 

    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final FocusNode _emailFocusNode = FocusNode();
    final FocusNode _passwordFocusNode = FocusNode();
    
    String get _email => _emailController.text;
    String get _password => _passwordController.text;
    EmailSIgnInFormType _formType = EmailSIgnInFormType.signIn;
    bool _submitted = false;
    bool _isLoading = false;

  @override
   void dispose() {
     _emailController.dispose();
     _passwordController.dispose();
     _emailFocusNode.dispose();
     _passwordFocusNode.dispose();
     super.dispose();
   }

   Future<void> _submit() async {
     
     setState(() {
       _submitted = true;
      _isLoading = true;

     });
     try{
        final auth = Provider.of<AuthBase>(context, listen: false);
     if (_formType == EmailSIgnInFormType.signIn) {
       await auth.signInWithEmailAndPassword(_email, _password);
     } else {
       await auth.createUserWithEmailAndPassword(_email, _password);
     }
     Navigator.of(context).pop();
     } on FirebaseAuthException catch (e) {
       showExceptionAlertDialog(
         context,
         title: 'Sign in failed',
         exception: e,
       );
     } finally {
       setState(() {
         _isLoading = false;
       });
     }
    
   }

   void _emailEditingComplete() {
     final newFocus = widget.emailValidator.isValid(_email)
     ? _passwordFocusNode
      : _emailFocusNode;
     FocusScope.of(context).requestFocus(_passwordFocusNode);
     FocusScope.of(context).requestFocus(newFocus);
   }

    void _toggleFormType() {
      setState(() {
        _submitted = false;
        _formType = _formType == EmailSIgnInFormType.signIn ?
        EmailSIgnInFormType.register : EmailSIgnInFormType.signIn;
      });
      _emailController.clear();
      _passwordController.clear();
    }



  List<Widget> _buildChildren() {
      final primaryText = _formType == EmailSIgnInFormType.signIn ?
           'Sign in' : 'Create an account';
      final secondaryText = _formType == EmailSIgnInFormType.signIn ?
          'Need an account? Register' : 'Have an account? Sign in';  

      bool submitEnabled = widget.emailValidator.isValid(_email) &&
      widget.passwordValidator.isValid(_password) && !_isLoading;
     


      return [
        _buildEmailTextField(),
        SizedBox(height: 8.0),
        _buildPasswordTextField(),
        SizedBox(height: 8.0),
        FormSubmitButton(
          text: primaryText,
          onPressed: submitEnabled ? _submit : null,
        ),
        SizedBox(height: 8.0),
        FlatButton(
          child: Text(secondaryText),
          onPressed: !_isLoading ?  _toggleFormType : null,
        ),
      ];
  }

  TextField _buildPasswordTextField() {
    bool showErrorText = _submitted && !widget.passwordValidator.isValid(_password);
    return TextField(
        controller: _passwordController,
        focusNode: _passwordFocusNode,
        decoration: InputDecoration(
          labelText: 'Password',
          errorText: showErrorText ? widget.invalidPasswordErrorText : null,
          enabled: _isLoading == false,
         ),
         obscureText: true,
         textInputAction: TextInputAction.done,
         onChanged: (password) =>  _updateState(),
         onEditingComplete: _submit,
      );
  }

  TextField _buildEmailTextField() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
        controller: _emailController,
        focusNode: _emailFocusNode,
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'test@test.com',
            errorText: showErrorText ?  widget.invalidEmailErrorText : null ,
            enabled: _isLoading == false,
          ),
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onChanged: (email) => _updateState(),
                    onEditingComplete: _emailEditingComplete,
                );
            }
          
          
          
            @override
            Widget build(BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch ,
                mainAxisSize: MainAxisSize.min,
                children: _buildChildren(),
              ),
              );
            }
          
          void  _updateState() {
           
              setState(() {});
            }
}