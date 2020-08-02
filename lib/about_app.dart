import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geldwegwijzer/sizeconfig.dart';
import 'package:package_info/package_info.dart';

Future<void> openAboutApp(BuildContext context) async {
  bool isHorizontal = SizeConfig.screenWidth > SizeConfig.screenHeight;
  String appName;
  String appVersion;
  List<Widget> children = <Widget>[
    SizedBox(height: SizeConfig.blockSizeVertical * 4.0),
    Text('In samenwerking met', textAlign: TextAlign.center, style: TextStyle(fontSize: isHorizontal ? SizeConfig.blockSizeVertical * 4.0 : SizeConfig.blockSizeVertical * 2.0)),
    Row(
      children: <Widget>[
        Image.asset('assets/teamscheire_logo.png', width: isHorizontal ? SizeConfig.blockSizeHorizontal * 16.0 : SizeConfig.blockSizeHorizontal * 25.0),
        SizedBox(width: SizeConfig.blockSizeHorizontal * 4.0),
        Image.asset('assets/uantwerpen_logo.png', width: isHorizontal ? SizeConfig.blockSizeHorizontal * 20.0 : SizeConfig.blockSizeHorizontal * 30.0),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    ),
    Row(children: <Widget>[
      Spacer(),
      Image.asset('assets/imaginelab_logo.png', width: isHorizontal ? SizeConfig.blockSizeHorizontal * 20.0 : SizeConfig.blockSizeHorizontal * 30.0),
      Spacer()
    ],)
  ];

  if (kIsWeb) {
    appName = 'Geldwegwijzer';
    appVersion = '2.0.5';
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
        Image.asset('assets/icon.png', width: isHorizontal ? SizeConfig.blockSizeVertical * 20.0 : SizeConfig.blockSizeVertical * 10.0),
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
                    FittedBox(fit: BoxFit.fitWidth, child: Text(name, style: Theme.of(context).textTheme.headline3)),
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