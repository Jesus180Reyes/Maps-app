import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

showLoadingMessage(BuildContext context) {
  // Android

  if (Platform.isAndroid) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
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
      ),
    );
    return;
  } else {
    showCupertinoDialog(
      context: context,
      builder: (context) => const CupertinoAlertDialog(
        title: Text('Cargando...'),
        content: CupertinoActivityIndicator(),
      ),
    );
    return;
  }
}
