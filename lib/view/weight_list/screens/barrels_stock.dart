import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_lateks/core/app_spacing.dart';
import 'package:star_lateks/view/weight_list/providers/weight_list_provider.dart';
import 'package:star_lateks/view/weight_list/screens/stock_view_screen.dart';

class BarrelsStockScreen extends StatefulWidget {
  const BarrelsStockScreen({super.key});

  @override
  State<BarrelsStockScreen> createState() => _BarrelsStockScreenState();
}

class _BarrelsStockScreenState extends State<BarrelsStockScreen> {
  @override
  void initState() {
    Provider.of<WeightListProvider>(context, listen: false).getStockBarrels();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeightListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barrels Stock'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search),
                  AppSpacing.w10,
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                    ),
                  )),
                ],
              ),
            ),
            Expanded(
              child: provider.stockBarrels == null
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: Colors.deepPurple,
                    ))
                  : ListView.separated(
                      itemBuilder: (context, i) {
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const StockViewScreen()));
                          },
                          title: Text(provider.stockBarrels![i].customerName),
                          subtitle: Text(
                            provider.stockBarrels![i].date,
                            style: const TextStyle(color: Colors.green),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        );
                      },
                      separatorBuilder: (context, i) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Divider(
                              color: Colors.grey.shade200,
                            ),
                          ),
                      itemCount: provider.stockBarrels!.length),
            ),
          ],
        ),
      ),
    );
  }
}
