import 'package:flutter/material.dart';
import 'package:weather_app/routes/app_routes.dart';
import 'onboarding_form.dart';
import 'onboarding_data.dart';
import '../auth/views/login_page.dart';
import '../../../core/storage/app_setting_storage.dart';

class OnboardingBuilding extends StatefulWidget {
  const OnboardingBuilding({super.key});

  @override
  State<OnboardingBuilding> createState() => _OnboardingBuildingState();
}

class _OnboardingBuildingState extends State<OnboardingBuilding> {
  final PageController controller = PageController();
  int _currentIndex = 0;

  void _finishOnboarding() async {
    await AppSettingStorage.setHasSeenOnboarding();

    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.bottomNavigationScreen,
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(children: [
            // Cụm Nút Skip phía trên bên phải
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _finishOnboarding,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(color: Colors.green, width: 2)
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontFamily: "SF Pro Display",
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingForm(
                    title: onboardingData[index]['title']!,
                    description: onboardingData[index]['description']!,
                    index: index,
                  );
                },
              )
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Nút Bấm Previous (Quay lại)
                  TextButton(
                    onPressed: _currentIndex == 0 ? null : () {
                      controller.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: _currentIndex == 0 ? Colors.white : Colors.green, width: 2)
                      ),
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
                    ),
                    child: Text(
                      "Previous", 
                      style: TextStyle(
                        fontSize: 16, 
                        fontWeight: FontWeight.bold, 
                        color: _currentIndex == 0 ? Colors.white : Colors.green
                      )
                    ),
                  ),
                  
                  const SizedBox(width: 20,),
                  
                  TextButton(
                    onPressed: () {
                      if (_currentIndex == onboardingData.length - 1) {
                        _finishOnboarding();
                      } else {
                        controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(color: Colors.green, width: 2)
                      ),
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
                    ),
                    child: Text(
                      _currentIndex == onboardingData.length - 1 ? "Get Started" : "Next", 
                      style: const TextStyle(
                        fontSize: 16, 
                        fontWeight: FontWeight.bold, 
                        color: Colors.green
                      )
                    ),
                  )
                ],
              ),
            )
          ],)
        )
      );
  }
}