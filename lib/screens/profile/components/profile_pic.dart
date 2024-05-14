import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({Key? key}) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  File? _image;

  Future<void> _getImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: _image != null ? FileImage(_image!) : null,
            child: _image == null ? const Icon(Icons.person) : null,
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: const Color(0xFFF5F6F9),
                  shape: CircleBorder(),
                ),
                onPressed: _getImageFromCamera,
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                  size: 24,
                ),
                
              ),
              
            ),
           
          ),
        ],
      ),
    );
  }
}
