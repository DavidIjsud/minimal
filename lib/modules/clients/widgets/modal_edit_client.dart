import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal/core/navigation.dart';
import 'package:minimal/modules/clients/widgets/image_to_upload.dart';
import 'package:provider/provider.dart';

import '../../../core/app_colors.dart';
import '../../../core/images.dart';
import '../../../general_widgets/primary_button.dart';
import '../../../general_widgets/primary_textfield.dart';
import '../models/clients.dart';
import '../viewmodels/clients_viewmodel.dart';
import 'image_uploaded.dart';

class ModalEditClient extends StatefulWidget {
  final Client client;
  const ModalEditClient({super.key, required this.client});

  @override
  State<ModalEditClient> createState() => _ModalEditClientState();
}

class _ModalEditClientState extends State<ModalEditClient> {
  late ClientsViewModel _clientsViewModel;
  late TextEditingController _nameController,
      _emailController,
      _lastNameController;
  late VoidCallback _onStateChange;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.client.firstname);
    _emailController = TextEditingController(text: widget.client.email);
    _lastNameController = TextEditingController(text: widget.client.lastname);
    _clientsViewModel = context.read<ClientsViewModel>();
    _onStateChange = () {
      if (mounted && _clientsViewModel.state?.isClientEditedSuccess == true) {
        NavigatorApp.pop(context);
      }
    };
    _listenForChangesInState();
  }

  _listenForChangesInState() {
    _clientsViewModel.addListener(_onStateChange);
  }

  @override
  void dispose() {
    super.dispose();
    _clientsViewModel.removeListener(_onStateChange);
    _nameController.dispose();
    _emailController.dispose();
    _lastNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 301, // Fixed width
      height: 500, // Fixed height
      decoration: BoxDecoration(
        color: Colors.white, // Default background color for visibility
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10), // Top-left border radius
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(0), // Setting opacity to 0 as specified
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
                'Edit Client',
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
            DottedBorder(
                dashPattern: const [6, 3, 2, 3],
                borderType: BorderType.Circle,
                color: AppColors.minimalYellow,
                child: widget.client.photo != null &&
                        widget.client.photo!.isNotEmpty &&
                        widget.client.photo!.startsWith('http')
                    ? Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape
                              .circle, // This ensures there's no background
                          image: DecorationImage(
                            image: NetworkImage(widget
                                .client.photo!), // Replace with your image path
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Consumer<ClientsViewModel>(
                        builder: (_, clientViewModel, Widget? w) {
                        return clientViewModel
                                        .state?.pathImagenSelectedFromStorage !=
                                    null &&
                                clientViewModel.state!
                                    .pathImagenSelectedFromStorage!.isNotEmpty
                            ? ImageUploaded(
                                path: clientViewModel
                                    .state!.pathImagenSelectedFromStorage!,
                              )
                            : const ImageToUpload();
                      })),
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
                builder: (_, clientViewModel, Widget? w) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: clientViewModel.state?.isEditingClient == true
                        ? null
                        : () {
                            clientViewModel.unSelectedImageFromStorage();
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
                    onTap: clientViewModel.state?.isEditingClient == true
                        ? null
                        : () {
                            clientViewModel.editClient(widget.client.copyWith(
                              firstname: _nameController.text,
                              lastname: _lastNameController.text,
                              email: _emailController.text,
                              photo: clientViewModel
                                  .state?.pathImagenSelectedFromStorage,
                            ));
                          },
                    width: 159.0,
                    height: 40.0,
                    isLoading: clientViewModel.state?.isEditingClient == true,
                    text: 'EDIT',
                  )
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
