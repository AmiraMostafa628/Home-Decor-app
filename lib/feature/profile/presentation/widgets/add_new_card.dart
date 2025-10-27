import 'package:decor/feature/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:decor/feature/profile/presentation/bloc/profile_bloc/profile_event.dart';
import 'package:decor/feature/profile/presentation/bloc/profile_bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:decor/core/components/adaptive_input_field.dart';
import 'package:decor/core/components/custom_text_button.dart';
import 'package:decor/core/resources/color_manager.dart';
import 'package:decor/feature/home/presentation/widgets/shared/custom_app_bar.dart';
import 'package:decor/feature/profile/presentation/widgets/card_number_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewCard extends StatefulWidget {
  const AddNewCard({super.key});

  @override
  State<AddNewCard> createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
  final cardNameController = TextEditingController();
  final expireDateController = TextEditingController();
  final cvcCardController = TextEditingController();

  @override
  void dispose() {
    cardNameController.dispose();
    expireDateController.dispose();
    cvcCardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 20,
                        children: [
                          CustomAppBar(title: 'Add Card'),
                          AdaptiveInputField(
                            context: context,
                            title: 'Card Holder Name',
                            hintText: 'John Doe',
                            controller: cardNameController,
                            fillColor: ColorManager.lightPrimaryColor,
                            validate: (value) => null,
                            onSubmit: (value) {
                              ProfileBloc.get(context).add(UpdateCardHolderNameEvent(value));


                            },
                          ),
                          CardNumberField(
                              cardNumber: (value) {},
                              title: 'Card Holder Number'
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            spacing: 20,
                            children: [
                              Expanded(
                                  child: AdaptiveInputField(
                                    context: context,
                                    controller: expireDateController,
                                    title: 'Expire Date',
                                    hintText: 'mm/yyyy',
                                    keyboardType: TextInputType.datetime,
                                    fillColor: ColorManager.lightPrimaryColor,
                                    borderSide: Colors.transparent,
                                    validate: (value) => null,
                                    onSubmit: (value) {
                                      ProfileBloc.get(context).add(UpdateCardExpiryEvent(value));
                                    },)
                              ),
                              Expanded(
                                child: AdaptiveInputField(
                                  context: context,
                                  controller: cvcCardController,
                                  title: 'CVC',
                                  hintText: '***',
                                  keyboardType: TextInputType.number,
                                  fillColor: ColorManager.lightPrimaryColor,
                                  borderSide: Colors.transparent,
                                  validate: (value) => null,
                                  onSubmit: (value) {
                                    ProfileBloc.get(context).add(UpdateCardCvcEvent(value));

                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomTextButton(
                    upperCase: false,
                    width: 250,
                    onPressed: () {},
                    text: 'Save Card',
                  ),
                  const SizedBox(height: 30),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
