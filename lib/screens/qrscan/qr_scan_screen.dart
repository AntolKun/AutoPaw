import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class QRScanScreen extends StatefulWidget {
  const QRScanScreen({super.key});

  @override
  _QRScanScreenState createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool hasPermission = false;

  @override
  void initState() {
    super.initState();
    _checkCameraPermission();
  }

  Future<void> _checkCameraPermission() async {
    final status = await Permission.camera.request();
    setState(() {
      hasPermission = status.isGranted;
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3BECEC),
      appBar: AppBar(
        title: const Text('Scan QR Code'),
      ),
      body: hasPermission
          ? Column(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: (result != null)
                        ? Text(
                            'Barcode Type: ${result!.format}   Data: ${result!.code}')
                        : const Text('Scan a code'),
                  ),
                )
              ],
            )
          : const Center(
              child: Text('Camera permission is required to scan QR codes.'),
            ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      // Perform action with the scanned data
      _handleScannedData(scanData.code);
    });
  }

  void _handleScannedData(String? scannedData) {
    if (scannedData != null) {
      // For example, navigate to another screen with the scanned data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScannedDataScreen(data: scannedData),
        ),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class ScannedDataScreen extends StatelessWidget {
  final String data;

  const ScannedDataScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3BECEC),
      appBar: AppBar(
        title: const Text('Scanned Data'),
      ),
      body: Center(
        child: Text('Perangkat Berhasil Ditambahkan! \nScanned Data: $data'),
      ),
    );
  }
}
