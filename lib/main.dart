import 'package:flutter/material.dart';
import 'core/app_colors.dart';
import 'ui/landing/role_selection_screen.dart';

void main() {
  runApp(const UberCM());
}

class UberCM extends StatelessWidget {
  const UberCM({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // On garde une seule fois chaque paramètre pour éviter l'erreur "Duplicated named argument"
      debugShowCheckedModeBanner: false,
      title: 'Uber-CM',
      
      // Configuration de la langue simple sans le paquet localizations pour l'instant
      // Cela suffit pour que l'app sache qu'on est en français
      locale: const Locale('fr', 'FR'), 

      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.white,
        primaryColor: AppColors.primaryRed,
        fontFamily: 'Roboto', // Optionnel : assure une police propre
      ),
      
      // Point d'entrée
      home: const RoleSelectionScreen(),
    );
  }
}