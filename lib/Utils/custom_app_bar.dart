import 'package:flutter/material.dart';
import 'package:pingolearn_ecommerce_app/Providers/timer.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color appBarBgColor;
  final Color titleColor;
  final Color appConstColors;
  final bool isHome;
  final VoidCallback onLogOutPressed;
  const CustomAppBar(
      {super.key,
      required this.appBarBgColor,
      required this.titleColor,
      required this.appConstColors,
      this.isHome = false,
      this.onLogOutPressed = _defaultLogOut});
  static void _defaultLogOut() {}
  @override
  Widget build(BuildContext context) {
    String currentTime = Provider.of<TimerProvider>(context).currentTime;

    return AppBar(
      backgroundColor: appBarBgColor,
      toolbarHeight: 80,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  currentTime,
                  style: TextStyle(
                    fontSize: 12,
                    color: appConstColors,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.wifi,
                      size: 18,
                      color: appConstColors,
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.battery_full,
                      size: 18,
                      color: appConstColors,
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.more_horiz,
                      size: 18,
                      color: appConstColors,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'e-shop',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                ),
                isHome
                    ? IconButton(
                        onPressed: onLogOutPressed,
                        icon: Icon(
                          Icons.power_settings_new_rounded,
                          size: 20,
                          color: appConstColors,
                        ),
                        tooltip: 'Log out')
                    : const SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
