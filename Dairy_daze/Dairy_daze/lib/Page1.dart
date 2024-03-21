import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dairy_daze/Page2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:dairy_daze/google_sign_in.dart';
import 'package:provider/provider.dart';

class Page1 extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;
    final name = user?.displayName ?? '';
    final photoURL = user?.photoURL ?? '';
    _textController.text = name;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: sh,
        width: sw,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/moon.jpg"),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: sh * 0.1),
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.orangeAccent[100],
              child: ClipOval(
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Image.network(
                    photoURL,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: sh * 0.03),
            Center(
              child: SizedBox(
                width: sw * 0.9,
                child: DefaultTextStyle(
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontFamily: 'Agne',
                  ),
                  child: AnimatedTextKit(
                    pause: Duration(seconds: 1),
                    isRepeatingAnimation: true,
                    animatedTexts: [
                      TypewriterAnimatedText('Capture Memories.'),
                      TypewriterAnimatedText('Cherish Moments'),
                      TypewriterAnimatedText('Your Digital Diary'),
                    ],
                    onTap: () {
                      print("Tap Event");
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: sh * 0.03),
            Container(
              height: sh * 0.06,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(48)),
                border: Border.all(
                  width: 3,
                  color: const Color.fromRGBO(210, 210, 210, 1),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "Enter your sweet name",
                        contentPadding: EdgeInsets.only(
                          left: sw * 0.05,
                          right: sw * 0.05,
                          top: sh * 0.017,
                          bottom: sh * 0.017,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: sh * 0.05),
            Center(
              child: SizedBox(
                height: sh * 0.07,
                width: sw * 0.4,
                child: ElevatedButton(

                  style: ButtonStyle(

                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.orangeAccent[100]!,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    final userEnter = _textController.text;
                    provider.saveUserData(userEnter);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Page2(userEnter: userEnter),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,

                        size: 24,
                        color: Colors.black87,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
