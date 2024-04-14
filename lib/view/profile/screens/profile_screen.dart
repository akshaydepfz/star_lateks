import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:star_lateks/core/app_spacing.dart';
import 'package:star_lateks/view/auth/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              AppSpacing.h20,
              AppSpacing.h20,
              const SizedBox(
                height: 20,
              ),
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/avatar.jpg'),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                FirebaseAuth.instance.currentUser!.email!,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const ProfileCard(icon: Icons.support_agent, title: "Support"),
              AppSpacing.h20,
              const ProfileCard(
                  icon: Icons.password_outlined, title: "Change Password"),
              AppSpacing.h20,
              const ProfileCard(
                icon: Icons.privacy_tip_outlined,
                title: "Privacy Policy",
              ),
              AppSpacing.h20,
              ProfileCard(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
                icon: Icons.logout,
                title: "Logout",
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.color = Colors.deepPurple,
  });
  final IconData icon;
  final String title;
  final Function()? onTap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          color: color,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: color,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: color,
          ),
        ),
      ),
    );
  }
}
