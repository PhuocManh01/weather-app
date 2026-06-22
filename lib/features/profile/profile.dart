import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/auth/cubit/auth_cubit.dart';
import 'package:weather_app/features/auth/cubit/auth_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "My Profile",
          style: TextStyle(
            fontFamily: "SF Pro Display",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
    
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          String username = "Guest User";
          String email = "Please login to sync your data";

          if (authState is AuthSuccess) {
            username = authState.username;
            email = "$username@example.com";
          }

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                
              
                Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 55,
                    color: Colors.green,
                  ),
                ),
                
                const SizedBox(height: 32),

              
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                spacing: 16,
                children: [
                
                  Row(
                    children: [
                      const Icon(Icons.badge_outlined, color: Colors.grey, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Username",
                              style: TextStyle(fontSize: 12, color: Colors.grey, fontFamily: "ABeeZee"),
                            ),
                            Text(
                              username,
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: "SF Pro Display"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const Divider(height: 1, thickness: 0.5, color: Colors.black12),

                
                  Row(
                    children: [
                      const Icon(Icons.mail_outline_rounded, color: Colors.grey, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Email Address",
                              style: TextStyle(fontSize: 12, color: Colors.grey, fontFamily: "ABeeZee"),
                            ),
                            Text(
                              email,
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: "SF Pro Display", color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  ),
);
  }
}