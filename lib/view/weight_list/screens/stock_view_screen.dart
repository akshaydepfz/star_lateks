import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_lateks/core/app_spacing.dart';
import 'package:star_lateks/view/weight_list/providers/weight_list_provider.dart';
import 'package:star_lateks/view/weight_list/screens/add_barrel_drc.dart';

class StockViewScreen extends StatelessWidget {
  const StockViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeightListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight List details'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Customer Name',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          AppSpacing.h10,
                          Text(
                            'Sadik Ali',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                AppSpacing.h15,
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Customer Address',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          AppSpacing.h10,
                          Text(
                            'Kuttikattur Kozhikode 6733309',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                AppSpacing.h15,
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mobile No.',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          AppSpacing.h10,
                          Text(
                            '+919567602385',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                AppSpacing.h20,
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Advance Paid',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          AppSpacing.h10,
                          Text(
                            '4500',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                AppSpacing.h20,
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Created Date',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          AppSpacing.h10,
                          Text(
                            '12/02/2024',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                AppSpacing.h20,
                const Text(
                  'Barrel details',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                AppSpacing.h10,
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, i) {
                      return ListTile(
                        leading: Text(
                          '${i + 1}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        title: const Text('Barrel 1'),
                        subtitle: const Text('Weight: 120kg'),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurple,
        label: const Row(
          children: [
            Text(
              'Generate Bill',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            AppSpacing.w10,
            Icon(
              Icons.print,
              color: Colors.white,
            ),
          ],
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddbBarrelsDRC()));
        },
      ),
    );
  }
}
