import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wechat/components/my_button.dart';
import 'package:wechat/components/my_textfield.dart';

import '../services/auth/auth_service.dart';


class LoginPage extends StatelessWidget {
  final TextEditingController _emailcontroller=TextEditingController();
  final TextEditingController _pwdcontroller=TextEditingController();
  //tap to go to register page
  void Function()? onTap;
   LoginPage({super.key, required this.onTap});
   //login method
  void login(BuildContext context) async{
//auth service
  final authService=AuthService();

  try{
      await authService.signInWithEmailPassword(_emailcontroller.text, _pwdcontroller.text,);
  }
  catch(e){
  showDialog(context: context, builder: (context)=>AlertDialog(
    title: Text(e.toString()),
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
            "Welcome Back,You've beem missed!",
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
            obscureText: false,
            controller: _pwdcontroller,
          ),
          SizedBox(height: 15,),
          //register now
          MyButton(
            text: "Login",
            //login method we need to create and that is created on top
            onTap: ()=>login(context),
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Not a member?",
                style:TextStyle(
                color: Theme.of(context).colorScheme.primary
              ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text("Register now",
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