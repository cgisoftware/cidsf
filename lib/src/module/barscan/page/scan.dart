import 'package:cids_cgi/cids_cgi.dart';
import 'package:flutter/material.dart';
import 'package:scan/scan.dart';

class BarScanPage extends StatefulWidget {
  final QRScanType? type;

  const BarScanPage({Key? key, this.type}) : super(key: key);
  @override
  _BarScanPageState createState() => _BarScanPageState();
}

class _BarScanPageState extends State<BarScanPage> {
  ScanController controller = ScanController();
  // String qrcode = 'Unknown';
  @override
  void initState() {
    // if (widget.type == QRScanType.bar) {
    //   SystemChrome.setPreferredOrientations([
    //     DeviceOrientation.landscapeRight,
    //     DeviceOrientation.landscapeLeft,
    //   ]);
    // } else {
    //   SystemChrome.setPreferredOrientations([
    //     DeviceOrientation.portraitUp,
    //   ]);
    // }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Center(
                  child: Container(
               
                child: ScanView(
                  controller: controller,
                  scanAreaScale:.9,
                  scanLineColor: Colors.blue,
                  onCapture: (data) {
                    Navigator.pop(context, data);
                  },
                ),
              ))),
        ],
      ),
    );
  }
}
