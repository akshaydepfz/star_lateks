import 'package:flutter/material.dart';
import 'package:star_lateks/common/primary_button.dart';
import 'package:star_lateks/core/app_spacing.dart';
import 'package:star_lateks/models/shop_weight_model.dart';
import 'package:star_lateks/view/sales/screens/drc_add_screen.dart';

class SalesDetailsViewScreen extends StatelessWidget {
  const SalesDetailsViewScreen({super.key, required this.shopWeightModel});
  final ShopWeightModel shopWeightModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sales Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            ListTile(
              title: const Text('Shop Name'),
              subtitle: Text(shopWeightModel.shop),
            ),
            ListTile(
              title: const Text('Advance'),
              subtitle: Text(shopWeightModel.advance),
            ),
            ListTile(
              title: const Text('Net Weight'),
              subtitle: Text(shopWeightModel.netWeight),
            ),
            ListTile(
              title: const Text('Vehicle Weight'),
              subtitle: Text(shopWeightModel.vehicleWeight),
            ),
            ListTile(
              title: const Text('Created At'),
              subtitle: Text(shopWeightModel.createdAt),
            ),
            AppSpacing.h20,
            PrimaryButton(
                label: 'Complete DRC',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SalesDRCAddScreen()));
                })
          ],
        ),
      ),
    );
  }
}
