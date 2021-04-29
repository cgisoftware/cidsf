import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cids_cgi/cids_cgi.dart';
import 'dart:io';

const _iosStrings = const IOSAuthMessages(
    cancelButton: 'Cancelar',
    goToSettingsButton: 'Configurações',
    goToSettingsDescription: 'Por favor configure sua autenticação.',
    lockOut: 'Por favor permita o uso da sua autenticação');

class BiometricsHandler {
  final Function autenticacaoPage;
  final Function homePage;
  final _localAuth = LocalAuthentication();
  final _sharedPreferencesHandler = SharedPreferencesHandler();
  WidgetsBindingObserver _observer;

  BiometricsHandler({this.autenticacaoPage, this.homePage});

  call() async {
    bool biometriaHabilitada =
        (await _sharedPreferencesHandler.get('biometria')) == "true";
    bool isAuth = false;

    if (biometriaHabilitada) {
      if ((await _sharedPreferencesHandler.get('autenticou')) == "false") {
        bool biometricCheck = await _localAuth.canCheckBiometrics;
        if (biometricCheck) {
          List<BiometricType> availableBiometrics =
              await _localAuth.getAvailableBiometrics();

          if (Platform.isIOS) {
            if (availableBiometrics.contains(BiometricType.face)) {
              isAuth = await _localAuth.authenticate(
                  biometricOnly: true,
                  localizedReason: "Desbloqueio com Face ID",
                  stickyAuth: true,
                  sensitiveTransaction: false,
                  iOSAuthStrings: _iosStrings);
            } else if (availableBiometrics
                .contains(BiometricType.fingerprint)) {
              isAuth = await _localAuth.authenticate(
                  biometricOnly: true,
                  localizedReason: "Desbloqueio com Touch ID",
                  stickyAuth: true,
                  sensitiveTransaction: false,
                  iOSAuthStrings: _iosStrings);
            }
          } else {
            isAuth = await _localAuth.authenticate(
                biometricOnly: true,
                localizedReason: 'Para usar o app, autentique',
                stickyAuth: true,
                sensitiveTransaction: false);
          }

          if (!isAuth) {
            this.autenticacaoPage();
            await SharedPreferencesHandler().set('autenticou', "false");
          } else {
            await SharedPreferencesHandler().set('autenticou', "true");
            this.homePage();
          }
        }
      }
    }
  }

  listen() async {
    _observer = BiometricsCallback(resumeCallBack: () async {
      if (Platform.isAndroid) {
        call();
      }

      if (Platform.isIOS) {
        bool paused = (await _sharedPreferencesHandler.get('paused')) == "true";
        if (paused) {
          call();
          await _sharedPreferencesHandler.set('paused', "false");
        }
      }
    }, pausedCallback: () async {
      await _sharedPreferencesHandler.set('paused', "true");
      await _sharedPreferencesHandler.set('autenticou', "false");
    }, inactiveCallBack: () async {
      await _sharedPreferencesHandler.set('autenticou', "false");
    });

    WidgetsBinding.instance.addObserver(_observer);
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
