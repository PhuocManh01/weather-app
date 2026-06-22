import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/routes/app_routes.dart';

import '../bloc/weather_bloc.dart';
import '../bloc/weather_state.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../../auth/cubit/auth_state.dart';

import 'widget/weather_main_card.dart';
import 'widget/saved_location_card.dart';
import 'widget/suggested_location_card.dart';
import '../../more_page/widget/menu_button.dart';

import '../../../core/storage/auth_local_storage.dart';

class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              SizedBox(height: 20),

              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
                  String titleText = "Welcome";
                  Widget trailingWidget = TextButton(
                    onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
                    child: const Text("Login"));
                  
                  if (authState is AuthSuccess) {
                    titleText = "Welcome back,";
                    final username = context.read<AuthCubit>().getSavedCredentials()?['username'] ?? "User";
                    trailingWidget = Text(
                      username,
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: "SF Pro Display",
                      ),
                      overflow: TextOverflow.ellipsis,
                    );
                  }

                  return Row(
                    children: [
                      Text(
                        titleText,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: "ABeeZee",
                        ),
                      ),
                      const Spacer(),
                      trailingWidget,
                      const SizedBox(width: 10),
                    ],
                  );
                },
              ),

              SizedBox(height: 20),

              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return const SizedBox(
                      height: 200,
                      child: Center(child: CircularProgressIndicator(color: Colors.green)),
                    );
                  }
                  if (state is WeatherFailure) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      color: Colors.white,
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      )
                    );
                  }
                  if (state is WeatherSuccess) {
                    return WeatherMainCard(forecasts: state.forecasts, locationName: "Da Nang");
                  }
                  return const WeatherMainCard(forecasts: [], locationName: "",);
                },
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      SavedLocationCard(place: "Work",address:  "Coventry ST, Birmingham"),
                      SizedBox(width: 20),
                      SavedLocationCard(place: "Home",address:  "Coventry ST, Birmingham"),
                      SizedBox(width: 20),
                      SavedLocationCard(place: "Place",address:  "Address"),
                    ],
                  ),
                ),
              ),
        
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      SuggestedLocationCard(suggestedLocation: "Work",suggestedAddress:  "Coventry ST, Birmingham"),
                      SizedBox(width: 20),
                      SuggestedLocationCard(suggestedLocation: "Home",suggestedAddress:  "Coventry ST, Birmingham"),
                      SizedBox(width: 20),
                      SuggestedLocationCard(suggestedLocation: "Place",suggestedAddress:  "Address"),
                    ],
                  ),
                ),
              ),
        
              SizedBox(height: 10,),
              
              MenuButton(
                iconButton: Icons.info,
                nameButton: "Detail Air Quality",
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.locationDetail);
                },
              ),

              MenuButton(
                iconButton: Icons.health_and_safety_outlined,
                nameButton: "AQI Scale",
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.aqiScale);
                },
              ),
            ],
          ),
        ),
      )
    );
  }
}