import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal/core/app_colors.dart';
import 'package:minimal/general_widgets/modals.dart';
import 'package:minimal/general_widgets/primary_button.dart';
import 'package:minimal/modules/clients/viewmodels/clients_viewmodel.dart';
import 'package:minimal/modules/clients/widgets/client_item.dart';
import 'package:minimal/modules/clients/widgets/modal_add_client.dart';
import 'package:provider/provider.dart';

import '../../../core/images.dart';
import '../widgets/search_client_field.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  late ClientsViewModel _clientsViewModel;

  @override
  void initState() {
    super.initState();
    _clientsViewModel = context.read<ClientsViewModel>();
    _clientsViewModel.initViewModel();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _clientsViewModel.getClients();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
              left: 0.0,
              child: Image.asset(
                Images.backgroundClientsTopLeft,
              ),
            ),
            Positioned(
              right: 0.0,
              bottom: MediaQuery.of(context).size.height * 0.25,
              child: Image.asset(
                Images.backgroundClientsCenterRight,
                width: 350.0,
              ),
            ),
            Positioned(
              bottom: 0.0,
              right: 150,
              child: Image.asset(
                Images.backgroundLoginBottomCenter,
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 5.0,
              child: Image.asset(
                Images.backgroundClientsBottomRight,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    Image.asset(
                      Images.minimalLogo,
                      width: 150.0,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'CLIENTS',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.dmSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            height: 20 / 20, // line-height as a ratio
                            letterSpacing: 1,
                            color: const Color(
                                0xFF0434545) // Te// Background color
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SearchClientField(),
                        PrimaryButton(
                          onTap: () {
                            Modals.openModal(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) {
                                  return ModalAddClient();
                                });
                          },
                          width: 93,
                          height: 29,
                          text: 'ADD NEW',
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.55,
                      width: MediaQuery.of(context).size.width,
                      child: Consumer<ClientsViewModel>(
                          builder: (_, clientsViewModel, Widget? w) {
                        if (clientsViewModel.state?.areClientsLoaded == true) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  clientsViewModel.state!.amountOfClientsToShow,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: ClientItem(
                                    client: _clientsViewModel
                                        .state!.clients![index],
                                  ),
                                );
                              });
                        }

                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.blackPrimary,
                          ),
                        );
                      }),
                    ),
                    Expanded(child: Container()),
                    Consumer<ClientsViewModel>(
                        builder: (_, clientsViewModel, Widget? w) {
                      return PrimaryButton(
                        onTap: clientsViewModel.state?.isLoadingClients == true
                            ? null
                            : () {
                                clientsViewModel.loadNextFivesClients();
                              },
                        isLoading:
                            clientsViewModel.state?.isLoadingClients ?? false,
                        text: 'LOAD MORE',
                      );
                    }),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
