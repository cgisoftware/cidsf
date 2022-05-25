import 'package:cids_cgi/cids_cgi.dart';
import 'package:cids_cgi/src/core/domain/usecase/launch_social_usecase.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class RedesSociaisWidget extends StatefulWidget {
  @override
  State<RedesSociaisWidget> createState() => _RedesSociaisWidgetState();
}

class _RedesSociaisWidgetState extends State<RedesSociaisWidget> {
  final launchSocialUseCase = LaunchSocialUseCaseImpl();

  bool rh = false;
  final _handler = SharedPreferencesHandler();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero).then((_) async {
      this.rh = (await _handler.get("rh")) == "true";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Siga-nos nas redes sociais!"),
        Padding(padding: EdgeInsets.all(5)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                launchSocialUseCase('fb://profile/338379049642068',
                    'https://www.facebook.com/CGISoftware');
              },
              child: Icon(
                FontAwesomeIcons.facebook,
                color: rh ? Colors.orange : Color(0xff3A5997),
                size: 30,
              ),
            ),
            InkWell(
                onTap: () {
                  launchSocialUseCase('https://www.instagram.com/cgisoftware/',
                      'https://www.instagram.com/cgisoftware/');
                },
                child: Icon(
                  FontAwesomeIcons.instagram,
                  color: rh ? Colors.orange : Color(0xff3E729A),
                  size: 30,
                )),
            InkWell(
                onTap: () {
                  launchSocialUseCase('linkedin://company/cgisoftware/about/',
                      'https://www.linkedin.com/company/cgisoftware/about/');
                },
                child: Icon(
                  FontAwesomeIcons.linkedin,
                  color: rh ? Colors.orange : Color(0xff027BB6),
                  size: 30,
                )),
            InkWell(
                onTap: () {
                  launchSocialUseCase('twitter://user?screen_name=CgiSoftware',
                      'https://twitter.com/CgiSoftware');
                },
                child: Center(
                  child: Icon(
                    FontAwesomeIcons.twitter,
                    color: rh ? Colors.orange : Color(0xff2995E8),
                    size: 30,
                  ),
                ))
          ],
        )
      ],
    );
  }
}
