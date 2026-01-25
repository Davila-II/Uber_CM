import 'package:flutter/material.dart';
// Importation locale au dossier driver
import 'package:uber_cm/ui/driver/auth/registration_driver.dart';

class OtpDriver extends StatefulWidget {
  const OtpDriver({super.key});

  @override
  State<OtpDriver> createState() => _OtpDriverState();
}

class _OtpDriverState extends State<OtpDriver> {
  // Couleurs isolées pour le thème Conducteur
  final Color driverBlue = const Color(0xFF1A237E);
  final Color driverRed = const Color(0xFFE53935);

  final List<TextEditingController> _otpControllers = List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(4, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: driverBlue),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Vérification OTP",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: driverBlue),
            ),
            const SizedBox(height: 10),
            const Text(
              "Entrez le code à 4 chiffres envoyé sur votre numéro conducteur.",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 40),

            // Cases de saisie OTP
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) => _buildOtpBox(index)),
            ),

            const SizedBox(height: 30),

            Center(
              child: TextButton(
                onPressed: () {
                  // Logique de renvoi du code
                },
                child: Text(
                  "Renvoyer le code",
                  style: TextStyle(color: driverBlue, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: driverRed,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  // Une fois vérifié, on va vers l'inscription spécifique conducteur
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationDriver()),
                  );
                },
                child: const Text(
                  "Vérifier",
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextField(
        controller: _otpControllers[index],
        focusNode: _otpFocusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: driverBlue),
        decoration: InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: driverBlue, width: 2),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 3) {
            _otpFocusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            _otpFocusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }
}
