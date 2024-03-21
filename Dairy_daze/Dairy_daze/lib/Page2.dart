import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dairy_daze/card_detail.dart';

class DateCard extends StatefulWidget {
  final String date;
  final ValueChanged<String> onTitleChanged;

  const DateCard({
    required this.date,
    required this.onTitleChanged,
  });

  @override
  _DateCardState createState() => _DateCardState();
}

class _DateCardState extends State<DateCard> {
  String title = '';

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;
    final currentDate = DateTime.now();
    final formattedDate = DateFormat('dd-MM-yy').format(currentDate);

    return GestureDetector(
      onTap: () async {
        final String userInput = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CardDetailPage(date: widget.date),
          ),
        );
        if (userInput != null) {
          setState(() {
            title = userInput;
          });
          widget.onTitleChanged(userInput);
        }
      },
      child: Card(
        color: Colors.orangeAccent[100],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        margin: EdgeInsets.all(20),
        child: Container(
          color: Colors.orangeAccent.withOpacity(0.1),
          width: sw * 0.8,
          height: sh * 0.23,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: sh * 0.02),
              Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(height: sh * 0.02),
              Container(
                width: sw * 0.7,
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  final String userEnter;

  const Page2({Key? key, required this.userEnter}) : super(key: key);

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  List<String> dateList = [];

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: sh,
        width: sw,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/mainbg.png"),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: sh * 0.05),
            Container(
              padding: EdgeInsets.only(left: sw * 0.05),
              alignment: Alignment.topLeft,
              child: Text(
                "Hi, ${widget.userEnter}",
                style: TextStyle(
                  fontSize: 35,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: sh * 0.03),
            Container(
              padding: EdgeInsets.only(left: sw * 0.05),
              alignment: Alignment.topLeft,
              child: Text(
                "Your memories so far",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: dateList.length,

                itemBuilder: (context, index) {
                  return DateCard(
                    date: dateList[index],
                    onTitleChanged: (value) {
                      setState(() {
                        dateList[index] = value;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent[100],
        elevation: 10,
        onPressed: () {
          setState(() {
            dateList.add('');
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
