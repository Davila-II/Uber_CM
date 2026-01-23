import 'package:flutter/material.dart';
import '../../landing/role_selection_screen.dart';
import 'package:uber_cm/core/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _currentStep = 0;
  final TextEditingController _controller = TextEditingController();
  String? _errorMessage;
  bool _isError = false;

  final List<String> _titles = ["Quel est votre nom ?", "Votre adresse email", "Créez un mot de passe"];
  final List<String> _hints = ["Nom complet", "exemple@gmail.com", "••••••••"];
  final List<IconData> _icons = [Icons.person_outline, Icons.email_outlined, Icons.lock_outline];

  bool _isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  void _triggerError(String message) {
    setState(() {
      _isError = true;
      _errorMessage = message;
    });
    
    // Après 2 secondes, on réinitialise l'erreur ET on vide le champ
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isError = false;
          _errorMessage = null;
          _controller.clear(); // Efface ce qui a été écrit pour recommencer propre
        });
      }
    });
  }

  void _nextStep() {
    String value = _controller.text.trim();

    if (value.isEmpty) {
      _triggerError("Ce champ ne peut pas être vide");
      return;
    }

    if (_currentStep == 1 && !_isValidEmail(value)) {
      _triggerError("Format d'email invalide");
      return;
    }

    if (_currentStep == 2 && value.length < 6) {
      _triggerError("Minimum 6 caractères");
      return;
    }

    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
        _controller.clear();
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RoleSelectionScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.darkBlue),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (_currentStep > 0) {
              setState(() {
                _currentStep--;
                _controller.clear();
              });
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Étape ${_currentStep + 1} sur 3",
              style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              _titles[_currentStep],
              style: const TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold, 
                color: AppColors.darkBlue // Reste bleu même en cas d'erreur
              ),
            ),
            const SizedBox(height: 40),

            Row(
              children: [
                Icon(_icons[_currentStep], color: AppColors.darkBlue), // Reste bleu
                const SizedBox(width: 15),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    autofocus: true,
                    obscureText: _currentStep == 2,
                    keyboardType: _currentStep == 1 ? TextInputType.emailAddress : TextInputType.text,
                    // L'écriture devient rouge seulement ici
                    style: TextStyle(fontSize: 18, color: _isError ? Colors.red : Colors.black),
                    decoration: InputDecoration(
                      hintText: _hints[_currentStep],
                      hintStyle: const TextStyle(color: Colors.black12),
                      errorText: _errorMessage, // Message rouge qui apparaît
                      errorStyle: const TextStyle(color: Colors.red),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.darkBlue, width: 1.5)
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: _isError ? Colors.red : AppColors.darkBlue, width: 2)
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(),

            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: _currentStep < 2 ? 140 : 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryRed, // Le bouton garde sa couleur
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: _isError ? null : _nextStep, 
                  child: _currentStep < 2
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Suivant", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                          ],
                        )
                      : const Text(
                          "Confirmer",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}