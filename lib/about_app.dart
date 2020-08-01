import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geldwegwijzer/sizeconfig.dart';
import 'package:package_info/package_info.dart';

Future<void> openAboutApp(BuildContext context) async {
  String appName;
  String appVersion;
  List<Widget> children = List<Widget>();

  if (kIsWeb) {
    appName = 'Geldwegwijzer';
    appVersion = '2.0.0';
  }
  else {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    appName = packageInfo.appName;
    appVersion = packageInfo.version + ' (Build: ' + packageInfo.buildNumber + ')';
  }

  showDialog(
    context: context,
    useRootNavigator: true,
    builder: (BuildContext context) {
      return _AboutDialog(
        context,
        appName,
        appVersion,
        'Copyright © 2017-' + DateTime.now().year.toString() + ' iMagineLab - All rights reserved.',
        Image.asset('assets/icon.png', width: SizeConfig.blockSizeVertical * 10.0),
        children
      );
    },
  );
}

@override
Widget _AboutDialog(BuildContext context, String applicationName, String applicationVersion, String applicationLegalese, Widget applicationIcon, List<Widget> children) {
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
            if (icon != null) IconTheme(data: Theme.of(context).iconTheme, child: icon),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ListBody(
                  children: <Widget>[
                    FittedBox(fit: BoxFit.fitWidth, child: Text(name, style: Theme.of(context).textTheme.headline5)),
                    Text(version, style: Theme.of(context).textTheme.bodyText2),
                    Container(height: 18.0),
                    Text(applicationLegalese ?? '', style: Theme.of(context).textTheme.caption),
                  ],
                ),
              ),
            ),
          ],
        ),
        ...?children,
      ],
    ),
    actions: <Widget>[
      FlatButton(
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
      FlatButton(
        child: Text(MaterialLocalizations.of(context).closeButtonLabel),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ],
    scrollable: true,
  );
}