import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal/core/app_colors.dart';
import 'package:minimal/core/navigation.dart';
import 'package:minimal/general_widgets/primary_button.dart';
import 'package:minimal/general_widgets/primary_textfield.dart';
import 'package:minimal/modules/clients/models/clients.dart';
import 'package:minimal/modules/clients/viewmodels/clients_viewmodel.dart';
import 'package:provider/provider.dart';

import 'image_to_upload.dart';
import 'image_uploaded.dart';

class ModalAddClient extends StatefulWidget {
  @override
  State<ModalAddClient> createState() => _ModalAddClientState();
}

class _ModalAddClientState extends State<ModalAddClient> {
  late TextEditingController _nameController,
      _emailController,
      _lastNameController;
  late ClientsViewModel _clientsViewModel;
  late VoidCallback _onStateChange;

  @override
  void initState() {
    super.initState();
    _clientsViewModel = context.read<ClientsViewModel>();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _lastNameController = TextEditingController();
    _listenForChangesInState();
  }

  _listenForChangesInState() {
    _onStateChange = () {
      if (mounted &&
          _clientsViewModel.state!.isClientSavedSuccess != null &&
          _clientsViewModel.state!.isClientSavedSuccess!) {
        _clientsViewModel.unSelectedImageFromStorage();
        NavigatorApp.pop(context);
      }
    };
    _clientsViewModel.addListener(_onStateChange);
  }

  @override
  void dispose() {
    super.dispose();
    _clientsViewModel.removeListener(_onStateChange);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 301,
      height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0),
          ),
        ],
      ),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 20.0), // No padding inside
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Add new client',
                style: GoogleFonts.dmSans(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  height: 22.13 / 17,
                  color: const Color(0xFF222222),
                ),
              ),
            ),
            const SizedBox(
              height: 45.0,
            ),
            Consumer<ClientsViewModel>(
                builder: (_, clientViewModel, Widget? w) {
              return DottedBorder(
                dashPattern: const [6, 3, 2, 3],
                borderType: BorderType.Circle,
                color: AppColors.minimalYellow,
                child: clientViewModel.state?.pathImagenSelectedFromStorage !=
                            null &&
                        clientViewModel
                            .state!.pathImagenSelectedFromStorage!.isNotEmpty
                    ? ImageUploaded(
                        path: clientViewModel
                            .state!.pathImagenSelectedFromStorage!,
                      )
                    : const ImageToUpload(),
              );
            }),
            const SizedBox(
              height: 20.0,
            ),
            PrimaryTextfield(
              controller: _nameController,
              hintText: 'First name*',
            ),
            const SizedBox(
              height: 10.0,
            ),
            PrimaryTextfield(
              controller: _lastNameController,
              hintText: 'Last name*',
            ),
            const SizedBox(
              height: 10.0,
            ),
            PrimaryTextfield(
              controller: _emailController,
              hintText: 'Email address*',
            ),
            const SizedBox(
              height: 24.0,
            ),
            Consumer<ClientsViewModel>(
                builder: (_, clientsViewModel, Widget? w) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: clientsViewModel.state?.isSavingClient == true
                        ? null
                        : () {
                            NavigatorApp.pop(context);
                          },
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 18.23 /
                            14, // line-height as a ratio of the font-size
                        color: const Color(
                            0x61080816), // Text color with transparency
                      ),
                    ),
                  ),
                  PrimaryButton(
                    onTap: clientsViewModel.state?.isSavingClient == true
                        ? null
                        : () {
                            clientsViewModel.addClient(Client(
                              firstname: _nameController.text,
                              lastname: _lastNameController.text,
                              email: _emailController.text,
                              address: '',
                              photo: clientsViewModel
                                  .state?.pathImagenSelectedFromStorage,
                              caption: '',
                            ));
                          },
                    width: 159.0,
                    isLoading: clientsViewModel.state?.isSavingClient == true,
                    height: 40.0,
                    text: 'SAVE',
                  )
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
