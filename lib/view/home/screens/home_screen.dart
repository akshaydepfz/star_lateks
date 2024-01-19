import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:star_lateks/core/app_color.dart';
import 'package:star_lateks/core/app_icons.dart';
import 'package:star_lateks/core/app_spacing.dart';
import 'package:star_lateks/view/home/provider/home_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Star Lateks',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: () {}, icon: AppIcon.search),
                      AppSpacing.w10,
                      IconButton(
                        onPressed: () {},
                        icon: AppIcon.bell,
                        height: 25,
                        width: 25,
                      ),
                    ],
                  ),
                ],
              ),
              AppSpacing.h20,
              Container(
                padding: const EdgeInsets.all(10),
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(AppColor.primaryColor)),
                child: const Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          margin: const EdgeInsets.all(15),
          height: 70,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: Color(AppColor.primaryColor),
              borderRadius: BorderRadius.all(Radius.circular(90))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () => provider.changeIndexByTap(0),
                icon: AppIcon.home,
                color: provider.selectedIndex == 0 ? Colors.white : Colors.grey,
              ),
              IconButton(
                height: 35,
                width: 35,
                onPressed: () => provider.changeIndexByTap(1),
                icon: AppIcon.file,
                color: provider.selectedIndex == 1 ? Colors.white : Colors.grey,
              ),
              IconButton(
                height: 35,
                width: 35,
                onPressed: () => provider.changeIndexByTap(2),
                icon: AppIcon.spending,
                color: provider.selectedIndex == 2 ? Colors.white : Colors.grey,
              ),
              IconButton(
                onPressed: () => provider.changeIndexByTap(3),
                icon: AppIcon.user,
                color: provider.selectedIndex == 3 ? Colors.white : Colors.grey,
              ),
            ],
          )),
    );
  }
}

class IconButton extends StatelessWidget {
  const IconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.height = 30,
    this.width = 30,
    this.color = Colors.black,
  });
  final String icon;
  final Function() onPressed;
  final double height;
  final double width;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
          height: height,
          width: width,
          child: SvgPicture.asset(
            icon,
            // ignore: deprecated_member_use
            color: color,
            fit: BoxFit.cover,
          )),
    );
  }
}
