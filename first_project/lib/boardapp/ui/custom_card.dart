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



    return Column(
      children: <Widget>[
       Text("People Entered into the AirPort",style: TextStyle( fontSize: 17.0,color: Colors.greenAccent),),
        Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                ),


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

                  ),
                ]
                ),
                )
                )

                  ],
                );



  }
}