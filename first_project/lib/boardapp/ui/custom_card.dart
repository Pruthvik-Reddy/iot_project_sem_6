import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class CustomCard extends StatelessWidget {
  final QuerySnapshot snapshot;
  final int index;

  const CustomCard({Key key, this.snapshot, this.index}) : super(key: key);



  @override
  Widget build(BuildContext context) {



    var snapshotData = snapshot.documents[index].data;
    var docId = snapshot.documents[index].documentID;

    TextEditingController NameInputController = TextEditingController(text: snapshotData["Name"]);
    TextEditingController AddressInputController = TextEditingController(text: snapshotData["Address"]);
    TextEditingController Criminal_HistoryInputController = TextEditingController(text: snapshotData["Criminal History"]);
    TextEditingController possible_threatInputController = TextEditingController(text: snapshotData["Possible Threat"]);



    return Column(
      children: <Widget>[
       Text("People Entered into the AirPort",style: TextStyle( fontSize: 17.0,color: Colors.greenAccent),),
        Container(
          height: 190,
          //child:Text("People Entered into the AirPort",style: TextStyle( fontSize: 17.0,color: Colors.greenAccent),),
          child: Card(
            elevation: 9,
            child: Column(
              children: <Widget>[
               // Text("People Entered into the AirPort",style: TextStyle( fontSize: 17.0,color: Colors.greenAccent),),
                ListTile(
                  title: Text(snapshotData["Name"] ?? " ") ,
                  subtitle: Text(snapshotData["Address"]),
                  leading: CircleAvatar(
                    radius: 34,
                    child: Text(snapshotData["Criminal_History"].toString()[0]),

                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(" Criminal History: ${snapshotData["Criminal History"]} "),
                      Text(" Possible Threat: ${snapshotData["Possible Threat"]} ")

                    ],
                  ),
                ),

                //Add Row with Edit and Update Icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(icon: Icon(FontAwesomeIcons.mapMarked, size: 15,),
                        onPressed: () async {
                          await showDialog(context: context,
                              child: AlertDialog(
                                contentPadding: EdgeInsets.all(10),
                                content: Column(
                                  children: <Widget>[
                                    Text("Please fill out the form to Update."),
                                    Expanded(
                                        child: TextField(
                                          autofocus: true,
                                          autocorrect: true,
                                          decoration: InputDecoration(
                                              labelText: "Name"
                                          ),
                                          controller: NameInputController,

                                        )),

                                    Expanded(
                                        child: TextField(
                                          autofocus: true,
                                          autocorrect: true,
                                          decoration: InputDecoration(
                                              labelText: "Anything Suspicious?"
                                          ),
                                          controller: AddressInputController,

                                        )),

                                    Expanded(
                                        child: TextField(
                                          autofocus: true,
                                          autocorrect: true,
                                          decoration: InputDecoration(
                                            labelText: "Mark as Red Flag",

                                          ),
                                          controller: Criminal_HistoryInputController,

                                        )),


                                  ],
                                ),
                                actions: <Widget>[
                                  FlatButton(onPressed: () {
                                    NameInputController.clear();
                                    AddressInputController.clear();
                                    Criminal_HistoryInputController.clear();
                                    possible_threatInputController.clear();

                                    Navigator.pop(context);
                                  } ,
                                      child: Text("Cancel")),

                                  FlatButton(onPressed: () {
                                    if( AddressInputController.text.isNotEmpty &&
                                        NameInputController.text.isNotEmpty &&
                                       Criminal_HistoryInputController.text.isNotEmpty &&
                                        possible_threatInputController.text.isNotEmpty) {

                                      Firestore.instance.collection("board")
                                          .document(docId)
                                          .updateData({
                                        "Name" : NameInputController.text,
                                        "Address" : AddressInputController.text,
                                        "Criminal History" : Criminal_HistoryInputController.text,
                                        "Possible Threat" : possible_threatInputController.text,
                                      }).then((response) {
                                        Navigator.pop(context);
                                      });

//                                    Firestore.instance.collection("board")
//                                        .add({
//                                      "Name" : NameInputController.text,
//                                      "Address" : AddressInputController.text,
//                                      "Criminal History" : Criminal_HistoryInputController.text,
                                     //   "Possible Threat" : possible_threatInputController.text,
//                                      "timestamp" : new DateTime.now()
//                                    }).then((response) {
//                                      print(response.documentID);
//                                      Navigator.pop(context);
//                                      NameInputController.clear();
//                                      AddressInputController.clear();
//Criminal_HistoryInputController.clear();
//
//                                    }).catchError((error) => print(error));
                                    }
                                  },
                                      child: Text("Update"))
                                ],

                              ));

                        }),

                    SizedBox(height: 19,),

                    IconButton(icon: Icon(FontAwesomeIcons.trashAlt, size: 15,),
                        onPressed: () async {
                          var collectionReference = Firestore.instance.collection("board");
                          await collectionReference
                              .document(docId)
                              .delete();



                        })
                  ],
                )

                //Text(snapshot.documents[index].data["title"])
              ],
            ),
          ),
        ),


      ],


    );
  }
}