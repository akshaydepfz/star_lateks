import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_lateks/core/app_spacing.dart';
import 'package:star_lateks/view/customer/services/customer_provider.dart';

class CustomerViewScreen extends StatefulWidget {
  const CustomerViewScreen({super.key});

  @override
  State<CustomerViewScreen> createState() => _CustomerViewScreenState();
}

class _CustomerViewScreenState extends State<CustomerViewScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          provider.whenScrollDownClick();
        },
        child: const Icon(Icons.arrow_downward_outlined),
      ),
      appBar: AppBar(
        title: const Text('Customer Details'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            controller: provider.scrollController,
            physics: const BouncingScrollPhysics(),
            child: const Column(
              children: [
                DetailsTile(title: 'Name', value: 'Name'),
                DetailsTile(title: 'Phone Number', value: 'Phone Number'),
                DetailsTile(title: 'Address', value: 'Address'),
                DetailsTile(title: 'WhatsApp Number', value: 'WhatsApp Number'),
                DetailsTile(
                    title: 'Bank Account Number', value: 'Bank Account Number'),
                DetailsTile(title: 'Advance Paid', value: '12.000/-'),
                DetailsTile(title: 'Advance Balance', value: '12.000/-'),
                DetailsTile(title: 'Total Balance', value: '12.000/-'),
                DetailsTile(title: 'Total Weight', value: '12.000/-'),
                DetailsTile(title: 'Total Amount', value: '12.000/-'),
                DetailsTile(title: 'Total Paid', value: '12.000/-'),
                DetailsTile(title: 'Collected Barrels (Qty)', value: '12'),
                DetailsTile(title: 'Barrels Remining (Qty)', value: '12'),
                DetailsTile(title: 'Total Barrels (Qty)', value: '12'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailsTile extends StatelessWidget {
  const DetailsTile({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        AppSpacing.h10,
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        AppSpacing.h10,
        Divider(
          color: Colors.grey.shade200,
        )
      ],
    );
  }
}
