import 'package:url_launcher/url_launcher.dart';

abstract class LaunchSocialUseCase {
  call(String url, String fallbackUrl);
}

class LaunchSocialUseCaseImpl implements LaunchSocialUseCase {
  @override
  call(String url, String fallbackUrl) async {
    // Don't use canLaunch because of fbProtocolUrl (fb://)
    try {
      bool launched =
          await launch(url, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }
}
