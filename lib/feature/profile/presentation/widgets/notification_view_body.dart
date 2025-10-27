import 'package:decor/core/resources/color_manager.dart';
import 'package:decor/feature/home/presentation/widgets/shared/custom_app_bar.dart';
import 'package:decor/feature/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:decor/feature/profile/presentation/bloc/profile_bloc/profile_event.dart';
import 'package:decor/feature/profile/presentation/bloc/profile_bloc/profile_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            spacing: 25.0,
            children: [
              const CustomAppBar(title: 'Notifications'),
              Expanded(
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    return ListView.builder(
                      itemCount: state.settings.length,
                      itemBuilder: (context, index) {
                        final item = state.settings[index];
                        return SwitchListTile(
                          activeColor: ColorManager.whiteColor,
                          activeTrackColor: ColorManager.primaryColor,
                          inactiveThumbColor: ColorManager.whiteColor,
                          inactiveTrackColor: ColorManager.inActiveSwitchColor,
                          trackOutlineColor: WidgetStateProperty.all(
                            Colors.transparent,
                          ),
                          title: Text(item.title),
                          value: item.isEnabled,
                          onChanged: (value) {
                            ProfileBloc.get(context).add(
                              ToggleSettingEvent(id: item.id, newValue: value),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
