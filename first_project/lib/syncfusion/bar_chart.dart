
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class bar_chart extends StatefulWidget {
  @override
  _bar_chartState createState() => _bar_chartState();
}

class _bar_chartState extends State<bar_chart> {
  var country_number = new Map();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    function_1();

  }


  function_1() async {

    QuerySnapshot snap_2 = await Firestore.instance.collection("board")
        .getDocuments();
    var lis_1 = snap_2.documents;
    for (int i = 0; i < lis_1.length; i++) {
      var doc=lis_1[0];
      var country=doc["Country"];
      if(country_number.containsKey(country))
        {
          country_number[country]+=1;
        }
      else
        {
          country_number[country]=1;
        }
    }


  }



  Widget build(BuildContext context) {
    return Container(
      height: 550,
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

        series: <ChartSeries>[
          ColumnSeries<country_data,String>(
            name: "Country",
            dataSource: get_column_data(country_number),
            xValueMapper: (country_data country,_)=>country.x,
            yValueMapper: (country_data country,_)=>country.y,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,

            )
          )
        ],
      ),
    );
  }
}


class country_data{
  String x;
  int y;
  country_data(this.x,this.y);
}

dynamic get_column_data(Map country_number){
  List<country_data> column_data=<country_data> [];
  country_number.forEach((key, value) { column_data.add(country_data(key,value));}) ;
  country_number.forEach((key, value) { print(key);print(value);}) ;
  return column_data;
}