import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:first_project/services/auth.dart';
import 'authenticate/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:first_project/boardapp/board_app.dart';
import 'package:first_project/util/hexcolor.dart';
import 'package:first_project/ui/First.dart';
import 'package:first_project/boardapp/ui/custom_card.dart';


// ignore: camel_case_types
class second_screen extends StatefulWidget {
  final String name;

  second_screen({Key key, this.name}) : super(key: key);

  @override
  _second_screenState createState() => _second_screenState();
}

class _second_screenState extends State<second_screen> {
  var cloudfirestoredb = Firestore.instance.collection("board").snapshots();
  TextEditingController NameInputController;
  TextEditingController AddressInputController;
  TextEditingController Criminal_HistoryInputController;
  TextEditingController possible_threatInputController;

  final GoogleSignIn _googleSignIn = GoogleSignIn();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NameInputController = TextEditingController();
    AddressInputController = TextEditingController();
    Criminal_HistoryInputController = TextEditingController();
    possible_threatInputController = TextEditingController();
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
          _showDialog(context);
        },
        child: Icon(Icons.search),
      ),
      body: StreamBuilder(
          stream: cloudfirestoredb,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, int index) {
                  var t = CustomCard(
                      snapshot: snapshot.data ?? " nc", index: index ?? " vsd");
                  return t ?? " ";
                  //return Text(snapshot.data.documents[index]['description'] ?? " ");
                });
          }),
    );
  }

  _showDialog(BuildContext context) async {
    await showDialog(
        context: context,
        child: AlertDialog(
          contentPadding: EdgeInsets.all(10),
          content: Column(
            children: <Widget>[
              Text("Please fill out the form."),
              Expanded(
                  child: TextField(
                    autofocus: true,
                    autocorrect: true,
                    decoration: InputDecoration(labelText: " Name*"),
                    controller: NameInputController,
                  )),
              Expanded(
                  child: TextField(
                    autofocus: true,
                    autocorrect: true,
                    decoration: InputDecoration(labelText: "Address"),
                    controller: AddressInputController,
                  )),
              Expanded(
                  child: TextField(
                    autofocus: true,
                    autocorrect: true,
                    decoration: InputDecoration(labelText: "Criminal History*"),
                    controller: Criminal_HistoryInputController,
                  )),
              Expanded(
                  child: TextField(
                    autofocus: true,
                    autocorrect: true,
                    decoration: InputDecoration(labelText: "Possible Threat"),
                    controller: possible_threatInputController,
                  )),
            ],
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  NameInputController.clear();
                  AddressInputController.clear();
                  Criminal_HistoryInputController.clear();
                  possible_threatInputController.clear();

                  Navigator.pop(context);
                },
                child: Text("Cancel")),
            FlatButton(
                onPressed: () {
                  if (NameInputController.text.isNotEmpty &&
                      AddressInputController.text.isNotEmpty &&
                      Criminal_HistoryInputController.text.isNotEmpty &&
                      possible_threatInputController.text.isNotEmpty) {
                    Firestore.instance.collection("board").add({
                      "Name": NameInputController.text,
                      "Address": AddressInputController.text,
                      "Criminal History": Criminal_HistoryInputController.text,
                      "Possible Threat": possible_threatInputController.text,
                    }).then((response) {
                      print(response.documentID);
                      Navigator.pop(context);
                      NameInputController.clear();
                      AddressInputController.clear();
                      Criminal_HistoryInputController.clear();
                      possible_threatInputController.clear();
                    }).catchError((error) => print(error));
                  }
                },
                child: Text("Save"))
          ],
        ));
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
