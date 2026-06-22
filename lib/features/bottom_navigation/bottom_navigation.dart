import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int index;
  final void Function(int) onTap;

  const BottomNavigation({super.key, required this.index, required this.onTap});

  Widget buildNavigationItem({
    required IconData icon,
    required String label,
    required int itemIndex,
  }) {
    final bool isSelected = index == itemIndex;

    return TextButton(
      onPressed: () => onTap(itemIndex),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isSelected ? Colors.green : Colors.transparent,
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey,
              size: 20,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? const Color.fromARGB(255, 0, 139, 5)
                  : Colors.grey,
              fontSize: 15,
              fontFamily: "SF Pro Display",
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: buildNavigationItem(
              icon: Icons.home,
              label: "Home",
              itemIndex: 0,
            ),
          ),
          Expanded(
            child: buildNavigationItem(
              icon: Icons.storage,
              label: "Data Bank",
              itemIndex: 1,
            ),
          ),
          Expanded(
            child: buildNavigationItem(
              icon: Icons.more_horiz,
              label: "More",
              itemIndex: 2,
            ),
          ),
        ],
      ),
    );
  }
}
