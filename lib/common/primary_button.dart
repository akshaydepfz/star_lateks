import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
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
            backgroundColor: Colors.deepPurple),
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
            : Text(
                label,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
      ),
    );
  }
}
