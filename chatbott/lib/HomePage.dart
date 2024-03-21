import 'package:chatbott/BardAIController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'BardAIController.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    BardAIController controller = Get.put(BardAIController());
    TextEditingController textField = TextEditingController();
    return Scaffold(
      backgroundColor: Color(0xfff2f1f9),

      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:
                          Text("Dicto chatbot welcomes u, ask some thing  ❤️ "),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text("Hey buddy ask question in precise manner🥱"),
                        ),
                      ],
                    ),
                    Obx(() => Column(
                      children: controller.historyList
                          .map(
                            (e) => Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Text(e.system == "user" ? "👨‍💻" : "🤖"),
                              SizedBox(width: 10),
                              Flexible(child: Text(e.message)),
                            ],
                          ),
                        ),
                      )
                          .toList(),
                    ))
                  ],
                )),
            Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 60,
              child: Row(children: [
                Expanded(
                  child: TextFormField(
                    controller: textField,
                    decoration: InputDecoration(
                        hintText: "You can ask what you want",
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        )),
                  ),
                ),
                Obx(
                      () => controller.isLoading.value
                      ? CircularProgressIndicator()
                      : IconButton(
                      onPressed: () {
                        if (textField.text != "") {
                          controller.sendPrompt(textField.text);
                          textField.clear();
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      )),
                ),
                SizedBox(width: 10)
              ]),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}