import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/routes/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_state.dart';
import '../cubit/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  bool _rememberMe = false;
  late TextEditingController _passwordController;
  late TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    loadSavedCredentials();
  }

  void loadSavedCredentials() {
    final savedData = context.read<AuthCubit>().getSavedCredentials();
    if (savedData != null) {
      _rememberMe = true;
      _usernameController.text = savedData['username'] ?? '';
      _passwordController.text = savedData['password'] ?? '';
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Center(
              child: SizedBox(
                height: 300,
                width: 300,
                child: SvgPicture.asset("assets/images/login_page/login_image.svg"),
              ),
            ),
            
            SizedBox(height: 20),
    
            Text(
              "Login",
              style: TextStyle(
                color: Colors.green,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontFamily: "SF Pro Display"
              ),
              textAlign: TextAlign.left,
            ),
    
            Text("Please login to get your local AQI data",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
                fontFamily: "ABeeZee",
                fontStyle: FontStyle.italic
              ),
            ),
    
            SizedBox(height: 10),
            BlocConsumer<AuthCubit, AuthState> (
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    Navigator.pushNamedAndRemoveUntil(
                      context, 
                      AppRoutes.bottomNavigationScreen, 
                      (route) => false
                      );
                  }
                },
                
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state is AuthFailure)
                        Padding(
                          padding: EdgeInsetsGeometry.all(10),
                          child: Text(
                            state.message,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontFamily: "ABeeZee",
                            ),
                          ),
                        ),

                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail),
                          labelText: "Username",
                          labelStyle : TextStyle(fontSize: 15, color: Colors.grey),
                          // border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15)
                        ),
                        controller: _usernameController,
                      ),
              
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.key),
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility,),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          labelText: "Password",
                          labelStyle : TextStyle(fontSize: 15, color: Colors.grey),
                          // border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15)
                        ),
                        obscureText: _obscurePassword,
                        controller: _passwordController,
                      ),
              
                      SizedBox(height: 20),
              
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (bool? value) {
                              setState(() {
                                _rememberMe = value ?? false;
                              });
                            },
                          ),
              
                          Text("Remember me", style: TextStyle(fontFamily: "ABeeZee", fontSize: 14)),
              
                          Spacer(),
              
                          TextButton(
                            onPressed: () {
                              // Handle forgot password
                            },
                            
                            child: Text("Forgot Password?", style: TextStyle(color: Colors.blue, fontFamily: "SF Pro Display", fontSize: 14)),
                          )
                        ],
                      ),
              
                      SizedBox(
                        width: double.infinity,
                        child: 
                          state is AuthLoading 
                          ? const Center(
                              child: CircularProgressIndicator()
                            ) 
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15)
                              ),
                              onPressed: () => context.read<AuthCubit>().login(
                                _usernameController.text.trim(),
                                _passwordController.text.trim(),
                                _rememberMe,
                              ),
                              child: Text("Login", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            ),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      );
  }
}