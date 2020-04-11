import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:first_project/boardapp/ui/custom_card.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:first_project/boardapp/board_app.dart';





final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;




class sign_in_before extends StatefulWidget {
  @override
  _sign_in_beforeState createState() => _sign_in_beforeState();
}

class _sign_in_beforeState extends State<sign_in_before> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(

            title: new Text("National Security Agency", style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 24.0),),
      backgroundColor: Colors.redAccent,
      centerTitle: true,
      actions: <Widget>
      [
        new IconButton(icon: new Icon(Icons.menu), onPressed: null)
      ],
    ),
      body: new Stack

      (

        children : <Widget>[

                    new Center(

                    child: new Image.network("https://m.economictimes.com/thumb/msid-69959547,width-1200,height-900,resizemode-4,imgsize-86770/age.jpg",fit: BoxFit.fill,width:500.0,height: 1200.0,),
                    ),
                   Padding(
                    padding: const EdgeInsets.all(8.0),


                   )
    ],
    ),

      bottomNavigationBar: BottomAppBar(

        child: FlatButton(child: Text("Continue",style: TextStyle( fontSize: 24.0,),), color: Colors.greenAccent, onPressed: ()
        {
          var router = new MaterialPageRoute(builder: (BuildContext context){
            return new sign_in();});
          Navigator.of(context).push(router);
        }
        ),
      elevation: 0,
    ),
      );



  }
}



/*

Padding
(
padding: const EdgeInsets.all(8.0),
child: FlatButton(child: Text("Google-signin"), onPressed: () => googleSignin(), color: Colors.red,),
),

Padding(
padding: const EdgeInsets.all(8.0),
child: FlatButton(child: Text("Nextt"), color: Colors.orange, onPressed: ()  {
var router = new MaterialPageRoute(builder: (BuildContext context){
return new second_screen(name: namefieldcontroller.text,);
});
Navigator.of(context).push(router);
}
),
),


new ListTile(
title: new TextField(
controller: namefieldcontroller,
decoration: new InputDecoration(
labelText: "Enter your Text"
),
),
)

//new Image.network(imageurl1 == null || imageurl1.isEmpty
//  ? debugPrint("Image not Available")
//: imageurl1,)

*/





class sign_in extends StatefulWidget {


  @override
  _sign_inState createState() => _sign_inState();
}

class _sign_inState extends State<sign_in> {

  String imageurl;
  String imageurl1;
  var namefieldcontroller = new TextEditingController();




  @override
  Widget build(BuildContext context)
  {


      return new Scaffold
      (

        appBar: new AppBar(

          title: new Text("National Security Agency", style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 24.0),),
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          actions: <Widget>
          [
            new IconButton(icon: new Icon(Icons.menu), onPressed: null)
          ],
        ),
          body:new  Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/mage1.jpg'),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter
                    )
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 270),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(23),
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: Container(
                          color: Color(0xfff5f5f5),
                          child: TextFormField(
                            style: TextStyle(
                                color: Colors.black,

                            ),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Username',
                                prefixIcon: Icon(Icons.person_outline),
                                labelStyle: TextStyle(
                                    fontSize: 15
                                )
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Color(0xfff5f5f5),
                        child: TextFormField(
                          obscureText: true,
                          style: TextStyle(
                              color: Colors.black,

                          ),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock_outline),
                              labelStyle: TextStyle(
                                  fontSize: 15
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: MaterialButton(
                          onPressed: (){},//since this is only a UI app
                          child: Text('SIGN IN',
                            style: TextStyle(
                              fontSize: 15,

                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          color: Color(0xffff2d55),
                          elevation: 0,
                          minWidth: 400,
                          height: 50,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Center(
                        child : GoogleSignInButton(onPressed: () => googleSignin(),),

                        )


                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
          );









  }


  Future<FirebaseUser> googleSignin() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount
        .authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    FirebaseUser user = authResult.user;
    print("signed in " + user.displayName);

    setState(() {
      imageurl1 = user.photoUrl;
    });
    var router = new MaterialPageRoute(builder: (BuildContext context){
      return new second_screen();});
    Navigator.of(context).push(router);
    return user;
  }

  logout() {
    setState(() {
      imageurl1 = null;
      _googleSignIn.signOut();
    });
  }

  signinwithemail() {
    _auth.signInWithEmailAndPassword(
        email: "adityakumaon@gmail.com", password: "5pointsomeone").catchError((
        error) {
      print("something went wrong ${error.toString()}");
    }).then((newUser) {
      print("User signed in ");
    });
  }


}





class second_screen extends StatefulWidget {

  final String name;

  second_screen({Key key,this.name}) : super(key:key);

  @override
  _second_screenState createState() => _second_screenState();
}

class _second_screenState extends State<second_screen> {

  var cloudfirestoredb = Firestore.instance.collection("board").snapshots();
  TextEditingController NameInputController;
  TextEditingController AddressInputController;
  TextEditingController Criminal_HistoryInputController;
  TextEditingController possible_threatInputController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NameInputController =  TextEditingController();
    AddressInputController =  TextEditingController();
    Criminal_HistoryInputController =  TextEditingController();
    possible_threatInputController = TextEditingController();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(

        title: new Text("National Security Agency", style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 24.0),),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        actions: <Widget>
        [
          new DropdownButton<String>(
            items: <String>['Sign Out'].map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            onChanged: (
                _
                ) => logout(),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(onPressed: () {
        _showDialog(context);

      }, child: Icon(FontAwesomeIcons.pen),),


      body: StreamBuilder(
          stream: cloudfirestoredb,
          builder: (context,snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, int index) {



                  var t =CustomCard(snapshot: snapshot.data ?? " nc", index: index ?? " vsd");
                  return t?? " ";
                  //return Text(snapshot.data.documents[index]['description'] ?? " ");
                }
            );
          }
      ),
    );



  }
  _showDialog(BuildContext context) async {
    await showDialog(context: context,
        child: AlertDialog(
          contentPadding: EdgeInsets.all(10),
          content: Column(
            children: <Widget>[
              Text("Please fill out the form."),
              Expanded(
                  child: TextField(
                    autofocus: true,
                    autocorrect: true,
                    decoration: InputDecoration(
                        labelText: " Name*"
                    ),
                    controller: NameInputController,

                  )),

              Expanded(
                  child: TextField(
                    autofocus: true,
                    autocorrect: true,
                    decoration: InputDecoration(
                        labelText: "Address"
                    ),
                    controller: AddressInputController,

                  )),

              Expanded(
                  child: TextField(
                    autofocus: true,
                    autocorrect: true,
                    decoration: InputDecoration(
                        labelText: "Criminal History*"
                    ),
                    controller: Criminal_HistoryInputController,

                  )),
              Expanded(
                  child: TextField(
                    autofocus: true,
                    autocorrect: true,
                    decoration: InputDecoration(
                        labelText: "Possible Threat"
                    ),
                    controller: possible_threatInputController,

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
              if( NameInputController.text.isNotEmpty &&
                  AddressInputController.text.isNotEmpty &&
                  Criminal_HistoryInputController.text.isNotEmpty &&
                  possible_threatInputController.text.isNotEmpty) {
                Firestore.instance.collection("board")
                    .add({
                  "Name" : NameInputController.text,
                  "Address" : AddressInputController.text,
                  "Criminal History" : Criminal_HistoryInputController.text,
                  "Possible Threat" : possible_threatInputController.text,


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

        ) );
  }
  logout() {
    setState(() {
      //imageurl1 = null;
      _googleSignIn.signOut();
    });
    var router = new MaterialPageRoute(builder: (BuildContext context){
      return new sign_in();});
    Navigator.of(context).push(router);
  }
}



