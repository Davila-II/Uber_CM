import 'package:flutter/material.dart';
import '../../shared/primary_button.dart';
import 'login_screen.dart'; 
import 'register_screen.dart'; 

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fond d'écran
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1563290310-449e7939634e?q=80&w=2070&auto=format&fit=crop',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Filtre sombre
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.9),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Restez en sécurité\ntout au long de\nvotre trajet.",
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 32, 
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Déplacez-vous sereinement avec Uber-CM partout au Cameroun.",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 40),
                  
                  // Bouton Créer un compte
                  PrimaryButton(
                    text: "Créer un compte",
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => RegisterScreen()) // SANS CONST
                      );
                    },
                  ),
                  
                  const SizedBox(height: 25),

                  // Lien Connexion
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => LoginScreen()) // SANS CONST
                      );
                    },
                    child: const Row( // Ajout du const ici car le contenu interne est fixe
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Tu as déjà un compte ? ",
                          style: TextStyle(color: Colors.white70, fontSize: 15),
                        ),
                        Text(
                          "Connexion",
                          style: TextStyle(
                            color: Colors.white, 
                            fontSize: 15, 
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}