import 'package:flutter/material.dart';
import '../../shared/primary_button.dart';
import '../../landing/role_selection_screen.dart'; 
import 'login_driver.dart';
import 'registration_driver.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isFr = appLanguage == 'Français';
    final Color driverBlue = const Color(0xFF1A237E);

    return Scaffold(
      body: Stack(
        children: [
          // 1. L'image de fond
          Positioned.fill(
            child: Image.asset(
              'assets/images/transport_urbain.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // 2. Le dégradé sombre pour la lisibilité
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.5, 1.0],
                  colors: [
                    Colors.black.withOpacity(0.2),
                    Colors.transparent,
                    Colors.black.withOpacity(0.9),
                  ],
                ),
              ),
            ),
          ),

          // 3. Le contenu (Texte + Boutons)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo ou petit indicateur (Optionnel)
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: Icon(Icons.directions_car, color: driverBlue, size: 30),
                  ),
                  const SizedBox(height: 20),

                  // Titre style Onboarding
                  Text(
                    isFr ? "Gagnez de l'argent\nen conduisant" : "Earn money\nby driving",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Sous-titre
                  Text(
                    isFr 
                      ? "Soyez votre propre patron et définissez vos horaires avec Uber-CM."
                      : "Be your own boss and set your own hours with Uber-CM.",
                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16),
                  ),
                  
                  const SizedBox(height: 40),

                  // BOUTON DÉMARRER (STYLE PASSAGER)
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationDriver()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            isFr ? "Démarrer" : "Get Started",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 15),
                          const Icon(Icons.arrow_forward, color: Colors.white, size: 28),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 25),

                  // Bouton Connexion (Primary style pour le contraste)
                  PrimaryButton(
                    text: isFr ? "Se connecter" : "Login",
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginDriver()));
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}