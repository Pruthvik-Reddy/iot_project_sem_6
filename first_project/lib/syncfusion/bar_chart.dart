
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:first_project/screens/navigation_screen.dart';

class bar_chart extends StatefulWidget {
  @override
  _bar_chartState createState() => _bar_chartState();
}

class _bar_chartState extends State<bar_chart> {
  var country_number = new Map();
  //var data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //function_1();

  }


  Future<List<country_data>> function_2() async{
    QuerySnapshot snap_2 = await Firestore.instance.collection("board")
        .getDocuments();
    var lis_1 = snap_2.documents;
    for (int i = 0; i < lis_1.length; i++) {
      var doc=lis_1[i];
      var country=doc["Nationality"];
      //  print(country);
      if(country_number.containsKey(country))
      {
        country_number[country]+=1;
      }
      else
      {
        country_number[country]=1;
      }
      //print(country_number[country]);
    }
    //print(country_number[0]);
    var data= await get_column_data(country_number);
    return data;

  }

  function_1() async {

    QuerySnapshot snap_2 = await Firestore.instance.collection("board")
        .getDocuments();
    var lis_1 = snap_2.documents;
    for (int i = 0; i < lis_1.length; i++) {
      var doc=lis_1[i];
      var country=doc["Nationality"];
    //  print(country);
      if(country_number.containsKey(country))
        {
          country_number[country]+=1;
        }
      else
        {
          country_number[country]=1;
        }
      //print(country_number[country]);
    }
    //print(country_number[0]);
    //data=get_column_data(country_number);
    //print(data[0].x);
    //return data;
  }



  Widget build(BuildContext context)  {

    //print(data[0].x);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "National Security Agency",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 24.0),
        ),

      ),
          body: Column(
            children: <Widget>[
              Container(
                child: FutureBuilder(
                  future: function_2(),
                  builder: (context,snapshot){
                    //print(snapshot.data);
                    return Container(
                      height: 500,
                      child: SfCartesianChart(
                        title: ChartTitle(
                            text: "Number of Persons Per Country"
                        ),
                        primaryXAxis: CategoryAxis(
                            title: AxisTitle(
                                text: "Country"
                            )
                        ),
                        primaryYAxis: NumericAxis(
                            title: AxisTitle(
                                text: "Number of People"
                            )
                        ),
                        legend: Legend(
                            isVisible: true
                        ),

                        series: <ChartSeries>  [
                          ColumnSeries<country_data,String>(
                              name: "Country",
                              dataSource: snapshot.data,

                              xValueMapper: (country_data country,_)=>country.x,
                              yValueMapper: (country_data country,_)=>country.y,
                              dataLabelSettings: DataLabelSettings(
                                isVisible: true,

                              )
                          )
                        ],
                      ),);
                  },
                ),

              ),
              Container(
                child: ListTile(
                  title: Text("Return To Previous Page"),
                  leading: CircleAvatar(
                      backgroundColor: Colors.green,
                      backgroundImage: NetworkImage('https://www.pinclipart.com/picdir/middle/130-1304091_left-svg-icon-free-icon-back-arrow-png.png')
                  ),
                  onTap:(){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> navigation_screen()));
                  },

                ),

              )

            ],

          ),
    );
    //print(country_number[0]);
  }
}


class country_data{
  String x;
  int y;
  country_data(this.x,this.y);
}

dynamic get_column_data(Map country_number){
  List<country_data> column_data=<country_data> [];
  print("inside");
  country_number.forEach((key, value) { column_data.add(country_data(key,value));}) ;
  //country_number.forEach((key, value) { print(key);print(value);}) ;
  //print(country_number[0]);
  //print(column_data[0].x);
  //print(column_data[0].y);
  return column_data;
}