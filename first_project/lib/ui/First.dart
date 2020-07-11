import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:first_project/util/hexcolor.dart';
//The Container widget helps you create a rectangular visual Element. A container can be decorated with Boxdecoration,such as bsackground,border or a shadow.
//A container can also have margins,padding and constraints applied to its size.
class scaffoldexample extends StatelessWidget {
  //creating method
  _tapbutton() {
    debugPrint("Alarm Button Tapped");
  }

  @override
  Widget build(BuildContext context) {
    //scaffold provides the basic material design Layout
    return Scaffold(
        appBar: AppBar(
          title: Text("AppBar"),
          centerTitle: true,
          backgroundColor: Colors.amber,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.email),
              onPressed: () => debugPrint("Tapped Email"),
            ),
            IconButton(icon: Icon(Icons.access_alarms), onPressed: _tapbutton())
          ],
        ),
        backgroundColor: Colors.red.shade100,
        /*body: Center(
          child: Text("In the Body",textDirection: TextDirection.ltr,),

      ),*/

        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(Icons.call_missed),
          onPressed: () => debugPrint("Tapped Call_missed icon"),
        ),
        //Inkwell Widjet is a customizable widget with good Tap Properties->doubletap,longPress etc; Provides additional tapping things;
        //Finally,we use onTap and get the index of which icon is tapped

        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), title: Text("Bottom1")),
            BottomNavigationBarItem(
                icon: Icon(Icons.ac_unit), title: Text("Bottom2"))
          ],
          onTap: (int index) => debugPrint("Tapped Item :$index"),
        ),
        body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //We can also use Inkwell to get buttons

                CustomButton()
                /*
            InkWell(
              child: Text("Tap me",style: TextStyle(fontSize: 25),),
              onDoubleTap: ()=>debugPrint("Double Tapped"),

            )
          */
              ],
            )));
  }
}

//Gesture detection

class BillSplitter extends StatefulWidget {
  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int tipPercentage = 0;
  int personCounter = 1;
  double billAmount = 0.0;

  Color purple_coded=HexColor('#6908D6');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //mediaquery->height->0.1->margin will be at 0.1 of the height
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
        alignment: Alignment.center,
        color: Colors.white,
        //whenever we hit a text field,keyboard appears; So to avoid not seeing some of the objects,we use ListView
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: <Widget>[
            Container(
              width: 150,height: 150,
              decoration: BoxDecoration(
                color: purple_coded.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.0)
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Total Per Person",style: TextStyle(
                      color:purple_coded,
                      fontWeight: FontWeight.normal,
                      fontSize: 17.0
                    ),),
                    Text("\$ ${calculateTotalPerPerson(billAmount, personCounter, tipPercentage)}", style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color:purple_coded
                    ),)
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(12.0),
              margin: EdgeInsets.only(top:20.0),
              decoration: BoxDecoration(
                color:Colors.transparent,
                border: Border.all(
                  color:Colors.blueGrey.shade100,
                  style: BorderStyle.solid
                ),
              borderRadius: BorderRadius.circular(12.0)
              ),
              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color:purple_coded),
                    decoration: InputDecoration(
                      prefixText: "Bill Amount",
                      prefixIcon: Icon(Icons.attach_money)
                    ),
                  onChanged: (String value){
                      try{
                        billAmount=double.parse(value);

                      }catch(exception){
                        billAmount=0.0;
                      }
                  },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Split", style:TextStyle(
                        color: Colors.grey.shade700
                      ),),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(personCounter>1){
                                  personCounter--;
                                }
                              });

                            },
                            child: Container(
                              width:40.0,
                              height:40.0,
                              margin:EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: purple_coded.withOpacity(0.1)
                              ),
                              child: Center(
                                child: Text(
                                  "-",style: TextStyle(
                                  color: purple_coded,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0
                                ),
                                ),
                              ),
                            ),

                          ),
                          Text("$personCounter",style:TextStyle(
                            color: purple_coded,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0
                          ),),
                        InkWell(
                          onTap: (){
                            setState(() {
                              personCounter++;
                            });
                          },
                          child: Container(
                            width:40.0,height:40.0,
                            margin: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: purple_coded.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(7.0)
                            ),
                            child: Center(
                              child: Text("+",style: TextStyle(
                                color: purple_coded,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold

                              ),),
                            ),
                          ),
                        ),

                        ],
                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Tip",style: TextStyle(
                          color: Colors.grey.shade700
                      ),),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text("\$ ${calculateTotalTip(billAmount, personCounter, tipPercentage)}",style: TextStyle(
                          color: purple_coded,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0
                        ),),
                      )
                    ],
                  ),

                  Column(
                    children: <Widget>[
                     Text("$tipPercentage",style: TextStyle(
                       color:purple_coded,
                       fontSize: 17.0,
                       fontWeight: FontWeight.bold
                     ),),
                    Slider(
                        min:0,max:100,
                        activeColor:purple_coded,
                        inactiveColor:Colors.grey,
                        divisions:10,
                        value :tipPercentage.toDouble(),
                      onChanged: (double value){
                      setState(() {
                        tipPercentage=value.round();
                      });
                      })
                    ],

                  )
                ],
              ),
            )
          ],
        )
      ),
    );
  }
  calculateTotalPerPerson(double billAmount,int splitby,int tipPercentager){
    double totalTip= calculateTotal(billAmount, splitby, tipPercentage);
    var TotalPerPerson=(totalTip+billAmount)/splitby;
    //tostringAsFixed(3) implies 3 digits after dcimal
    return TotalPerPerson.toStringAsFixed(3);
  }

  double calculateTotal(double billAmount,int splitby,int tipPercentage){
    double totalTip=0.0;
    if(billAmount<0 || billAmount.toString().isEmpty || billAmount==null) {

    }
    else{
      totalTip=(billAmount * tipPercentage)/100;
    }
    return totalTip;
  }


  calculateTotalTip(double billAmount,int splitby,int tipPercentage){
    double totalTip=0.0;
    if(billAmount<0 || billAmount.toString().isEmpty || billAmount==null){

    }
    else{
      totalTip=(billAmount * tipPercentage)/100;
    }
    return totalTip;
  }
}

class CustomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //GestureDetector attempts to recognise gestures.
    //Inkwell class also implements it
    return GestureDetector(
      onTap: () {
        //Snackbar is light weight widget which is used to show messages in the bottom of the applications
        final snackbar = SnackBar(
          content: Text("Snackbar Hello"),
        );

        Scaffold.of(context).showSnackBar(snackbar);
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.pinkAccent, borderRadius: BorderRadius.circular(8.0)),
        child: Text("Button"),
      ),
    );
  }
}
//Material design implies designing such that it resembles real world...for ex,shadows swhen one object is placed over the other
//Material is the central metaphor in material design.Each piece of material exists at a given elevation which influences how that
// piece of material visually relates to other pieces of material.

class First extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.orange,
      child: Center(
          child: Text(
        "Hello",
        textDirection: TextDirection.ltr,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 25,
        ),
      )),
    );
  }
}

class BizCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BizCard"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        //Stack is used for overlapping widgets.stack takes a list of widgets and renders them from ground up one on top of the other
        child: Stack(
          //use topcenter or center,rrc to get the desired object in the required place
          alignment: Alignment.topCenter,
          children: <Widget>[_getcard(), _getCircular()],
        ),
      ),
    );
  }

  Container _getCircular() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          border: Border.all(color: Colors.red, width: 1.2),
          image: DecorationImage(
              image: NetworkImage("https://picsum.photos/300/300"),
              fit: BoxFit.cover)),
    );
  }

  Container _getcard() {
    return Container(
      width: 250,
      height: 300,
      margin: EdgeInsets.all(50.0),
      decoration: BoxDecoration(
          color: Colors.pinkAccent,
          //more the border radius,more the bending
          borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("NAme"),
          Text("email@ymail.com"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.person_outline),
              Text("buildingapps@withme")
            ],
          )
        ],
      ),
    );
  }
}

class wisdom extends StatefulWidget {
  @override
  _wisdomState createState() => _wisdomState();
}

class _wisdomState extends State<wisdom> {
  int counter = 0;
  List quotes = ["A", "b", "C", "D", "E"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(quotes[counter % quotes.length]),
            FlatButton.icon(
              onPressed: _showquote,
              color: Colors.greenAccent.shade700,
              icon: Icon(Icons.wb_sunny),
              label: Text(
                "Inspire me",
                style: TextStyle(fontSize: 18.8, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  _showquote() {
    //setstate() is important.Otherwise,threre wont be any changes made to the state
    setState(() {
      counter += 1;
    });
  }
}
