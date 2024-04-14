import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_lateks/common/primary_button.dart';
import 'package:star_lateks/core/app_spacing.dart';
import 'package:star_lateks/view/weight_list/providers/weight_list_provider.dart';

class WeightListSummarys extends StatelessWidget {
  const WeightListSummarys({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeightListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AppSpacing.h10,
            Center(
              child: Text(
                'Customer Name : ${provider.customerController.text}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            AppSpacing.h20,
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     const Text(
            //       'No',
            //       style: TextStyle(fontSize: 16),
            //     ),
            //     AppSpacing.h10,
            //     const Text(
            //       'Gross Weight',
            //       style: TextStyle(fontSize: 16),
            //     ),
            //     const Text(
            //       'Net Weight',
            //       style: TextStyle(fontSize: 16),
            //     ),
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'No.',
                  style: TextStyle(color: Colors.grey.shade500),
                ),
                AppSpacing.w15,
                Text(
                  'Weight.',
                  style: TextStyle(color: Colors.grey.shade500),
                ),
                AppSpacing.w15,
                Text(
                  'Net Weight.',
                  style: TextStyle(color: Colors.grey.shade500),
                ),
                AppSpacing.w15,
                Text(
                  'Amount.',
                  style: TextStyle(color: Colors.grey.shade500),
                ),
                AppSpacing.w15,
                Text(
                  'Total Amount.',
                  style: TextStyle(color: Colors.grey.shade500),
                ),
                AppSpacing.w15,
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: provider.barrelsCountList.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'No. ${i + 1}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          AppSpacing.w15,
                          Text(
                            provider.barrelsCountList[i].grossWeight,
                            style: const TextStyle(fontSize: 16),
                          ),
                          AppSpacing.w15,
                          const Text(
                            '10',
                            style: TextStyle(fontSize: 16),
                          ),
                          AppSpacing.w15,
                          Text(
                            'ID ${i + 120}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          AppSpacing.w15,
                          const Text(
                            "R10-",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  }),
            ),

            PrimaryButton(
                label: 'Print Pdf',
                onTap: () {
                  provider.generateInvoice(context);
                })
            // Table(
            //   border: TableBorder.all(), // Add a border around the table
            //   children: const [
            //     TableRow(
            //       children: [
            //         TableCell(
            //           child: Center(child: Text('Barells')),
            //         ),
            //         TableCell(
            //           child: Center(child: Text('Gross Weight')),
            //         ),
            //         TableCell(
            //           child: Center(child: Text('Net Weight')),
            //         ),
            //       ],
            //     ),

            //     TableRow(
            //       children: [
            //         TableCell(
            //           child: Center(child: Text('Row 2, Cell 1')),
            //         ),
            //         TableCell(
            //           child: Center(child: Text('Row 2, Cell 2')),
            //         ),
            //         TableCell(
            //           child: Center(child: Text('Row 2, Cell 3')),
            //         ),
            //       ],
            //     ),

            //     // TableRow(
            //     //     children: List<Widget>.generate(
            //     //   provider.barrelsCountList.length,
            //     //   (index) => const TableCell(
            //     //     child: Center(child: Text('Row 2, Cell 3')),
            //     //   ),
            //     // ))
            //   ],
            // ),

            // Expanded(
            //   child: ListView.builder(
            //       itemCount: provider.barrelsCountList.length,
            //       itemBuilder: (context, i) {
            //         return Text(provider.barrelsCountList[i].grossWeight);
            //       }),
            // )
          ],
        ),
      ),
    );
  }
}
