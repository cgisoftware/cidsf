import 'package:url_launcher/url_launcher.dart';

abstract class LaunchSocialUseCase {
  call(String url, String fallbackUrl);
}

class LaunchSocialUseCaseImpl implements LaunchSocialUseCase {
  @override
  call(String url, String fallbackUrl) async {
    try {
      bool launched = await launchUrl(Uri.parse(url));
      if (!launched) {
        await launchUrl(Uri.parse(fallbackUrl));
      }
    } catch (e) {
      await launchUrl(Uri.parse(fallbackUrl));
    }
  }
}
