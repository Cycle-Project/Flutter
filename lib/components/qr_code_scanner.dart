import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

Future<String> showQrCodeScanner() async =>
    await FlutterBarcodeScanner.scanBarcode(
      "#000000",
      "Cancel",
      true,
      ScanMode.QR,
    );
