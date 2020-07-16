import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:first_project/services/auth.dart';
import 'authenticate/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:first_project/boardapp/board_app.dart';
import 'package:first_project/util/hexcolor.dart';
import 'package:first_project/ui/First.dart';
import 'package:first_project/ui/card_list.dart';


// ignore: camel_case_types
class second_screen extends StatefulWidget {
  final String name;

  second_screen({Key key, this.name}) : super(key: key);

  @override
  _second_screenState createState() => _second_screenState();
}

class _second_screenState extends State<second_screen> {
  var cloudfirestoredb = Firestore.instance.collection("board").snapshots();

  final GoogleSignIn _googleSignIn = GoogleSignIn();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget cardtemplate(name,Nationality){
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Column(
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
              fontSize: 18.0,
              color:Colors.grey[500],
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            Nationality,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey[600],
            ),
          ),
          FlatButton(

          )

        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "National Security Agency",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 24.0),
        ),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        actions: <Widget>[
          new DropdownButton<String>(
            items: <String>['Sign Out'].map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            onChanged: (_) => logout(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: Icon(Icons.search),
      ),

      body: StreamBuilder(
          stream: cloudfirestoredb,

              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return new Text('Loading...');


                return new ListView(
                  children: snapshot.data.documents.map((document) {
                    return cardtemplate(document['Name'],document['Nationality']);
                  }).toList(),
                );



              },
       ),



          );


  }



  logout() {
    setState(() {
      //imageurl1 = null;
      _googleSignIn.signOut();
    });
    var router = new MaterialPageRoute(builder: (BuildContext context) {
      return new sign_in();
    });
    Navigator.of(context).push(router);
  }
}
