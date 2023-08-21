import 'dart:developer';
import 'dart:io';

import 'package:dine/Shared/Widgets/AppBar.dart';
import 'package:dine/Views/MenuPage/menuPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_scanner/flutter_code_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_code_scanner/src/flutter_code_scanner.dart';
import 'package:flutter_code_scanner/src/flutter_code_scanner_overlay_shape.dart';
import 'package:flutter_code_scanner/src/types/barcode.dart' as bc;

class QrScanner extends ConsumerStatefulWidget {
  const QrScanner({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QrScannerState();
}

class _QrScannerState extends ConsumerState<QrScanner> {
  bc.Barcode? result;
  QrController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QrController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData;

      if (result?.code?.isNotEmpty ?? false) {
        controller.dispose();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MenuPage()),
            (route) => false);
      }
    });
  }

  void _onPermissionSet(BuildContext context, QrController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 180.0
        : 240.0;
    return Scaffold(
      appBar: customAppbar,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.white,
              borderLength: 30,
              borderWidth: 5,
              cutOutSize: scanArea,
            ),
            onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
          ),
          //Debug
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => MenuPage()),
                    (route) => false);
              },
            ),
          ),
          //Debug
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
