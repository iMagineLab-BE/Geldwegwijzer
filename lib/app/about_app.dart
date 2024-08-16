import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geldwegwijzer/model/sizeconfig.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<void> openAboutApp(final BuildContext context) async {
  final bool isHorizontal = SizeConfig.screenWidth > SizeConfig.screenHeight;
  String appName;
  String appVersion;
  final List<Widget> children = <Widget>[
    SizedBox(height: SizeConfig.blockSizeVertical * 4.0),
    Text('In samenwerking met',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: isHorizontal
                ? SizeConfig.blockSizeVertical * 4.0
                : SizeConfig.blockSizeVertical * 2.0)),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset('assets/teamscheire_logo.png',
            width: isHorizontal
                ? SizeConfig.blockSizeHorizontal * 16.0
                : SizeConfig.blockSizeHorizontal * 25.0),
        SizedBox(width: SizeConfig.blockSizeHorizontal * 4.0),
        Image.asset('assets/uantwerpen_logo.png',
            width: isHorizontal
                ? SizeConfig.blockSizeHorizontal * 20.0
                : SizeConfig.blockSizeHorizontal * 30.0),
      ],
    ),
    Row(
      children: <Widget>[
        const Spacer(),
        Image.asset('assets/imaginelab_logo.png',
            width: isHorizontal
                ? SizeConfig.blockSizeHorizontal * 20.0
                : SizeConfig.blockSizeHorizontal * 30.0),
        const Spacer()
      ],
    )
  ];

  final PackageInfo packageInfo = await PackageInfo.fromPlatform();

  appName = packageInfo.appName;
  appVersion =
      '${packageInfo.version} (Build: ${packageInfo.buildNumber})';

  showDialog(
    context: context,
    useRootNavigator: true,
    builder: (final BuildContext context) {
      return _AboutDialog(
          context,
          appName,
          appVersion,
          'Copyright © 2017-${DateTime.now().year} iMagineLab - All rights reserved.',
          Image.asset('assets/icon.png',
              width: isHorizontal
                  ? SizeConfig.blockSizeVertical * 20.0
                  : SizeConfig.blockSizeVertical * 10.0),
          children);
    },
  );
}

@override
Widget _AboutDialog(
    BuildContext context,
    String applicationName,
    String applicationVersion,
    String applicationLegalese,
    Widget applicationIcon,
    List<Widget> children) {
  assert(debugCheckHasMaterialLocalizations(context));
  final String name = applicationName;
  final String version = applicationVersion;
  final Widget icon = applicationIcon;
  return AlertDialog(
    content: ListBody(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconTheme(data: Theme.of(context).iconTheme, child: icon),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ListBody(
                  children: <Widget>[
                    FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(name,
                            style: Theme.of(context).textTheme.displaySmall)),
                    Text(version, style: Theme.of(context).textTheme.bodyMedium),
                    Container(height: 18.0),
                    Text(applicationLegalese ?? '',
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            ),
          ],
        ),
        ...children,
      ],
    ),
    actions: <Widget>[
      TextButton(
        child: Text(MaterialLocalizations.of(context).viewLicensesButtonLabel),
        onPressed: () {
          showLicensePage(
            context: context,
            applicationName: applicationName,
            applicationVersion: applicationVersion,
            applicationIcon: applicationIcon,
            applicationLegalese: applicationLegalese,
          );
        },
      ),
      TextButton(
        child: Text(MaterialLocalizations.of(context).closeButtonLabel),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ],
    scrollable: true,
  );
}
