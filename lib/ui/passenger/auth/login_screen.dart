import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'otp_screen.dart'; // Import pour le passager

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // On utilise les mêmes contrôleurs et focus pour les 9 chiffres
  final List<TextEditingController> _controllers = List.generate(9, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(9, (index) => FocusNode());
  bool _isError = false;

  @override
  Widget build(BuildContext context) {
    // Couleurs Passager (On garde la cohérence avec ton style)
    const Color passengerBlue = Color(0xFF1A237E);
    const Color passengerRed = Color(0xFFE53935);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: passengerBlue),
      ),
      // BOUTON SUIVANT EN BAS À DROITE (Identique au conducteur)
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: passengerRed,
        onPressed: () {
          // Logique pour passer à l'OTP passager
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OtpScreen()),
          );
        },
        label: const Row(
          children: [
            Text("Suivant", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            SizedBox(width: 5),
            Icon(Icons.arrow_forward, color: Colors.white),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Bienvenue", 
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: passengerBlue)
            ),
            const SizedBox(height: 10),
            const Text("Entrez votre numéro de téléphone pour commander une course."),
            const SizedBox(height: 40),
            
            // Ligne avec drapeau et cases (Copie conforme du conducteur)
            Row(
              children: [
                // LE DRAPEAU ET LE CODE +237
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Text("🇨🇲", style: TextStyle(fontSize: 22)),
                      SizedBox(width: 5),
                      Text("+237", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(9, (index) => _buildDigitBox(index, passengerBlue)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Le widget des cases (Copie conforme pour l'harmonie visuelle)
  Widget _buildDigitBox(int index, Color color) {
    return Container(
      width: 25,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 2, color: _isError ? Colors.red : color)
        )
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1), 
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (v) {
          if (v.length == 1 && index < 8) {
            _focusNodes[index + 1].requestFocus();
          } else if (v.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 8),
        ),
      ),
    );
  }
}