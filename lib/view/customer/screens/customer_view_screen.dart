import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_lateks/core/app_spacing.dart';
import 'package:star_lateks/view/customer/services/customer_provider.dart';

class CustomerViewScreen extends StatefulWidget {
  const CustomerViewScreen({super.key, required this.id});
  final String id;
  @override
  State<CustomerViewScreen> createState() => _CustomerViewScreenState();
}

class _CustomerViewScreenState extends State<CustomerViewScreen> {
  @override
  void initState() {
    Provider.of<CustomerProvider>(context, listen: false)
        .getCustomer(widget.id);
    super.initState();
  }

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
        child: provider.customerList == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  controller: provider.scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      DetailsTile(
                          title: 'Name', value: provider.customerModel!.name),
                      DetailsTile(
                          title: 'Phone Number',
                          value: provider.customerModel!.phone),
                      DetailsTile(
                          title: 'Address',
                          value: provider.customerModel!.address),
                      DetailsTile(
                          title: 'WhatsApp Number',
                          value: provider.customerModel!.whatsApp),
                      DetailsTile(
                          title: 'Bank Account Number',
                          value: provider.customerModel!.bankAccount),
                      DetailsTile(
                          title: 'Advance Paid',
                          value:
                              provider.customerModel!.advanceAmount.toString()),
                      DetailsTile(
                          title: 'Advance Balance',
                          value:
                              provider.customerModel!.advanceAmount.toString()),
                      DetailsTile(
                          title: 'Total Balance',
                          value: provider.customerModel!.remainingAmount
                              .toString()),
                      DetailsTile(
                          title: 'Total Weight',
                          value:
                              provider.customerModel!.totalWeight.toString()),
                      DetailsTile(
                          title: 'Total Amount',
                          value:
                              provider.customerModel!.totalAmount.toString()),
                      DetailsTile(
                          title: 'Total Paid',
                          value:
                              provider.customerModel!.totalAmount.toString()),
                      DetailsTile(
                          title: 'Collected Barrels (Qty)',
                          value:
                              provider.customerModel!.barrelsTaken.toString()),
                      DetailsTile(
                          title: 'Barrels Remining (Qty)',
                          value: provider.customerModel!.barrelsRemaining
                              .toString()),
                      DetailsTile(
                          title: 'Total Barrels (Qty)',
                          value:
                              provider.customerModel!.barrelsTaken.toString()),
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
