import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat/themes/theme_provider.dart';
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        // Container styling
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary, // Use secondary color from theme
          borderRadius: BorderRadius.circular(12),
        ),
        // Container margins and padding
        margin: EdgeInsets.all(25),
        padding:EdgeInsets.all(16),
        // Row widget to arrange children horizontally
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Text for dark mode option
            const Text("Dark Mode"),
            // Switch for toggling dark mode
            CupertinoSwitch(
              // Initially set to true for demonstration (you should replace it with the actual state)
              value: Provider.of<ThemeProvider>(context,listen: false).isDarkMode,
              onChanged: (value) =>Provider.of<ThemeProvider>(context,listen: false).toggleTheme(),
            ),
          ], //Children
        ),
      ),

    );
  }
}
