import 'package:flutter/material.dart';
import 'package:uber_cm/core/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  // Ajout du '?' pour autoriser le bouton à être désactivé (null)
  final VoidCallback? onPressed; 

  const PrimaryButton({
    super.key, 
    required this.text, 
    this.onPressed // Retrait du 'required' ici pour la flexibilité
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          // Si onPressed est null, le bouton prendra automatiquement la couleur "disabled"
          backgroundColor: AppColors.primaryRed,
          disabledBackgroundColor: AppColors.primaryRed.withOpacity(0.5), // Version plus claire si désactivé
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white, 
            fontSize: 16, 
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}