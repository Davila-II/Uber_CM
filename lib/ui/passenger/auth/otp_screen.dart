import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  // Styles locaux pour isolation
  final Color pBlue = const Color(0xFF1A237E);
  final Color pRed = const Color(0xFFE53935);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0, iconTheme: IconThemeData(color: pBlue)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Vérification", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: pBlue)),
            const SizedBox(height: 10),
            const Text("Entrez le code reçu par SMS."),
            const SizedBox(height: 40),
            
            // Simuler cases OTP
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) => Container(
                width: 50, height: 50, 
                decoration: BoxDecoration(border: Border.all(color: pBlue), borderRadius: BorderRadius.circular(8)),
                child: const TextField(textAlign: TextAlign.center, keyboardType: TextInputType.number),
              )),
            ),

            const Spacer(),
            
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: pRed),
                onPressed: () {
                  // Direction Accueil Passager (à venir)
                },
                child: const Text("Confirmer", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}