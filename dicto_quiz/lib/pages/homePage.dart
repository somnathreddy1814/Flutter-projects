import 'package:flutter/material.dart';
import 'package:quizo/components/colors.dart';
import 'package:quizo/pages/score.dart';
import 'dart:async';
import '../components/my_button.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Timer _timer;
  int _seconds = 10;


  @override
  void initState() {
    super.initState();
    startTimer();
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer.cancel(); // Stop the timer when it reaches 0
          print("Time Over!");
        }
      });
    });
  }
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
            bottom: height*0.17,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: MyColors.background,
                borderRadius: BorderRadius.circular(20.0), // Adjust the value to change the amount of rounding
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: height*0.09,),
                  Center(
                    child: Text(
                      'Question 1/5',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(height: height*0.02,),
                  Center(
                    child: Text(
                      'What is Synonym of word "pride" ',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(height: height*0.024,),
                  MyButton(
                    text: "Option A",
                    //login method we need to create and that is created on top
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Score()),
                      );
                    },
                  ),
                  SizedBox(height: height*0.024,),
                  MyButton(
                    text: "Option B",
                    //login method we need to create and that is created on top
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Score()),
                      );
                    },
                  ),
                  SizedBox(height: height*0.024,),
                  MyButton(
                    text: "Option C",
                    //login method we need to create and that is created on top
                    onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Score()),
                    );
                  },

                  ),
                  SizedBox(height: height*0.024,),
                  MyButton(
                    text: "Option D",
                    //login method we need to create and that is created on top
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Score()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),



          Positioned(
            top: height*0.20,
            left: width*0.35,
            child: CircleAvatar(
              child:
              Text("$_seconds s",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                fontStyle:FontStyle.italic,

              ),),
              maxRadius: height*width*0.00017,
              backgroundColor: MyColors.first,

            ),
          ),
        ],
      ),
    );
  }
}
