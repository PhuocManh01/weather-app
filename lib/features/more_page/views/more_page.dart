import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/auth/cubit/auth_cubit.dart';
import 'package:weather_app/features/auth/cubit/auth_state.dart';
import 'package:weather_app/features/profile/profile.dart';
import 'package:weather_app/routes/app_routes.dart';
import '../bloc/more_bloc.dart';
import 'widget/menu_button.dart';
import 'widget/menu_data.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (context) => MoreBloc(context.read<AuthCubit>()),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, authState) {
            String currentUsername = "Guest User";
            String currentEmail = "Please login to sync your data";

            if (authState is AuthSuccess) {
              currentUsername = authState.username;
              currentEmail = "$currentUsername@example.com";
            }

            return Stack(
              children: [
                
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/more_page/background.png"),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),

                
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                              image: const DecorationImage(
                                image: AssetImage("assets/images/more_page/avatar.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          Text(
                            currentUsername,
                            style: const TextStyle(fontSize: 25, fontFamily: "SF Pro Display", fontWeight: FontWeight.bold),
                          ),
                          Text(
                            currentEmail,
                            style: const TextStyle(fontSize: 12, fontFamily: "ABeeZee", fontWeight: FontWeight.bold, color: Colors.grey),
                          ),

                          const SizedBox(height: 20),

                          
                          MenuButton(
                            iconButton: menuData[0]["iconButton"],
                            nameButton: menuData[0]["nameButton"],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (newContext) => BlocProvider.value(
                                    value: BlocProvider.of<AuthCubit>(context),
                                    child: const ProfilePage(),
                                  ),
                                ),
                              );
                            },
                          ),
                          MenuButton(
                            iconButton: menuData[1]["iconButton"],
                            nameButton: menuData[1]["nameButton"],
                            onTap: () => Navigator.pushNamed(context, AppRoutes.savedLocationPage)
                          ),
                          MenuButton(
                            iconButton: menuData[2]["iconButton"],
                            nameButton: menuData[2]["nameButton"],
                            onTap: () => Navigator.pushNamed(context, AppRoutes.faq),
                          ),

                          const Divider(thickness: 1, height: 20),

                          
                          MenuButton(
                            iconButton: menuData[3]["iconButton"],
                            nameButton: menuData[3]["nameButton"],
                            onTap: () {},
                          ),
                          MenuButton(
                            iconButton: menuData[4]["iconButton"],
                            nameButton: menuData[4]["nameButton"],
                            onTap: () => Navigator.pushNamed(context, AppRoutes.aboutUs),
                          ),
                          MenuButton(
                            iconButton: menuData[5]["iconButton"],
                            nameButton: menuData[5]["nameButton"],
                            onTap: () => Navigator.pushNamed(context, AppRoutes.contactUs),
                          ),

                          
                          if (authState is AuthSuccess)
                            MenuButton(
                              iconButton: menuData[6]["iconButton"],
                              nameButton: menuData[6]["nameButton"],
                              onTap: () => _handleLogout(context),
                            )
                          else
                            MenuButton(
                              iconButton: Icons.login_rounded,
                              nameButton: "Log In",
                              onTap: () => Navigator.pushNamed(context, AppRoutes.login),
                            ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _handleLogout(BuildContext context) async {
    await context.read<AuthCubit>().logout();
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.bottomNavigationScreen, (route) => false);
    }
  }
}