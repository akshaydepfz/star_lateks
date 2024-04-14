import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:star_lateks/core/app_icons.dart';
import 'package:star_lateks/core/app_spacing.dart';
import 'package:star_lateks/view/common/app_alert.dart';
import 'package:star_lateks/view/home/provider/home_provider.dart';
import 'package:star_lateks/view/home/screens/landing_screen.dart.dart';
import 'package:star_lateks/view/notification/screens/notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // Provider.of<HomeProvider>(context, listen: false)
    //     .requestPermissions(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                height: 250.0,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 68, 22, 237),
                      Color.fromARGB(255, 150, 143, 244),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.now_widgets_outlined,
                            size: 25,
                            color: Colors.white,
                          ),
                          const Text(
                            'Welcome Back',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NotificationScreen()));
                            },
                            child: SvgPicture.asset(
                              AppIcon.bell,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      AppSpacing.h20,
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Total Balance',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '₹0.00',
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          AppSpacing.h10,
                          Row(
                            children: [
                              Icon(
                                Icons.trending_up,
                                size: 20,
                                color: Colors.white,
                              ),
                              AppSpacing.w10,
                              Text(
                                '+0% This month',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 210,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          HomeBoxCard(
                            icon: Icons.group_outlined,
                            title: 'Customers',
                            amount: '0',
                            trending: '0+ This month',
                          ),
                          AppSpacing.w15,
                          HomeBoxCard(
                            icon: Icons.inventory_2_outlined,
                            title: 'Weight List',
                            amount: '0',
                            trending: '0+ This month',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      child: Row(
                        children: [
                          HomeBoxCard(
                            icon: Icons.attach_money,
                            title: 'Revenue',
                            amount: '₹0.00',
                            trending: '+0% This month',
                          ),
                          AppSpacing.w15,
                          HomeBoxCard(
                            icon: Icons.attach_money,
                            title: 'Expense',
                            amount: '₹0.00',
                            trending: '+0% This month',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Transactions',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        AppSpacing.h10,

                        Center(child: Text('No Transactions found!'))
                        // Row(
                        //   children: [
                        //     Container(
                        //       padding: const EdgeInsets.all(12.0),
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(8.0),
                        //         border: Border.all(color: Colors.grey.shade300),
                        //       ),
                        //       child: const Text(
                        //         'Customer add',
                        //         style: TextStyle(
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     )
                        //   ],
                        // )

                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width,
                        //   child: ListView.builder(
                        //     physics: const NeverScrollableScrollPhysics(),
                        //     shrinkWrap: true,
                        //     itemBuilder: (context, i) {
                        //       return const ListTile(
                        //         title: Text('Paid 12000 to andul '),
                        //       );
                        //     },
                        //     itemCount: 10,
                        //   ),
                        // )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
