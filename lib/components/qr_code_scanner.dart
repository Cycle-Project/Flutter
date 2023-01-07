import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class QrCodeScanner extends HookWidget {
  const QrCodeScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = useState("");
    return ElevatedButton(
      onPressed: () => FlutterBarcodeScanner.scanBarcode(
              "#000000", "Cancel", true, ScanMode.QR)
          .then((value) {
        data.value = value;
        showDialog(context: context, builder: (_) {
          return AlertDialog(
            title: Text(data.value),
          );
        });
      }),
      child: const Text("Qr Scanner"),
    );
  }
}
