import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:convert';
import 'package:first_project/screens/navigation_screen.dart';

class years_chart extends StatefulWidget {
  @override
  _years_chartState createState() => _years_chartState();
}

class _years_chartState extends State<years_chart> {
  @override
  var month_number = new Map();
  //var data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //function_2();

  }


  Future<List<month_data>> function_2() async {
    print("inside 2");
    QuerySnapshot snap_2 = await Firestore.instance.collection("years_data")
        .getDocuments();

    var lis_1 = snap_2.documents;
    for (int i = 0; i < lis_1.length; i++) {
      var doc = lis_1[i];
      var id = lis_1[i].documentID;
      var field_id = lis_1[i];
      month_number["2016"] = field_id["2016"];
      month_number["2017"] = field_id["2017"];
      month_number["2018"] = field_id["2018"];
      month_number["2019"] = field_id["2019"];
      month_number["2020"] = field_id["2020"];
      var data = await get_column_data(month_number);
//    print(data[0].x);
      return data;
    }
  }

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
                        text: "Number of Persons In Each Month Over the Years"
                    ),
                    primaryXAxis: CategoryAxis(
                        title: AxisTitle(
                            text: "Month"
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
                      ColumnSeries<month_data,String>(
                          name: "Month",
                          dataSource: snapshot.data,

                          xValueMapper: (month_data month,_)=>month.x,
                          yValueMapper: (month_data month,_)=>month.y,
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

  }
}

class month_data{
  String x;
  int y;
  month_data(this.x,this.y);
}

dynamic get_column_data(Map month_number){
  List<month_data> column_data=<month_data> [];
  print("inside");
  month_number.forEach((key, value) { column_data.add(month_data(key,value));}) ;
  //country_number.forEach((key, value) { print(key);print(value);}) ;
  //print(country_number[0]);
  //print(column_data[0].x);
  //print(column_data[0].y);
  return column_data;
}
