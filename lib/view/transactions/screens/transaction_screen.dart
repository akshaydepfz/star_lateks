import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, i) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(
                          color: Colors.grey.shade200,
                        ),
                      ),
                  itemCount: 2,
                  itemBuilder: (context, i) {
                    return const ListTile(
                      leading: Icon(Icons.schedule),
                      title: Text('Paid Salary'),
                      subtitle: Text('12000 payed to Akshay'),
                      trailing: Text(
                        '12/12/2021',
                        style: TextStyle(color: Colors.green),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
