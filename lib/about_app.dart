import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geldwegwijzer/sizeconfig.dart';
import 'package:package_info/package_info.dart';

Future<void> openAboutApp(BuildContext context) async {
  String appName;
  String appVersion;

  if (kIsWeb) {
    appName = 'Geldwegwijzer';
    appVersion = '2.0.0';
  }
  else {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    appName = packageInfo.appName;
    appVersion = packageInfo.version + ' (Build: ' + packageInfo.buildNumber + ')';
  }

  showAboutDialog(
    context: context,
    applicationName: appName,
    applicationVersion: appVersion,
    applicationLegalese: 'Copyright © 2017-' + DateTime.now().year.toString() + ' iMagineLab - All rights reserved.',
    applicationIcon: Image.asset('assets/icon.png', width: SizeConfig.blockSizeVertical * 11.0)
  );
}