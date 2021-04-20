import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/common_widgets/custom_raised_button.dart';

class SocialSignInButton extends CustomRaisedButton {

    SocialSignInButton( {
      @required String assetName,
       String text,
        Color color,
        Color textColor,
       VoidCallback onPressed,
    // ignore: unnecessary_null_comparison
    }) :  assert(assetName != null),
           // ignore: unnecessary_null_comparison
           assert(text != null),
       super(
          child:  Row( 
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset(assetName),
                      Text(
                        text,
                        style: TextStyle(color: textColor, fontSize: 15.0),
                      ),
                      Opacity(
                        opacity: 0.0,
                        child: Image.asset('images/google-logo.png'),
                      ),
                    ],
                  ),

        color: color,
        height: 40.0,
        onPressed: onPressed,
    );

}