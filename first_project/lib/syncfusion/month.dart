import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:convert';

class month_chart extends StatefulWidget {
  @override
  _month_chartState createState() => _month_chartState();
}

class _month_chartState extends State<month_chart> {
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
    QuerySnapshot snap_2 = await Firestore.instance.collection("months_data")
        .getDocuments();

    var lis_1 = snap_2.documents;
    for (int i = 0; i < lis_1.length; i++) {
      var doc = lis_1[i];
      var id = lis_1[i].documentID;
      var field_id = lis_1[i];
      month_number["jan"] = field_id["Jan"];
      month_number["feb"] = field_id["Feb"];
      month_number["mar"] = field_id["Mar"];
      month_number["apr"] = field_id["Apr"];
      month_number["may"] = field_id["May"];
      month_number["jun"] = field_id["Jun"];
      month_number["jul"] = field_id["jul"];
      month_number["aug"] = field_id["Aug"];
      month_number["sept"] = field_id["Sept"];
      month_number["oct"] = field_id["Oct"];
      month_number["nov"] = field_id["Nov"];
      month_number["dec"] = field_id["Dec"];
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
      body: Container(
        child: FutureBuilder(
          future: function_2(),
          builder: (context,snapshot){
            //print(snapshot.data);
            return Container(
              height: 550,
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