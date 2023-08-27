import 'dart:developer';
import 'dart:io';

import 'package:dine/Shared/Widgets/AppBar.dart';
import 'package:dine/Storage/sharedPreference.dart';
import 'package:dine/ViewModels/QrScannerViewModel/qrscannerviewmodel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_code_scanner/flutter_code_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_code_scanner/src/flutter_code_scanner.dart';
import 'package:flutter_code_scanner/src/flutter_code_scanner_overlay_shape.dart';
import 'package:flutter_code_scanner/src/types/barcode.dart' as bc;
import 'package:go_router/go_router.dart';

import '../../Constants/staticConstants.dart';

class QrScanner extends ConsumerStatefulWidget {
  const QrScanner({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QrScannerState();
}

class _QrScannerState extends ConsumerState<QrScanner> {
  QrScannerViewModel viewModel = QrScannerViewModel();
  bc.Barcode? result;
  QrController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void _onQRViewCreated(QrController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      result = scanData;

      if (result?.code?.isNotEmpty ?? false) {
        
        setLocal(key: "id", value: "K7VvDwz4F7B5ka8VGoRn");
        Constants.id = 'K7VvDwz4F7B5ka8VGoRn';
        bool status = await viewModel.getRestaurant(
            id: 'K7VvDwz4F7B5ka8VGoRn', context: context);
        if (status) {
          controller.dispose();
          context.go(
            '/menu/K7VvDwz4F7B5ka8VGoRn',
          );
        }
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
      appBar: createAppBar(context),
      body: QRView(
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
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
