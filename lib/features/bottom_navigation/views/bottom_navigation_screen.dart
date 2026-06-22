import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/auth/cubit/auth_cubit.dart';
import 'package:weather_app/features/bottom_navigation/bottom_navigation.dart';
import 'package:weather_app/features/bottom_navigation/cubit/navigation_cubit.dart';
import 'package:weather_app/features/data_bank_page/data_bank_page.dart';
import 'package:weather_app/features/home/views/home.dart';
import 'package:weather_app/features/more_page/more_page.dart';


class BottomNavigationScreen extends StatelessWidget {
  const BottomNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationCubit(authCubit: context.read<AuthCubit>()),
      child: BlocConsumer<NavigationCubit, NavigationState>(
        listener: (context, state) {
          // Bắt sự kiện lỗi 403 để hiện thông báo cảnh báo
          if (state is NavigationUnauthorizedError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state.currentIndex,
              children: const [
                HomePage(), 
                DataBankPage(), 
                MorePage(),
              ],
            ),
            bottomNavigationBar: BottomNavigation(
              index: state.currentIndex,
              onTap: (index) {
                context.read<NavigationCubit>().changeTab(index);
              },
            ),
          );
        },
      ),
    );
  }
}