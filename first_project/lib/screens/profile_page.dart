import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class profile_page extends StatefulWidget {
  final docid;
  profile_page(this.docid);
  @override
  _MyHomePageState createState() => _MyHomePageState(docid);
}

class _MyHomePageState extends State<profile_page> {

  final docid;

  _MyHomePageState(this.docid);
  var dates= Firestore.instance.collection("board").document("docid").collection("Dates").snapshots();

  @override

  Widget cardtemplate(name) {
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Column(
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 6.0),

        ],
      ),
    );
  }

    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Detail'
        ),
      ),
      body: ListView(
        children: <Widget>[
          StreamBuilder(
            stream: Firestore.instance.collection("board").document(docid).collection("Dates").snapshots(),

            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return new Text('Loading...');


              return new Column(
                children: snapshot.data.documents.map((document) {
                  List<String> date_list = List.from(document['Date']);
                  print(date_list);
                  return cardtemplate(date_list[0]);
                }).toList(),
              );



            },
          ),

          StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance.collection('board').document(docid).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              if (!snapshot.hasData) return Container(
                child: Center(
                    child: CircularProgressIndicator()
                ),
              );
              return Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      snapshot.data['Name'],
                      style: TextStyle(
                          fontSize: 24.0
                      ),
                    ),
                  ),

                  Container(
                      child: Text(
                          snapshot.data['Nationality']
                      )
                  ),

                ],
              );
            },

          ),




        ],
      ),
    );
  }
}