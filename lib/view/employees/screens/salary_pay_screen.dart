import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_lateks/common/primary_button.dart';
import 'package:star_lateks/common/primary_text_field.dart';
import 'package:star_lateks/core/app_spacing.dart';
import 'package:star_lateks/view/employees/services/employe_service.dart';

class SalaryPayScreen extends StatefulWidget {
  const SalaryPayScreen({super.key});

  @override
  State<SalaryPayScreen> createState() => _SalaryPayScreenState();
}

class _SalaryPayScreenState extends State<SalaryPayScreen> {
  @override
  void initState() {
    Provider.of<EmployeeService>(context, listen: false).getEmployee();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmployeeService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salary Pay'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
                child: provider.employees == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: provider.employees!.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            onTap: () {},
                            title: Text(provider.employees![i].name),
                            subtitle: Row(
                              children: [
                                Text(
                                  "Basic: ${provider.employees![i].salary.toString()}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Remining : ${provider.employees![i].reminingSalary.toString()}",
                                  style: const TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.payments_outlined,
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                          child: Container(
                                            padding: const EdgeInsets.all(15),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                PrimaryTextField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    hintText: 'Enter Amount',
                                                    controller: provider
                                                        .paymentController),
                                                AppSpacing.h20,
                                                PrimaryButton(
                                                    label: 'Pay',
                                                    onTap: () =>
                                                        provider.payEmployee(
                                                            context,
                                                            provider
                                                                .employees![i]
                                                                .id,
                                                            provider
                                                                .employees![i]
                                                                .reminingSalary))
                                              ],
                                            ),
                                          ),
                                        ));
                              },
                            ),
                          );
                        })),
          ],
        ),
      ),
    );
  }
}
