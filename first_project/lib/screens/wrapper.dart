import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'show_screen2.dart';
import 'authenticate/authenticate.dart';
import 'package:google_sign_in/google_sign_in.dart';


class wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    return FutureBuilder<FirebaseUser>(
        future: FirebaseAuth.instance.currentUser(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
          if(googleSignIn.currentUser==null)
            {
              return sign_in();
            }
          print(FirebaseAuth.instance.currentUser().toString());
          if (snapshot.hasData){
            FirebaseUser user = snapshot.data;
            print(user.displayName);// this is your user instance
            /// is because there is user already logged
            return second_screen2();
          }
          /// other way there is no user logged.
          return sign_in();
        }
    );
  }
}
