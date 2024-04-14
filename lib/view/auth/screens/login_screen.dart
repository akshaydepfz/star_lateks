import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:star_lateks/common/primary_button.dart';
import 'package:star_lateks/common/primary_text_field.dart';
import 'package:star_lateks/core/app_spacing.dart';
import 'package:star_lateks/view/auth/providers/login_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Start Lateks',
                style: GoogleFonts.kalam(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple)),
            AppSpacing.h20,
            PrimaryTextField(
                hintText: 'email', controller: provider.emailController),
            AppSpacing.h20,
            PrimaryTextField(
                hintText: 'password', controller: provider.passwordController),
            AppSpacing.h20,
            PrimaryButton(
                isLoading: provider.isLoading,
                label: 'Login',
                onTap: () => provider.signInWithEmail(context))
          ],
        ),
      ),
    );
  }
}
