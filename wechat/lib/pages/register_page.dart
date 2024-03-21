import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../services/auth/auth_service.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailcontroller=TextEditingController();
  final TextEditingController _pwdcontroller=TextEditingController();
  final TextEditingController _confirmPwdcontroller=TextEditingController();
  void Function()? onTap;
  RegisterPage({super.key,required this.onTap});

  //register method
  void register(BuildContext context){
    final _auth=AuthService();
    if (_pwdcontroller.text==_confirmPwdcontroller.text){
      try{
        _auth.signUpWithEmailPassword(_emailcontroller.text,_pwdcontroller.text);
      }
      catch(e){
        showDialog(context: context, builder: (context)=>AlertDialog(
          title: Text(e.toString()),
        ),

        );
      }
    }else{
      showDialog(context: context, builder: (context)=>AlertDialog(
        title: Text("Passwords don't match!"),
      ),

      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body:Center(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children:[
            //logo
            Icon(Icons.message,size:40,color:Theme.of(context).colorScheme.primary),

            SizedBox(height: 15,),

            //welcome back message
            Text(
              "Let's create an account for you",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 15,),

            //email txt field
            MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailcontroller,
            ),
            SizedBox(height: 15,),
            //pwd txt field
            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _pwdcontroller,
            ),
            SizedBox(height: 15,),
            MyTextField(
              hintText: "confirm Password",
              obscureText: true,
              controller: _confirmPwdcontroller,
            ),
            SizedBox(height: 15,),
            //register now
            MyButton(
              text: "Register",
              //login method we need to create and that is created on top
              onTap: ()=>register(context),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? ",
                  style:TextStyle(
                      color: Theme.of(context).colorScheme.primary
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Login now",
                    style:TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary
                    ),),
                ),
              ],

            )



          ],
        ),
      ),
    );
  }
}
