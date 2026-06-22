import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/auth/cubit/auth_cubit.dart';

import 'package:weather_app/routes/app_routes.dart';
import 'widget/menu_button.dart';
import 'widget/menu_data.dart';

import '../../core/storage/auth_local_storage.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});


  @override
  Widget build(BuildContext context) {
    String username = "Username";
    if (AuthLocalStorage.getRememberMeFlag()) {
      username = AuthLocalStorage.getUsername();
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                
                image: AssetImage("assets/images/more_page/background.png"),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            padding: const EdgeInsets.all(30),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 30, left: 30, right:30),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          image: DecorationImage(image: AssetImage("assets/images/more_page/avatar.png"), fit: BoxFit.cover)
                        ),
                      ),
                          
                      Text(username,
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: "SF Pro Display",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              
                      Text("user@email.com",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: "ABeeZee",
                          fontWeight: FontWeight.bold,
                        )
                      ),
                          
                      SizedBox(height: 20),
                      
                      MenuButton(
                        iconButton: menuData[0]["iconButton"],
                        nameButton: menuData[0]["nameButton"],
                        onTap: () {
                          
                        },
                      ),
                
                      MenuButton(
                        iconButton: menuData[1]["iconButton"],
                        nameButton: menuData[1]["nameButton"],
                        onTap: () {
                          
                        },
                      ),
                      MenuButton(
                        iconButton: menuData[2]["iconButton"],
                        nameButton: menuData[2]["nameButton"],
                        onTap: () {
                          
                        },
                      ),
              
                      Divider(thickness: 3,),
              
                      MenuButton(
                        iconButton: menuData[3]["iconButton"],
                        nameButton: menuData[3]["nameButton"],
                        onTap: () {
                          
                        },
                      ),
                      MenuButton(
                        iconButton: menuData[4]["iconButton"],
                        nameButton: menuData[4]["nameButton"],
                        onTap: () {
                          
                        },
                      ),
                      MenuButton(
                        iconButton: menuData[5]["iconButton"],
                        nameButton: menuData[5]["nameButton"],
                        onTap: () {
                          
                        },
                      ),
                      MenuButton(
                        iconButton: menuData[6]["iconButton"],
                        nameButton: menuData[6]["nameButton"],
                        onTap: () => _handleLogout(context),
                      ),
                    ],
                  ),
              ),
            ),
          ),
          // ListView.builder(
          //           itemCount: menuData.length,
          //           itemBuilder: (context, index) {
          //             return MenuButton(
          //               iconButton: Icons.person_outline,
          //               nameButton: "menuData[index]['nameButton']",
          //               onTap:() {
                          
          //               },
          //             );
          
          //           }
          //         ),
        ],
      ),
    );
  }

  void _handleLogout(BuildContext context) async {
    await context.read<AuthCubit>().logout();
    if (context.mounted) {
      
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.bottomNavigationScreen,
        (route) => false
      );
    }
  }
}