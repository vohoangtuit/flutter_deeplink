import 'dart:async';

import 'package:flutter/material.dart';
import 'deep_link_model.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Deep Link'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamSubscription? _linkSubscription;

  DeepLinkModel deepLink =DeepLinkModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('  url: ${deepLink.link!=null?deepLink.link:''}',),

            SizedBox(height: 30,),
            Text('  utm_source: ${deepLink.utm_source!=null?deepLink.utm_source:''}',),
            SizedBox(height: 30,),
            Text('  tourId: ${deepLink.tourId!=null?deepLink.tourId:''}',),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (_linkSubscription != null) {
      _linkSubscription!.cancel();
    }
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInitialText();
  }

  _getInitialText() async{


    ReceiveSharingIntent.getInitialTextAsUri().then((uri){
      if(uri!=null){
        _handelIntentLinkDetail(uri);
       }else{
        print('deepLink null');
      }

    },onError: (error){
      print(error.toString());
    });
    _linkSubscription =
        ReceiveSharingIntent.getTextStreamAsUri().listen(( uri) {
          _handelIntentLinkDetail(uri);
        }, onError: (err) {
          print("getTextStreamAsUri error: $err");
        });
  }
  _handelIntentLinkDetail(Uri uri)async{
    setState(() {
      deepLink.link =uri.toString();
      deepLink.tourId =uri.queryParameters['tourId'] ?? '';
      deepLink.utm_source =uri.queryParameters['utm_source'] ?? '';
      deepLink.rk =uri.queryParameters['rk'] ?? '';
      deepLink.atnct1 =uri.queryParameters['atn-ct1']??'';
      deepLink.atnct2 =uri.queryParameters['atnct2'] ?? '';
      deepLink.atnct3 =uri.queryParameters['atnct3'] ?? '';
    });

  }

}
// todo update file pub
// export PATH="/Users/admin/VO_HOANG_TU/dev/AndroidStudio/sdk/flutter/bin:$PATH"
// > flutter clean
// > flutter pub get
// > cd ios
// > pod update || pod install // todo if error run:  'pod deintegrate' before