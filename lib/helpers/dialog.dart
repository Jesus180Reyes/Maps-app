import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Cargando...'),
      content: Container(
        width: 100,
        height: 100,
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          children: const [
            Text('Calculando Ruta'),
            SizedBox(height: 15),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}
