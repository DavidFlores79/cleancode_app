import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData icon;
  final bool isIconOnRight;

  const CustomIconButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.icon,
    this.isIconOnRight = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Acceder al tema actual
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface; // Color del texto sobre el fondo

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isIconOnRight) 
              Icon(icon, color: textColor,),
              SizedBox(width: 5),
            Text(text),
            if (isIconOnRight) 
              SizedBox(width: 5),
              Icon(icon, color: textColor,),
          ],
        ),
      ),
    );
  }
}