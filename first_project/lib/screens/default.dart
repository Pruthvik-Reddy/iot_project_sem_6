import 'package:flutter/material.dart';
import 'authenticate/authenticate.dart';

class sign_in_before extends StatefulWidget {
  @override
  _sign_in_beforeState createState() => _sign_in_beforeState();
}

class _sign_in_beforeState extends State<sign_in_before> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
          new IconButton(icon: new Icon(Icons.menu), onPressed: null)
        ],
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.network(
              "https://m.economictimes.com/thumb/msid-69959547,width-1200,height-900,resizemode-4,imgsize-86770/age.jpg",
              fit: BoxFit.fill,
              width: 500.0,
              height: 1200.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: FlatButton(
            child: Text(
              "Continue",
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            color: Colors.greenAccent,
            onPressed: () {
              var router =
              new MaterialPageRoute(builder: (BuildContext context) {

                return sign_in();
              });
              Navigator.of(context).push(router);
            }),
        elevation: 0,
      ),
    );
  }
}
