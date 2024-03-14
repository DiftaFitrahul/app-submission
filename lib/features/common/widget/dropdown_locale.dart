import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/constant/color.dart';

import '../cubit/common_cubit.dart';

class DropDownLocale extends StatelessWidget {
  DropDownLocale({super.key});

  final List<PopupMenuEntry<String>> popUpLayerEntry = [
    const PopupMenuItem(value: "id", child: Text('Indonesia')),
    const PopupMenuDivider(height: 10),
    const PopupMenuItem(value: "en", child: Text('English')),
  ];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (value) {
        context.read<CommonCubit>().chageLocale(Locale(value));
      },
      itemBuilder: (context) => popUpLayerEntry,
      child: CircleAvatar(
        backgroundColor: darkBlue,
        child: Builder(builder: (context) {
          return Text(
            context.watch<CommonCubit>().state.languageCode,
            style: const TextStyle(color: Colors.white),
          );
        }),
      ),
    );
  }
}
