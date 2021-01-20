import 'dart:io';

import 'package:cids_cgi/cids_cgi.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
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
  final _sharedHandler = SharedPreferencesHandler();

  Future<bool> call() async {
    try {
      bool biometriaHabilitada =
          (await _sharedHandler.get('biometria')) == "true";
      bool isAuth = false;

      if (biometriaHabilitada) {
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
        }
      }
      listen(autenticado: isAuth);
      return isAuth;
    } on PlatformException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  listen({bool autenticado = false}) {
    WidgetsBinding.instance.addObserver(BiometricsCallback(
      resumeCallBack: () async {
        if (Platform.isAndroid) {
          call();
        }
        if (Platform.isIOS) {
          if (!autenticado) {
            call();
          }
        }
        return null;
      },
      pausedCallback: () async {
        if (Platform.isIOS) {
          call();
        }
      },
    ));
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
