import 'package:flutter/material.dart';
import '../passenger/auth/onboarding_screen.dart'; 
import 'package:uber_cm/ui/driver/auth/welcome_screen.dart';

// Variable globale pour la langue
String appLanguage = 'Français';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    final bool isFr = appLanguage == 'Français';

    return Scaffold(
      body: Stack(
        children: [
          // Image de fond
          Positioned.fill(
            child: Image.asset(
              'assets/images/transport_urbain.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(color: Colors.black),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.5)),

          // Bouton Langue
          Positioned(
            top: 50,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: PopupMenuButton<String>(
                icon: const Icon(Icons.language, color: Colors.white, size: 28),
                onSelected: (String result) {
                  setState(() {
                    appLanguage = result;
                  });
                },
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem(value: 'Français', child: Text('🇫🇷 Français')),
                  const PopupMenuItem(value: 'English', child: Text('🇺🇸 English')),
                ],
              ),
            ),
          ),

          // Contenu Central
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Uber-CM", style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 10),
                Text(isFr ? "Choisissez votre mode" : "Choose your mode", style: const TextStyle(fontSize: 18, color: Colors.white70)),
                const SizedBox(height: 60),

                // Passager -> Onboarding
                _buildRoleButton(context, isFr ? "Passager" : "Passenger", const Color(0xFFE53935), () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingScreen()));
                }),

                const SizedBox(height: 20),

                // Conducteur -> Welcome
                _buildRoleButton(context, isFr ? "Conducteur" : "Driver", const Color(0xFF1A237E), () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleButton(BuildContext context, String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(280, 60),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: onPressed,
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }
}