import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'authenticate/authenticate.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'profile_page.dart';
import 'package:intl/intl.dart';
import 'package:first_project/ui/shared/app_colors.dart';
import 'package:first_project/ui/shared/font_styles.dart';
import 'package:first_project/ui/widgets/stats_counter.dart';
import 'package:first_project/ui/widgets/watcher_toolbar.dart';
import 'package:first_project/ui/widgets/indicator_button.dart';
import 'package:first_project/ui/widgets/ui_reducers.dart';
import 'show_screen2.dart';


class stats_monitor extends StatefulWidget {
  @override
  _stats_monitorState createState() => _stats_monitorState();
}

class _stats_monitorState extends State<stats_monitor> {

  var info_list=new Map();

  static const BoxDecoration topLineBorderDecoration = BoxDecoration(
      border: Border(
          top: BorderSide(
              color: Colors.green, style: BorderStyle.solid, width: 5.0)));


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //function_1();

  }


  function_1() async{
    QuerySnapshot snap_2=await Firestore.instance.collection("board").where("present",isEqualTo: "True").getDocuments();
    var lis_1=snap_2.documents;
    info_list["total_passengers"]=lis_1.length;
    for(int i=0;i<lis_1.length;i++)
    {
      var field_ref=lis_1[i];
      if(field_ref["Gender"]=="Male")
      {if(info_list.containsKey("males"))
      {
        info_list["males"]+=1;
      }
      else
      {
        info_list["males"]=1;
      }
      }
      if(field_ref["Gender"]=="Female")
      {
        if(info_list.containsKey("females"))
        {
          info_list["females"]+=1;
        }
        else
        {
          info_list["females"]=1;
        }
      }


    }
        return info_list;
    }





  Widget build(BuildContext context) {
    return new Scaffold(

      backgroundColor: Theme.of(context).backgroundColor,


      appBar: new AppBar(
        title: new Text(
          "National Security Agency",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 24.0),
        ),

      ),
        body: FutureBuilder(
                future: function_1(),
                builder: (context,snapshot){
                  return Column(

                      children: [
                    WatcherToolbar(title: 'STATS MONITOR'),
                    _getHeightContainer(
                      context: context,
                      height: screenHeight(context, dividedBy: 3, decreasedBy: toolbarHeight),
                      child: StatsCounter(
                        size: screenHeight(context, dividedBy: 3, decreasedBy: toolbarHeight) - 60, // 60 margins
                        count: info_list["total_passengers"],
                        title: 'Total Passengers',
                        titleColor: Colors.red,
                      ),
                    ),
                    _getHeightContainer(
                        context: context,
                        height:screenHeight(context, dividedBy: 3, decreasedBy: toolbarHeight),
                        child: Row(

                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              StatsCounter(
                                size: screenHeight(context, dividedBy: 3, decreasedBy: toolbarHeight) - 60,
                                count: info_list["males"],
                                title: 'Males',
                              ),
                              StatsCounter(
                                size: screenHeight(context,dividedBy: 3, decreasedBy: toolbarHeight) - 60,
                                count: info_list["females"],
                                title: 'Females',
                              )
                            ])
                    ),
                    _getHeightContainer(
                        height:screenHeight(context, dividedBy: 6, decreasedBy: toolbarHeight),
                        child: IndicatorButton(
                            title: 'VIEW STATS',

                            onTap: () {
                             Navigator.push(context,MaterialPageRoute(builder: (context) => second_screen2()));
                            }
                        ))
                  ]);
                },

        )

    );
  }

  Widget _getHeightContainer(
      {double height,
        BuildContext context,
        Widget child,
        bool hasTopStroke = false}) {
    return Container(
        height: height,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: hasTopStroke? topLineBorderDecoration : null,
        child: child);
  }
}
