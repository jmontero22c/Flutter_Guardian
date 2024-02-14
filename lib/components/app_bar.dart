import 'package:flutter/material.dart';
import 'package:my_app/Colors/colors.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String tittle;
  final IconButton? iconLeading;
  const AppBarCustom({super.key, required this.tittle, this.iconLeading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.secondColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
      centerTitle: true,
      title: Text(
        tittle,
        style: const TextStyle(fontSize: 19),
      ),
      iconTheme: const IconThemeData(color: AppColors.mainColor),
      leading: iconLeading,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(45);
}
