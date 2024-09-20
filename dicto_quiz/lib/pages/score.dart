import 'package:flutter/material.dart';
import 'package:quizo/components/colors.dart';
import 'package:quizo/pages/tenses.dart';
import 'package:quizo/pages/voice.dart';

import '../components/my_button.dart';
import 'homePage.dart';
class Score extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Score> {


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Stack(
        children: <Widget>[
          Positioned(
            top: height*0.27,
            left: width*0.1,
            right: width*0.1,
            bottom: height*0.2,
            child: Container(
              // width: 200,
              // height: 200,
              decoration: BoxDecoration(
                color: MyColors.background,
                borderRadius: BorderRadius.circular(20.0), // Adjust the value to change the amount of rounding
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: height*0.04,),
                  Center(
                    child: Text(
                      'S C O R E',
                      style: TextStyle(color: Colors.white, fontSize: 30.0,fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(height: height*0.02,),
                  CircleAvatar(
                    child:
                    Text("100 pt",style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 30,
                      fontStyle:FontStyle.normal,
                    ),),
                    maxRadius: height*width*0.00017,
                    backgroundColor: MyColors.first,
                  ),
                  SizedBox(height: height*0.02,),
                

                  Container(
                    height: height*0.1,
                    width: width*0.6,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.transparent,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular((30))),
                              color: MyColors.first,
                            ),
                            height: height*0.1,
                            child: Center(
                              child: Text(
                                'CORRECT: 4',
                                style: TextStyle(color: Colors.green[400], fontSize: height*width*0.000045,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 1, // Width of the portion line
                          color: Colors.black, // Color of the portion line
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomRight: Radius.circular((30))),
                              color: MyColors.first,
                            ),
                            
                            height: height,
                            child: Center(
                              child: Text(
                                'INCORRECT: 1',
                                style: TextStyle(color: Colors.red[300], fontSize: height*width*0.000045,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: height*0.02,),

                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                        );
                      },
                      child: Container(
                        width: width*0.2,
                        // height: 100.0,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyColors.first,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.refresh,
                            color: Colors.black87,
                            size: width*0.1,
                          ),
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: height*0.005,),
                  Center(child:
                    Text("Play Again",style: TextStyle(
                      fontSize: 13,color: MyColors.first,
                      fontWeight: FontWeight.bold,
                    ),),),
                  Row(children: [
                  
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Tenses()),
                      );
                    },
                    child: Container(
                      width: width*0.2,
                      // height: 100.0,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: MyColors.first,
                      ),
                      child: Center(
                        child: Text(
                          "Tenses"
                        ),
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Voice()),
                      );
                    },
                    child: Container(
                      width: width*0.2,
                      // height: 100.0,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: MyColors.first,
                      ),
                      child: Center(
                        child: Text(
                            "Voice"
                        ),
                      ),
                    ),
                  ),
                  ],),

                ],
              ),
            ),
          ),




        ],
      ),
    );
  }
}
