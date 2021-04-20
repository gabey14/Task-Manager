import 'package:flutter/material.dart';

import 'package:todo/app/sign_in/email_sign_in_form_bloc_based.dart';


class EmailSignInPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Sign In With Email'),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
       child: Card(
      child: EmailSignInFormBlocBased.create(context),
      ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }


}