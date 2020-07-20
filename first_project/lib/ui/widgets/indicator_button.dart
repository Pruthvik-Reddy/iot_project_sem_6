import 'package:flutter/material.dart';
import 'package:first_project/ui/shared/app_colors.dart';


class IndicatorButton extends StatelessWidget {
  final double height;
  final String title;
  final Function onTap;
  final int indicationCount;

  const IndicatorButton({this.height = 20.0, this.title, this.onTap, this.indicationCount});

  bool get hasIndication => indicationCount != null && indicationCount > 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: height,
          child: Stack(children: [
            Container(
                height: height,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0), color: Colors.green),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                )),
            hasIndication ? Positioned(
              top: 10,
              right: 20.0,
              child: Container(
                width: 30,
                height: 20,
                alignment: Alignment.center,
                decoration:
                ShapeDecoration(shape: CircleBorder(), color: Colors.green),
                child: Text(indicationCount.toString(),
                    style: TextStyle(fontSize: 14, color:Colors.green,fontWeight: FontWeight.w400)),
              ),
            ) : Container()
          ]),
        ));
  }
}