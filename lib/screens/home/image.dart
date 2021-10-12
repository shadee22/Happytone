// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';

// class Imager extends StatefulWidget {
//   const Imager({Key? key}) : super(key: key);

//   @override
//   _ImagerState createState() => _ImagerState();
// }

// // final ImagePicker _picker = ImagePicker();

// class _ImagerState extends State<Imager> {
//   /// Variables

//   // _getFromGallery() async {
//   //   XFile? pickedFile = await ImagePicker().pickImage(
//   //     source: ImageSource.gallery,
//   //     maxWidth: 1800,
//   //     maxHeight: 1800,
//   //   );
//   //   if (mounted) {
//   //     if (pickedFile != null) {
//   //       setState(() {
//   //         imageFile = File(pickedFile.path);
//   //       });
//   //     }
//   //   }
//   // }

//   // /// Get from Camera
//   // _getFromCamera() async {
//   //   PickedFile? pickedFile = await ImagePicker().getImage(
//   //     source: ImageSource.camera,
//   //     maxWidth: 1800,
//   //     maxHeight: 1800,
//   //   );
//   //   if (mounted) {
//   //     if (pickedFile != null) {
//   //       setState(() {
//   //         imageFile = File(pickedFile.path);
//   //       });
//   //     }
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     File? customImageFile;
//     @override
//     Future getImage() async {
//       var image = await ImagePicker().pickImage(source: ImageSource.camera);
//       if (!mounted) return;

//       setState(() {
//         if (mounted) {
//           customImageFile = File(image!.path);
//         }
//       });
//       print('customImageFile: $customImageFile ');
//     }

//     File? imageFile;
//     print("imageFile is $imageFile");
//     return Container(
//         child: Column(
//       children: [
//         Container(
//           alignment: Alignment.center,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               RaisedButton(
//                 color: Colors.greenAccent,
//                 onPressed: () {
//                   // _getFromGallery();
//                 },
//                 child: Text("PICK FROM GALLERY"),
//               ),
//               Container(
//                 height: 40.0,
//               ),
//               RaisedButton(
//                 color: Colors.lightGreenAccent,
//                 onPressed: () {
//                   // _getFromCamera();
//                   getImage();
//                 },
//                 child: Text("PICK FROM CAMERA"),
//               )
//             ],
//           ),
//         ),
//         if (customImageFile != null)
//           Container(
//             child: Image.file(
//               customImageFile!,
//               fit: BoxFit.cover,
//             ),
//           )
//       ],
//     ));
//   }
// }
