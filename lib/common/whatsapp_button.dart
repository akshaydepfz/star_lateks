import 'package:flutter/material.dart';
import 'package:star_lateks/core/app_spacing.dart';

class WhatsappButton extends StatelessWidget {
  const WhatsappButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isLoading = false,
  });
  final String label;
  final Function() onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width / 1,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: onTap,
        child: isLoading
            ? const SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/whatsapp.png',
                      width: 30, height: 30),
                  AppSpacing.w10,
                  Text(
                    label,
                    style: const TextStyle(fontSize: 16, color: Colors.green),
                  ),
                ],
              ),
      ),
    );
  }
}
