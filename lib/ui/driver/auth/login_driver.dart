import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uber_cm/ui/driver/auth/otp_driver.dart' as otp_driver;

class LoginDriver extends StatefulWidget {
  const LoginDriver({super.key});

  @override
  State<LoginDriver> createState() => _LoginDriverState();
}

class _LoginDriverState extends State<LoginDriver> {
  final List<TextEditingController> _controllers = List.generate(9, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(9, (index) => FocusNode());
  bool _isError = false;

  @override
  Widget build(BuildContext context) {
    const Color driverBlue = Color(0xFF1A237E);
    const Color driverRed = Color(0xFFE53935);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white, 
        elevation: 0, 
        iconTheme: const IconThemeData(color: driverBlue),
      ),
      // LE BOUTON SUIVANT EN BAS À DROITE
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: driverRed,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const otp_driver.OtpDriver()),
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
              "Espace Conducteur", 
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: driverBlue)
            ),
            const SizedBox(height: 10),
            const Text("Entrez votre numéro pour vous connecter à votre compte partenaire."),
            const SizedBox(height: 40),
            
            // Ligne avec drapeau et cases
            Row(
              children: [
                // LE DRAPEAU ET LE CODE
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Text("🇨🇲", style: TextStyle(fontSize: 22)), // Drapeau Cameroun
                      SizedBox(width: 5),
                      Text("+237", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(9, (index) => _buildDigitBox(index, driverBlue)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

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