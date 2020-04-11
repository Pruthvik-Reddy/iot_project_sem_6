import 'package:first_project/iot_proj/iot.dart';
import 'package:flutter/material.dart';
import 'ui/First.dart';
import 'boardapp/board_app.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'googlesignin/google_sign_in.dart';

//Stateless widgets are immutable=>they cannot change their states during the runyime of the app;"build" method can only be called once;
//Stateful widgets are mutable and can be drawn multiple times in their lifetime;

//void main() => runApp(First());
void main() => runApp(new MaterialApp(
  //home : scaffoldexample(),
  //home: wisdom(),
  //home: BillSplitter(),
  //home:sign_in(),
  theme: new ThemeData(
    primarySwatch: Colors.blue,
  ),
  home:sign_in_before(),
 )
);
