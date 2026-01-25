import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DocumentsDriver extends StatefulWidget {
  const DocumentsDriver({super.key});

  @override
  State<DocumentsDriver> createState() => _DocumentsDriverState();
}

class _DocumentsDriverState extends State<DocumentsDriver> {
  final Color driverBlue = const Color(0xFF1A237E);
  final Color driverRed = const Color(0xFFE53935);
  final Color successGreen = const Color(0xFF2E7D32);
  
  final ImagePicker _picker = ImagePicker();

  bool _hasPermis = false;
  bool _hasCNI = false;
  bool _hasAssurance = false;

  Future<void> _pickImage(String type) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Source du document", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.blue),
              title: const Text("Prendre une photo"),
              onTap: () async {
                Navigator.pop(context);
                final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                if (photo != null) _updateStatus(type);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.purple),
              title: const Text("Choisir dans la galerie"),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                if (image != null) _updateStatus(type);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _updateStatus(String type) {
    setState(() {
      if (type == 'permis') _hasPermis = true;
      if (type == 'cni') _hasCNI = true;
      if (type == 'assurance') _hasAssurance = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool allUploaded = _hasPermis && _hasCNI && _hasAssurance;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Documents", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Documents officiels", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Veuillez fournir des photos lisibles pour activer votre compte."),
            const SizedBox(height: 35),

            // ICI : Correction des arguments positionnels
            _buildDocUploadCard(title: "Permis de conduire", isUploaded: _hasPermis, onTap: () => _pickImage('permis')),
            const SizedBox(height: 15),
            _buildDocUploadCard(title: "Carte d'Identité", isUploaded: _hasCNI, onTap: () => _pickImage('cni')),
            const SizedBox(height: 15),
            _buildDocUploadCard(title: "Assurance véhicule", isUploaded: _hasAssurance, onTap: () => _pickImage('assurance')),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: allUploaded ? driverBlue : Colors.grey[300],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: allUploaded ? _finishRegistration : null,
                child: Text("Soumettre le dossier", style: TextStyle(color: allUploaded ? Colors.white : Colors.grey[600])),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocUploadCard({required String title, required bool isUploaded, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isUploaded ? successGreen.withOpacity(0.05) : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isUploaded ? successGreen : Colors.grey[200]!, width: 1.5),
        ),
        child: Row(
          children: [
            Icon(isUploaded ? Icons.check_circle : Icons.add_a_photo_outlined, color: isUploaded ? successGreen : driverBlue),
            const SizedBox(width: 15),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            const Spacer(),
            if (!isUploaded) const Text("Ajouter", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  void _finishRegistration() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.verified_user_rounded, color: Colors.green, size: 70),
            const SizedBox(height: 20),
            const Text("Dossier envoyé !", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Examen en cours (24h).", textAlign: TextAlign.center),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
              child: const Text("Fermer"),
            ),
          ],
        ),
      ),
    );
  }
}