import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dairy_daze/google_sign_in.dart';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';

class CardDetailPage extends StatefulWidget {
  final String date;

  CardDetailPage({required this.date});

  @override
  _CardDetailPageState createState() => _CardDetailPageState();
}

class _CardDetailPageState extends State<CardDetailPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _textEditingController = TextEditingController();
  List<File> _images = [];
  // void _storeUserData() async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(user.uid)
  //         .set({'address': _dataController.text,'age': _ageController.text,'phone':_numberController.text,'text':_freeTextController.text});
  //     print('User data stored successfully!');
  //     setState(() {
  //       saveStatus =2;
  //     });
  //   } catch (e) {
  //     print('Error storing user data: $e');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }


  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        final userInput = _titleController.text;
        _showSaveNotification();
        Navigator.pop(context, userInput);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: sh * 0.08,
              padding: EdgeInsets.only(top: sh * 0.04),
              child: Text(
                "A memory from",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 28,
                ),
              ),
            ),
            SizedBox(height: sh * 0.01),
            Container(
              alignment: Alignment.center,
              child: Text(
                DateFormat('dd-MM-yyyy').format(DateTime.now()),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(height: sh * 0.01),
            Container(
              child: Padding(
                padding: EdgeInsets.only(left: sw * 0.05),
                child: TextField(
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 35,
                  ),
                  controller: _titleController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Enter title",
                    hintStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 40,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  cursorColor: Colors.orangeAccent[200],
                ),
              ),
            ),

            Container(
              height: sh * 0.42,
              width: sw,

              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (notification) {
                  return true;
                },
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        left: sh * 0.02,
                        right: sh * 0.05,
                      ),
                      child: TextFormField(
                        controller: _textEditingController,
                        maxLines: null,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Start writing',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              height: sh*0.35,
              width: sw,

              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (notification) {

                  return true;
                },
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _images.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: _buildImageWidget(index),
                    );
                  },
                ),
              ),
            ),

          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple[400],
          elevation: 10,
          onPressed: _pickImage,
          child: Icon(Icons.image),
        ),
      ),
    );
  }

  Widget _buildImageWidget(int index) {
    return GestureDetector(
      onTap: () => _showFullScreenImage(_images[index],index),
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          image: DecorationImage(
            image: FileImage(_images[index]),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    List<XFile>? imageFiles = await ImagePicker().pickMultiImage(
      imageQuality: 80, // Adjust the image quality as needed
    );

    if (imageFiles != null && imageFiles.isNotEmpty) {
      List<File> files = imageFiles.map((file) => File(file.path)).toList();

      setState(() {
        _images.addAll(files);
      });
    }
  }



  void _showFullScreenImage(File imageFile, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Stack(
            children: [
              Container(
                constraints: BoxConstraints(maxHeight: 500),
                child: PhotoView(
                  imageProvider: FileImage(imageFile),
                  backgroundDecoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  loadingBuilder: (context, event) => Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.deepPurple,
                  ),
                  onPressed: () {
                    setState(() {
                      _images.removeAt(index);
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },

    );
  }


  void _showSaveNotification() {
    Fluttertoast.showToast(
      msg: 'Content Saved',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.orangeAccent[200],
      textColor: Colors.white,
    );
  }
}
