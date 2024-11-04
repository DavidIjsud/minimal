import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal/modules/clients/viewmodels/clients_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../core/images.dart';

class ImageToUpload extends StatefulWidget {
  const ImageToUpload({super.key});

  @override
  State<ImageToUpload> createState() => _ImageToUploadState();
}

class _ImageToUploadState extends State<ImageToUpload> {
  late ClientsViewModel _clientsViewModel;

  @override
  void initState() {
    super.initState();
    _clientsViewModel = context.read<ClientsViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _clientsViewModel.selectImageFromStorage();
      },
      child: Container(
          width: 140,
          height: 140,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: AssetImage(
                      Images.pictureImage,
                    ), // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text('Upload image',
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height:
                        18.23 / 14, // line-height as a ratio of the font-size
                    color:
                        const Color(0x61080816), // Text color with transparency
                  ))
            ],
          )),
    );
  }
}
