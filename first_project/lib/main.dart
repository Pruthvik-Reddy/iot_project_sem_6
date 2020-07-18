import 'package:first_project/iot_proj/iot.dart';
import 'package:flutter/material.dart';
import 'ui/First.dart';
import 'boardapp/board_app.dart';
import 'package:first_project/screens/default.dart';
import 'package:provider/provider.dart';
import 'package:first_project/services/auth.dart';
import 'models/user.dart';
import 'screens/wrapper.dart';

//Stateless widgets are immutable=>they cannot change their states during the runtime of the app;"build" method can only be called once;
//Stateful widgets are mutable and can be drawn multiple times in their lifetime;

//void main() => runApp(check());
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(StreamProvider<User>.value(
    value: AuthService().user,
    child:   new MaterialApp(
      //home : scaffoldexample(),
      //home: wisdom(),
      //home: BillSplitter(),
      //home:sign_in(),
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:sign_in_before(),
    ),
  )
  );
}
