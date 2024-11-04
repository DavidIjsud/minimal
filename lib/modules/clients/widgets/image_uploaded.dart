import 'dart:io';

import 'package:flutter/material.dart';

class ImageUploaded extends StatelessWidget {
  const ImageUploaded({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle, // This ensures there's no background
        image: DecorationImage(
          image: FileImage(File(path)), // Replace with your image path
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
