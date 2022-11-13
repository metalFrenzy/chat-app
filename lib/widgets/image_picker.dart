import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePic extends StatefulWidget {
  final void Function(File? pickedImage) imageUploade;
  ProfilePic(this.imageUploade);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  File? _pickedImage;
  void _takeImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 150,
      imageQuality: 60,
    );
    setState(() {
      _pickedImage = File(image!.path);
    });
    widget.imageUploade(File(image!.path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        TextButton.icon(
          onPressed: _takeImage,
          icon: Icon(Icons.image_outlined),
          label: Text('Take profile Picture'),
        ),
      ],
    );
  }
}
