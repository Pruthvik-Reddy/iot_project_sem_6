import 'package:flutter/material.dart';

import 'package:first_project/syncfusion/bar_chart.dart';
import 'package:first_project/syncfusion/country_chart.dart';
import 'package:first_project/syncfusion/month.dart';
import 'package:first_project/syncfusion/years.dart';


class navigation_screen extends StatefulWidget {
  @override
  _navigation_screenState createState() => _navigation_screenState();
}

class _navigation_screenState extends State<navigation_screen> {
  @override

  Widget _myListView(BuildContext context) {

    final titles = ['Passengers based on Countries', 'Geographical View of Nationality', 'Stats of Passengers grouped by Month', 'Stats of Passengers grouped by Years'];


    final icons = [Icons.airplanemode_active, Icons.location_on,
      Icons.calendar_today, Icons.calendar_today];


    return ListView.builder(
    itemCount: titles.length,
    itemBuilder: (context, index) {
    return Card( //                           <-- Card widget
      child: ListTile(
      //leading: Icon(icons[index]),
      title: Text(titles[index]),
        leading: CircleAvatar(
            backgroundColor: Colors.green,
            backgroundImage: NetworkImage('https://pbs.twimg.com/profile_images/616504945756504064/tD9W3Hg-.png')
        ),
        onTap:(){
        if(index==0){Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> bar_chart()));}
        if(index==1){Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> country_chart()));}
        if(index==2){Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> month_chart()));}
        if(index==3){Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> years_chart()));}
        },

    ),
    );
    },
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
          new IconButton(icon: new Icon(Icons.menu), onPressed: null)
        ],
      ),
      body: _myListView(context),
    );
  }
}
