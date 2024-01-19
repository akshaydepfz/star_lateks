import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_lateks/core/app_spacing.dart';
import 'package:star_lateks/view/customer/screens/customer_edit_screen.dart';
import 'package:star_lateks/view/customer/screens/customer_view_screen.dart';
import 'package:star_lateks/view/customer/services/customer_provider.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  @override
  void initState() {
    Provider.of<CustomerProvider>(context, listen: false).getCustomerList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<CustomerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Customer List'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
                child: provider.customerList != null
                    ? ListView.builder(
                        itemCount: provider.customerList!.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            leading: Text(
                              "${i + 1}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            contentPadding: const EdgeInsets.all(0),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CustomerViewScreen()));
                            },
                            title: Text(provider.customerList![i].name),
                            subtitle: Text(provider.customerList![i].address),
                            trailing: IconButton(
                              icon: const Icon(Icons.more_vert),
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return SizedBox(
                                        height: size.height * 0.2,
                                        child: Column(
                                          children: [
                                            ListTile(
                                              leading: const Icon(
                                                  Icons.edit_outlined),
                                              title: const Text('Edit'),
                                              onTap: () {
                                                Navigator.pop(context);
                                                provider.insertEdit(
                                                    provider.customerList![i]);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CustomerEditScreen(
                                                              customerModel:
                                                                  provider
                                                                      .customerList![i],
                                                            )));
                                              },
                                            ),
                                            ListTile(
                                              leading: const Icon(
                                                Icons.delete_outline,
                                                color: Colors.red,
                                              ),
                                              title: const Text(
                                                'Delete',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                              onTap: () {
                                                showModalBottomSheet(
                                                    context: context,
                                                    builder: (context) {
                                                      return SizedBox(
                                                        height:
                                                            size.height * 0.2,
                                                        child: Column(
                                                          children: [
                                                            AppSpacing.h20,
                                                            Text(
                                                                'You want to delete ${provider.customerList![i].name}',
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 16,
                                                                )),
                                                            ListTile(
                                                              leading:
                                                                  const Icon(
                                                                Icons
                                                                    .delete_outline,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                              title: const Text(
                                                                'Yes',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                              onTap: () {},
                                                            ),
                                                            ListTile(
                                                              leading:
                                                                  const Icon(
                                                                Icons.cancel,
                                                              ),
                                                              title: const Text(
                                                                'No',
                                                                style:
                                                                    TextStyle(),
                                                              ),
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    });
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                            ),
                          );
                        })
                    : const Center(child: CircularProgressIndicator())),
          ],
        ),
      )),
    );
  }
}
