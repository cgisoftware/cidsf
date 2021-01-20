import 'dart:io';

import 'package:cids_cgi/cids_cgi.dart';
import 'package:cids_cgi/src/core/page/widget/router_widget.dart';
import 'package:cids_cgi/src/module/auth/page/biometrics_error_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

const _iosStrings = const IOSAuthMessages(
    cancelButton: 'Cancelar',
    goToSettingsButton: 'Configurações',
    goToSettingsDescription: 'Por favor configure sua autenticação.',
    lockOut: 'Por favor permita o uso da sua autenticação');

class BiometricsHandler {
  final _localAuth = LocalAuthentication();
  WidgetsBindingObserver _observer;

  Future<bool> call(BuildContext context) async {
    WidgetsBinding.instance.removeObserver(_observer);
    bool biometriaHabilitada =
        (await SharedPreferencesHandler().get('biometria')) == "true";

    print(biometriaHabilitada);
    bool isAuth = false;

    if (biometriaHabilitada) {
      if ((await SharedPreferencesHandler().get('autenticou')) == "false") {
        // try {

        // _localAuth.
        bool biometricCheck = await _localAuth.canCheckBiometrics;
        if (biometricCheck) {
          List<BiometricType> availableBiometrics =
              await _localAuth.getAvailableBiometrics();

          if (Platform.isIOS) {
            if (availableBiometrics.contains(BiometricType.face)) {
              isAuth = await _localAuth.authenticateWithBiometrics(
                  localizedReason: "Desbloqueio com Face ID",
                  stickyAuth: true,
                  sensitiveTransaction: false,
                  iOSAuthStrings: _iosStrings);
            } else if (availableBiometrics
                .contains(BiometricType.fingerprint)) {
              isAuth = await _localAuth.authenticateWithBiometrics(
                  localizedReason: "Desbloqueio com Touch ID",
                  stickyAuth: true,
                  sensitiveTransaction: false,
                  iOSAuthStrings: _iosStrings);
            }
          } else {
            isAuth = await _localAuth.authenticateWithBiometrics(
                localizedReason: 'Para usar o app, autentique',
                stickyAuth: true,
                sensitiveTransaction: false);
          }

          if (!isAuth) {
            Navigator.of(context).pushAndRemoveUntil(
                SlideRightRoute(widget: BiometricsErrorPage()),
                (Route<dynamic> route) => false);
          } else {
            await SharedPreferencesHandler().set('autenticou', "true");
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/home', (Route<dynamic> route) => false);
          }
        }
      }

      print(isAuth);

      return isAuth;
    }

    return false;

    // } on PlatformException catch (e) {
    //   // throw e;
    // } catch (e) {
    //   //throw e;
    // }
  }

  listen(BuildContext context) async {
    WidgetsBinding.instance.removeObserver(_observer);
    bool biometriaHabilitada =
        (await SharedPreferencesHandler().get('biometria')) == "true";
    if (biometriaHabilitada) {
      WidgetsBinding.instance.removeObserver(_observer);
      _observer = BiometricsCallback(resumeCallBack: () async {
        if (Platform.isAndroid) {
          call(context);
        }

        if (Platform.isIOS) {
          bool paused =
              (await SharedPreferencesHandler().get('paused')) == "true";
          if (paused) {
            call(context);
            await SharedPreferencesHandler().set('paused', "false");
          }
        }
      }, pausedCallback: () async {
        await SharedPreferencesHandler().set('paused', "true");
        await SharedPreferencesHandler().set('autenticou', "false");
      }, inactiveCallBack: () async {
        await SharedPreferencesHandler().set('paused', "true");
        await SharedPreferencesHandler().set('autenticou', "false");
      });

      WidgetsBinding.instance.addObserver(_observer);
    }
  }
}

class BiometricsCallback extends WidgetsBindingObserver {
  final AsyncCallback resumeCallBack;
  final AsyncCallback suspendingCallBack;
  final AsyncCallback pausedCallback;
  final AsyncCallback inactiveCallBack;

  BiometricsCallback(
      {this.resumeCallBack,
      this.suspendingCallBack,
      this.pausedCallback,
      this.inactiveCallBack});

  @override
  Future<Null> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        print('resume');
        if (resumeCallBack != null) {
          await resumeCallBack();
        }
        break;
      case AppLifecycleState.inactive:
        if (inactiveCallBack != null) {
          await inactiveCallBack();
        }
        print('inative');
        break;
      case AppLifecycleState.paused:
        print('paused');
        if (pausedCallback != null) {
          await pausedCallback();
        }
        break;
      case AppLifecycleState.detached:
        print('detached');
        if (suspendingCallBack != null) {
          await suspendingCallBack();
        }
        break;
    }
  }
}

// if (e.code == auth_errors.notAvailable) {
//   print('not available');
// }
// if (e.code == auth_errors.passcodeNotSet) {
//   print('passcodeNotSet');
// }
// if (e.code == auth_errors.notEnrolled) {
//   print('notEnrolled');
// }
// if (e.code == auth_errors.lockedOut) {
//   print('lockedOut');
// }
// if (e.code == auth_errors.permanentlyLockedOut) {
//   print('permanentlyLockedOut');
// }
// if (e.code == auth_errors.otherOperatingSystem) {
//   print('otherOperatingSystem');
// }
// if (authenticated) {
//   autenticado = authenticated;
// }
