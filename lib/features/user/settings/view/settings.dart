import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/routes_name.dart';
import '../../../../constant/color.dart';
import '../../../common/cubit/common_cubit.dart';
import '../../../common/utils/common.dart';
import '../../auth/bloc/auth_bloc.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 248, 248, 255),
        title: Text(
          AppLocalizations.of(context)!.titleSettingsPage,
          style: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _languageSetting(context),
            const SizedBox(height: 20),
            _logoutSetting(
              context,
              onTap: () {
                context.read<CommonCubit>().deleteUserLocale();
                context.read<AuthBloc>().add(AuthOut());
                context.goNamed(AppRouteConstants.loginRoute);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _languageSetting(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.language),
            const SizedBox(width: 5),
            Text(
              AppLocalizations.of(context)!.languageSettings,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
        _dropDownLanguage(context)
      ],
    );
  }

  Widget _logoutSetting(BuildContext context, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Icon(
            Icons.logout,
            color: darkBlue,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            AppLocalizations.of(context)!.logout,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }

  Widget _dropDownLanguage(BuildContext context) {
    return PopupMenuButton(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (value) {
        context.read<CommonCubit>().chageLocale(Locale(value));
      },
      itemBuilder: (context) => popUpLayerEntry,
      child: Row(
        children: [
          Builder(builder: (context) {
            return Text(
              context.watch<CommonCubit>().state.languageCode,
              style: const TextStyle(
                  color: darkBlue,
                  fontSize: 15,
                  decoration: TextDecoration.underline),
            );
          }),
          const Icon(
            Icons.arrow_drop_down,
            color: darkBlue,
          )
        ],
      ),
    );
  }

  final List<PopupMenuEntry<String>> popUpLayerEntry = [
    const PopupMenuItem(value: "id", child: Text('Indonesia')),
    const PopupMenuDivider(height: 10),
    const PopupMenuItem(value: "en", child: Text('English')),
  ];
}
