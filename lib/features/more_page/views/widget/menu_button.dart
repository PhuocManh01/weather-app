import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final IconData iconButton;
  final String nameButton;
  final VoidCallback onTap;

  const MenuButton({
    super.key,
    required this.iconButton,
    required this.nameButton,
    required this.onTap,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20)
          ),
          onPressed: onTap,
          child: Row(
            children: [
              Icon(iconButton,
                size: 20,
                color: nameButton == "Logout" ? Colors.red : const Color.fromARGB(255, 20, 68, 22),),
              SizedBox(width: 20,),
              Text(nameButton,
                style: TextStyle(
                  fontFamily: "SF Pro Display",
                  fontSize: 20,
                  color: nameButton == "Logout" ? Colors.red : const Color.fromARGB(255, 20, 68, 22),
                )
              ),
      
              const Spacer(),
      
              Icon(Icons.chevron_right, color: nameButton == "Logout" ? Colors.red : const Color.fromARGB(255, 20, 68, 22),),
            ],
          ),
        )
      ),
    );
  }
}