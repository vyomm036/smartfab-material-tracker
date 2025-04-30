import 'package:flutter/material.dart';

class QRScannerScreen extends StatelessWidget {
  const QRScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Material'),
      ),
      body: const Center(
        child: Text('QR Scanner will be implemented here'),
      ),
    );
  }
} 