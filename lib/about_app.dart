import 'package:flutter/material.dart';
import 'package:geldwegwijzer/sizeconfig.dart';
import 'package:package_info/package_info.dart';

Future<void> openAboutApp(BuildContext context) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  showAboutDialog(
    context: context,
    applicationName: packageInfo.appName,
    applicationVersion: packageInfo.version + ' (Build: ' + packageInfo.buildNumber + ')',
    applicationLegalese: 'Copyright © 2017-' + DateTime.now().year.toString() + ' iMagineLab - All rights reserved.',
    applicationIcon: Image.asset('assets/icon.png', width: SizeConfig.blockSizeVertical * 11.0)
  );
}