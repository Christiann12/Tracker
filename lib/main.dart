import 'package:contacttracer/models/netConnectionModel.dart';
import 'package:contacttracer/models/userModel.dart';
import 'package:contacttracer/process/authProcess.dart';
import 'package:contacttracer/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


void main() => runApp(Root());

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    return MultiProvider(
        providers: [
          StreamProvider<UserModel>.value(
          value: AuthProcess().user),
           StreamProvider<NetConnectionModel>.value(
          value: AuthProcess().onConnectivityChanged),
        ],
        child: MaterialApp(
        home: Wrapper()
      ),
    );
  }
}