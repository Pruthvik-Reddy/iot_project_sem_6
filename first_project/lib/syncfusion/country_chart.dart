import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:syncfusion_flutter_core/core.dart';
import 'package:syncfusion_flutter_core/core_internal.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_core/localizations.dart';

class country_chart extends StatefulWidget {
  @override
  _country_chartState createState() => _country_chartState();
}

class _country_chartState extends State<country_chart> {

  //var country_number = new Map();
  List<CountryDensityModel> _worldPopulationDensityDetails;
  final NumberFormat _numberFormat = NumberFormat('#.#');
  var month_number = new Map();



  @override

  void initState() {
    // TODO: implement initState
    super.initState();

  }

  Future<List<CountryDensityModel>> function_2() async {
    print("inside 2");
    QuerySnapshot snap_2 = await Firestore.instance.collection("board")
        .getDocuments();

    var lis_1 = snap_2.documents;
    for (int i = 0; i < lis_1.length; i++) {
      var doc = lis_1[i];
      var id = lis_1[i].documentID;
      var field_id = lis_1[i];
      var country=field_id["Nationality"];
      if(month_number.containsKey(country))
      {
        month_number[country]+=1;
      }
      else
      {
        month_number[country]=1;
      }



    }
    _worldPopulationDensityDetails = await get_column_data(month_number);
//    print(data[0].x);
    return _worldPopulationDensityDetails;
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
            print("Inside2");
            return Container(
              height: 550,
              child: SfMaps(
                title: MapTitle(
                  text: "Stats of Visitors in Different Countries",
                  padding: EdgeInsets.only(top: 15, bottom: 30),
                ),
                layers: <MapLayer>[
                  MapShapeLayer(
                    delegate: MapShapeLayerDelegate(
                      shapeFile: 'assets/world_map.json',
                      shapeDataField: 'name',
                      dataCount: _worldPopulationDensityDetails.length,
                      primaryValueMapper: (int index) =>
                      _worldPopulationDensityDetails[index].countryName,
                      shapeColorValueMapper: (int index) =>
                      _worldPopulationDensityDetails[index].density,
                      shapeTooltipTextMapper: (int index) =>
                      _worldPopulationDensityDetails[index].countryName +
                          ' : ' +
                          _numberFormat
                              .format(
                              _worldPopulationDensityDetails[index].density)
                              .toString() +
                          ' per sq. km.',
                      shapeColorMappers: const <MapColorMapper>[
                        MapColorMapper(
                            from: 0,
                            to: 25,
                            color: Color.fromRGBO(128, 159, 255, 1),
                            text: '<25'),
                        MapColorMapper(
                            from: 25,
                            to: 50,
                            color: Color.fromRGBO(51, 102, 255, 1),
                            text: '25-50'),
                        MapColorMapper(
                            from: 50,
                            to: 100,
                            color: Color.fromRGBO(0, 57, 230, 1),
                            text: '50 - 100'),
                        MapColorMapper(
                            from: 100,
                            to: 250,
                            color: Color.fromRGBO(0, 51, 204, 1),
                            text: '100 - 250'),
                        MapColorMapper(
                            from: 250,
                            to: 500,
                            color: Color.fromRGBO(0, 45, 179, 1),
                            text: '250 - 500'),
                        MapColorMapper(
                            from: 500,
                            to: 1000,
                            color: Color.fromRGBO(0, 38, 153, 1),
                            text: '500 - 1k'),
                        MapColorMapper(
                            from: 1000,
                            to: 10000,
                            color: Color.fromRGBO(0, 32, 128, 1),
                            text: '1k - 10k'),

                      ],
                    ),

                    showLegend: true,
                    enableShapeTooltip: true,
                    strokeColor: Colors.redAccent,
                    legendSettings: const MapLegendSettings(
                        position: MapLegendPosition.bottom,
                        iconType: MapIconType.square,
                        overflowMode: MapLegendOverflowMode.wrap,
                        padding: EdgeInsets.only(top: 15)),
                    dataLabelSettings: MapDataLabelSettings(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize:
                            Theme.of(context).textTheme.caption.fontSize)),

                  ),
                ],



              ),);
            print("Inside");
          },

        ),
      ),
    );

  }
}


class country_data{
  String x;
  int y;
  country_data(this.x,this.y);
}


class CountryDensityModel {
  CountryDensityModel(this.countryName, this.density);

  final String countryName;
  final int density;
}

dynamic get_column_data(Map country_number){
  List<CountryDensityModel> column_data=<CountryDensityModel> [];
  print("inside");
  country_number.forEach((key, value) { column_data.add(CountryDensityModel(key,value));}) ;
  //country_number.forEach((key, value) { print(key);print(value);}) ;
  //print(country_number[0]);
  //print(column_data[0].x);
  //print(column_data[0].y);
  return column_data;
}
