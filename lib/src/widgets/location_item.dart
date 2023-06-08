import 'package:flutter/material.dart';

class LocationItem extends StatelessWidget {
  const LocationItem({
    required this.iconData,
    required this.title,
    required this.onTap,
    super.key,
    this.titleStyle,
  });

  final IconData iconData;
  final String title;
  final TextStyle? titleStyle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            Icon(iconData),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: titleStyle ??
                    const TextStyle(
                      color: Colors.pinkAccent,
                      fontSize: 18,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
