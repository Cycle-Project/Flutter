import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

showQrCodeScanner(context) async {
  String value = "";
  await FlutterBarcodeScanner.scanBarcode(
          "#000000", "Cancel", true, ScanMode.QR)
      .then(
    (val) {
      value = val;
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(value),
          );
        },
      );
    },
  );
}
