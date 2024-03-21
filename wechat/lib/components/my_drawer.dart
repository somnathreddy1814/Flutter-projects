import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/settings_page.dart';
import '../services/auth/auth_service.dart';
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  void logout(){
    final _auth=AuthService();
    _auth.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.message,color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25),
                child:ListTile(
                  title: Text("H O M E"),
                  leading: Icon(Icons.home_filled),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.only(left: 25),
                child:ListTile(
                  title: Text("S E T T I N G S"),
                  leading: Icon(Icons.settings),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>SettingsPage()),
                    );
                  },
                ),
              ),

            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 25,bottom: 25),
            child:ListTile(
              title: Text("L O G O U T"),
              leading: Icon(Icons.logout),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
