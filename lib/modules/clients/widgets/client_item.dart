import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal/core/app_colors.dart';
import 'package:minimal/general_widgets/modals.dart';
import 'package:minimal/general_widgets/primary_button.dart';
import 'package:minimal/modules/clients/viewmodels/clients_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../core/images.dart';
import '../models/clients.dart';
import 'modal_edit_client.dart';

class ClientItem extends StatefulWidget {
  ClientItem({
    super.key,
    required this.client,
  });

  final Client client;

  @override
  State<ClientItem> createState() => _ClientItemState();
}

class _ClientItemState extends State<ClientItem> {
  final ValueNotifier<bool> _showButtonEdit = ValueNotifier(false);
  late ClientsViewModel _clientViewModel;
  late VoidCallback _onStateChange;

  @override
  initState() {
    super.initState();
    _clientViewModel = context.read<ClientsViewModel>();
    _listenForChangesInState();
  }

  void _listenForChangesInState() {
    _onStateChange = () {
      if (mounted && _clientViewModel.state?.isClientDeletedSuccess == true) {
        _showButtonEdit.value = false;
      }
    };
    _clientViewModel.addListener(_onStateChange);
  }

  @override
  void dispose() {
    super.dispose();
    _clientViewModel.removeListener(_onStateChange);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 326,
          height: 90,
          decoration: const BoxDecoration(
            color: Colors.white, // Ensures opacity is zero
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            border: Border(
              top: BorderSide(width: 1.0, color: Colors.black),
              right: BorderSide(width: 1.0, color: Colors.black),
              bottom: BorderSide(width: 1.0, color: Colors.black),
              left: BorderSide(width: 1.0, color: Colors.black),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors
                        .transparent, // This ensures there's no background
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(37.24),
                      topRight: Radius.circular(37.24),
                      bottomLeft: Radius.circular(37.24),
                      bottomRight: Radius.circular(37.24),
                    ),
                    image: DecorationImage(
                      image: widget.client.photo != null &&
                              widget.client.photo!.isNotEmpty &&
                              widget.client.photo!.startsWith('http')
                          ? NetworkImage(widget.client.photo!)
                          : AssetImage(Images
                              .professionalPicture), // Replace with your image path
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                    width: 10), // Adjust spacing between avatar and text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 180,
                      child: Text(
                        '${widget.client.firstname} ${widget.client.lastname}',
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 1,
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 18.2 /
                              14, // line-height is a ratio of the font-size
                          letterSpacing: 0.25,
                          textBaseline: TextBaseline.alphabetic,
                          color: AppColors.minimalBlack2,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 180,
                      child: Text(
                        widget.client.email ?? '',
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: GoogleFonts.dmSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 15.6 /
                              12, // line-height is a ratio of the font-size
                          letterSpacing: 0.25,
                          color: AppColors.minimalGray2, // hex color
                        ),
                      ),
                    )
                  ],
                ),
                const Expanded(child: SizedBox()),
                IconButton(
                    onPressed: () {
                      _showButtonEdit.value = !_showButtonEdit.value;
                    },
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ))
              ],
            ),
          ),
        ),
        ValueListenableBuilder<bool>(
            valueListenable: _showButtonEdit,
            builder: (_, showEditButton, Widget? w) {
              if (showEditButton) {
                return Positioned(
                    right: 70.0,
                    top: 15.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        PrimaryButton(
                          onTap: () {
                            Modals.openModal(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) {
                                  return ModalEditClient(client: widget.client);
                                });
                          },
                          text: 'Edit',
                          width: 80,
                          height: 30,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Consumer<ClientsViewModel>(
                            builder: (_, clientViewModel, Widget? w) {
                          return PrimaryButton(
                            onTap: clientViewModel.state?.isDeletingClient ==
                                    true
                                ? null
                                : () {
                                    clientViewModel.deleteClient(
                                        widget.client.userId?.toString() ?? "");
                                  },
                            text: 'Delete',
                            width: 80,
                            isLoading:
                                clientViewModel.state?.isDeletingClient == true,
                            height: 30,
                          );
                        })
                      ],
                    ));
              }
              return Container();
            })
      ],
    );
  }
}
