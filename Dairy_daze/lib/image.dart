// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
//
// class ImagePickerExample extends StatefulWidget {
//   const ImagePickerExample({Key? key}) : super(key: key);
//
//   @override
//   _ImagePickerExampleState createState() => _ImagePickerExampleState();
// }
//
// class _ImagePickerExampleState extends State<ImagePickerExample> {
//   File? _imageFile;
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: <Widget>[
//         ButtonBar(
//           children: <Widget>[
//             IconButton(
//               icon: Icon(Icons.photo_camera),
//               onPressed: () async => await _pickImageFromCamera(),
//               tooltip: 'Shoot picture',
//             ),
//             IconButton(
//               icon: Icon(Icons.photo),
//               onPressed: () async => await _pickImageFromGallery(),
//               tooltip: 'Pick from gallery',
//             ),
//           ],
//         ),
//         _imageFile == null ? Placeholder() : Image.file(_imageFile!),
//       ],
//     );
//   }
//
//   Future<void> _pickImageFromGallery() async {
//     final XFile? imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (imageFile != null) {
//       setState(() => _imageFile = File(imageFile.path));
//     }
//   }
//
//   Future<void> _pickImageFromCamera() async {
//     final XFile? imageFile = await ImagePicker().pickImage(source: ImageSource.camera);
//     if (imageFile != null) {
//       setState(() => _imageFile = File(imageFile.path));
//     }
//   }
// }