import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';



class profile_page extends StatefulWidget {
  final docid;
  profile_page(this.docid);
  @override
  _MyHomePageState createState() => _MyHomePageState(docid);
}

class _MyHomePageState extends State<profile_page> {

  final docid;
  var info_map=new Map();
  _MyHomePageState(this.docid);
  //var dates= Firestore.instance.collection("board").document("docid").collection("Dates").snapshots();

  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    //function_1();

  }
  Future<Map> function_2() async{
    QuerySnapshot snap_2 = await Firestore.instance.collection("board")
        .getDocuments();
    var lis_1 = snap_2.documents;
    for (int i = 0; i < lis_1.length; i++) {
      var check_id=lis_1[i].documentID;
      if(check_id==docid)
      {
        var exp=lis_1[i];
        info_map["Name"]=exp["Name"];
        info_map["Nationality"]=exp["Nationality"];
        info_map["City"]=exp["City"];
        info_map["Date Of Birth"]=exp["Date Of Birth"];
        info_map["Gender"]=exp["Gender"];
        QuerySnapshot snap_3 = await Firestore.instance.collection("board").document(docid).collection("Dates")
            .getDocuments();
        var lis_2=snap_3.documents;
        var exp_2=lis_2[0];
        info_map["Dates"]=exp_2["Date"];
        QuerySnapshot snap_4 = await Firestore.instance.collection("board").document(docid).collection("Crimes")
            .getDocuments();
        var lis_3=snap_4.documents;
        var exp_3=lis_3[0];
        info_map["Crimes"]=exp_3["Crime"];

        var inf_map2=info_map;
        return inf_map2;


      }
      
    }
    //print(country_number[0]);
    return info_map;
  }



  Widget cardtemplate(name) {
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Row(
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
            'Passenger Profile'
        ),
      ),
      backgroundColor: Colors.blue[300],
      body: SafeArea(
        child:FutureBuilder(
          future: function_2(),
          builder: (context,snapshot){
            List dates=info_map["Dates"];
            List crimes=info_map["Crimes"];
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage("https://image.shutterstock.com/image-vector/user-login-authenticate-icon-human-260nw-1365533969.jpg"),
                  ),
                  Text(
                    info_map["Name"],
                    style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                    width: 200,
                    child: Divider(
                      color: Colors.teal[100],
                    ),
                  ),
                  Card(
                      color: Colors.white,
                      margin:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.location_on,
                          color: Colors.teal[900],
                        ),
                        title: Text(
                          info_map["Nationality"],
                          style:
                          TextStyle(fontFamily: 'BalooBhai', fontSize: 20.0),
                        ),
                      )),
                  Card(
                    color: Colors.white,
                    margin:
                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.cake,
                        color: Colors.teal[900],
                      ),
                      title: Text(
                        info_map["Date Of Birth"],
                        style: TextStyle(fontSize: 20.0, fontFamily: 'Neucha'),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    margin:
                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.cake,
                        color: Colors.teal[900],
                      ),
                      title: Text(
                        info_map["Gender"],
                        style: TextStyle(fontSize: 20.0, fontFamily: 'Neucha'),
                      ),
                    ),
                  ),
                Expanded(
                  child:Column(

                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemCount: dates.length,
                        itemBuilder: (context,index){
                          final date_i=dates[index];
                          return cardtemplate(date_i);
                        },

                      ),
                    )


                  ],

                ),),
                  Expanded(
                    child:Column(

                      children: <Widget>[
                        Expanded(
                          child: ListView.builder(
                            itemCount: crimes.length,
                            itemBuilder: (context,index){
                              final crime_i=crimes[index];
                              return cardtemplate(crime_i);
                            },

                          ),
                        )


                      ],

                    ),)
                ],
              ),
            );
          },

        ),

      ),
    );
      /*body: ListView(
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
                  ),

                ],
              );
            },

          ),


          StreamBuilder(
            stream: Firestore.instance.collection("board").document(docid).collection("Dates").snapshots(),

            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return new Text('Loading...');


              return new Column(
                children: snapshot.data.documents.map((document) {
                  List<String> date_list = List.from(document['Date']);
                  print(date_list);
                  for(int i=0;i<date_list.length;i++)
                  {return cardtemplate(date_list[i]);}
                }).toList(),
              );



            },
          ),





        ],
      ),
    );
*/
  }
}