import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'authenticate/authenticate.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'profile_page.dart';
import 'package:intl/intl.dart';
import 'package:first_project/syncfusion/bar_chart.dart';
import 'package:first_project/syncfusion/month.dart';
import 'package:first_project/syncfusion/years.dart';
import 'package:first_project/syncfusion/country_chart.dart';
import 'stats_monitor.dart';

// ignore: camel_case_types
class second_screen2 extends StatefulWidget {
  final String name;

  second_screen2({Key key, this.name}) : super(key: key);

  @override
  _second_screenState2 createState() => _second_screenState2();
}

class _second_screenState2 extends State<second_screen2> {
  var cloudfirestoredb = Firestore.instance.collection("board").where("present",isEqualTo: "True").snapshots();
  //print("FME");

  final GoogleSignIn _googleSignIn = GoogleSignIn();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    function_1();

  }


  function_1() async{
    QuerySnapshot snap_2=await Firestore.instance.collection("board").where("present",isEqualTo: "True").getDocuments();
    var lis_1=snap_2.documents;
    for(int i=0;i<lis_1.length;i++)
    {
      var doc_id=lis_1[i].documentID;
      var now= new DateTime.now();
      var formatter=new DateFormat('MM/dd/yyyy');
      String formatdate = formatter.format(now);
      var date_to_be_added=[formatdate];

      QuerySnapshot snap_3=await Firestore.instance.collection("board").document(doc_id).collection("Dates").getDocuments();
      var lis_2=snap_3.documents;
      //print(lis_2[0].documentID);

      DocumentReference doc_ref=Firestore.instance.collection("board").document(doc_id).collection("Dates").document();
      var doc_id5= await get_data(doc_ref);
      //print(doc_id5);
      Firestore.instance.collection("board").document(doc_id).collection("Dates").document(lis_2[0].documentID).updateData({"Date":FieldValue.arrayUnion(date_to_be_added)});


    }
  }

  Widget cardtemplate(name,Nationality,docid){
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Row(
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
            child: Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
            color: Color.fromRGBO(68, 153, 213, 1.0),
            shape: CircleBorder(),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> profile_page(docid)));
            },

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
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> stats_monitor()));

        },
        child: Icon(Icons.search),
      ),

      body: StreamBuilder (
        stream: cloudfirestoredb,


        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return new Text('Loading...');


          return new ListView(

            children: snapshot.data.documents.map((document) {


              var doc_id=document.documentID;
              return cardtemplate(document['Name'], document['Nationality'], doc_id);

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

Future<String> get_data(DocumentReference doc_ref) async{
  DocumentSnapshot docSnap = await doc_ref.get();


  var doc_id2 =  docSnap.reference.documentID;
  //setState(() => doc_id4 = doc_id2);

  return doc_id2;
}

get_data1(String doc_id) async{
  var doc_ref = await Firestore.instance.collection("board")
      .document(doc_id)
      .collection("Dates")
      .getDocuments();
  doc_ref.documents.forEach((result) {
    return result.documentID;
  });
}




