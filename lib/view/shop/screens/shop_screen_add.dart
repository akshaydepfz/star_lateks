import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_lateks/common/primary_button.dart';
import 'package:star_lateks/common/primary_text_field.dart';
import 'package:star_lateks/core/app_spacing.dart';

import 'package:star_lateks/view/shop/services/shop_services.dart';

class ShopAddScreen extends StatefulWidget {
  const ShopAddScreen({super.key});

  @override
  State<ShopAddScreen> createState() => _ShopAddScreenState();
}

class _ShopAddScreenState extends State<ShopAddScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShopServices>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Shop'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              PrimaryTextField(
                  hintText: 'Enter Shop Name',
                  controller: provider.shopNameControll),
              AppSpacing.h20,
              PrimaryTextField(
                  hintText: 'Enter Contact Number',
                  controller: provider.shopContactControll),
              AppSpacing.h20,
              PrimaryTextField(
                  hintText: 'Enter Whatsapp Number',
                  controller: provider.shopWhatsappControll),
              AppSpacing.h20,
              PrimaryTextField(
                  hintText: 'Enter Shop Location',
                  controller: provider.shopLocationControll),
              AppSpacing.h20,
              const Spacer(),
              PrimaryButton(
                  isLoading: provider.isLoading,
                  label: 'Add Shop',
                  onTap: () => provider.addShopToFirestore(context)),
            ],
          ),
        ),
      ),
    );
  }
}
