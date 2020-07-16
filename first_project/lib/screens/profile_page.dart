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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Detail'
        ),
      ),
      body: ListView(
        children: <Widget>[
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
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}