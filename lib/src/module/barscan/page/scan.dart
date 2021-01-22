import 'package:cids_cgi/cids_cgi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

class BarScanPage extends StatefulWidget {
  final QRScanType type;

  const BarScanPage({Key key, this.type}) : super(key: key);
  @override
  _BarScanPageState createState() => _BarScanPageState();
}

class _BarScanPageState extends State<BarScanPage> {
  bool _scan = false;
  @override
  void initState() {
    if (widget.type == QRScanType.bar) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }

    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    super.dispose();
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
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * .75,
                    height: MediaQuery.of(context).size.height * .4,
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: QrCamera(
                        qrCodeCallback: (code) {
                          if (!_scan) {
                            this._scan = true;
                            Navigator.pop(context, code);
                          }
                        },
                      ),
                    )),
              )),
        ],
      ),
    );
  }
}
