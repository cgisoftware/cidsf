import 'package:cids_cgi/src/module/barscan/page/scan.dart';
import 'package:flutter/material.dart';

enum QRScanType { bar, code }

class QRScan {
  Future<String?> startScan(BuildContext context, QRScanType type) async {
    String? response = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BarScanPage(type: type)),
    );

    return response;
  }
}
