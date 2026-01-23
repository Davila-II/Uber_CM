import 'package:flutter/material.dart';
import 'package:uber_cm/ui/driver/auth/documents_driver.dart';

class RegistrationDriver extends StatefulWidget {
  const RegistrationDriver({super.key});

  @override
  State<RegistrationDriver> createState() => _RegistrationDriverState();
}

class _RegistrationDriverState extends State<RegistrationDriver> {
  final Color driverBlue = const Color(0xFF1A237E);
  final Color driverRed = const Color(0xFFE53935);
  final _formKey = GlobalKey<FormState>();

  String? selectedCity;
  final List<String> cities = ["Douala", "Yaoundé", "Garoua", "Bafoussam", "Bamenda"];

  // Fonction pour ouvrir la sélection de ville plus "pro"
  void _showCityPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Sélectionnez votre ville", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Divider(),
              ...cities.map((city) => ListTile(
                title: Text(city, textAlign: TextAlign.center),
                onTap: () {
                  setState(() => selectedCity = city);
                  Navigator.pop(context);
                },
              )).toList(),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: driverBlue,
        elevation: 4,
        onPressed: () {
          if (_formKey.currentState!.validate() && selectedCity != null) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const DocumentsDriver()));
          } else if (selectedCity == null) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Veuillez choisir une ville")));
          }
        },
        child: const Icon(Icons.arrow_forward, color: Colors.white, size: 30),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: 70, height: 5, decoration: BoxDecoration(color: driverRed, borderRadius: BorderRadius.circular(10))),
              const SizedBox(height: 25),
              const Text("Profil Partenaire", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),

              // GROUPE DE CASES (DESIGN FIGMA UBER)
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  children: [
                    _buildStackedInput("Nom complet", "Ex: Jean Douala", isFirst: true),
                    const Divider(height: 1, indent: 20, endIndent: 20),
                    _buildStackedInput("Modèle du véhicule", "Ex: Toyota Corolla"),
                    const Divider(height: 1, indent: 20, endIndent: 20),
                    _buildStackedInput("Numéro de plaque", "Ex: LT 123 AA"),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),

              // CASE VILLE (ACTIONNABLE)
              const Text("Ville d'activité", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _showCityPicker,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_city, color: Colors.black54),
                      const SizedBox(width: 15),
                      Text(
                        selectedCity ?? "Choisir une ville",
                        style: TextStyle(color: selectedCity == null ? Colors.grey[500] : Colors.black, fontSize: 16),
                      ),
                      const Spacer(),
                      const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // CASE REFERRAL (SÉPARÉE)
              const Text("Parrainage", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: _buildStackedInput("Code de parrainage", "Ex: UBER237", isFirst: true, isRequired: false),
              ),

              const SizedBox(height: 30),
              const Text(
                "En continuant, vous acceptez que Uber-CM traite vos données pour la création de votre compte partenaire.",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  // Widget pour créer les cases empilées sans bordures doubles
  Widget _buildStackedInput(String label, String hint, {bool isFirst = false, bool isRequired = true}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        border: InputBorder.none, // Supprime les bordures internes
      ),
      validator: (value) {
        if (isRequired && (value == null || value.isEmpty)) return "Requis";
        return null;
      },
    );
  }
}