import 'dart:async';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  late StreamSubscription _intentSub;
  final _sharedFiles = <SharedMediaFile>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_sharedFiles
                .map((f) => f.toMap())
                .join(",\n****************\n")),



          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _shareIntent();
  }
  _shareIntent(){
    _intentSub = ReceiveSharingIntent.instance.getMediaStream().listen((value) {
      setState(() {
        _sharedFiles.clear();
        _sharedFiles.addAll(value);

        print(_sharedFiles.map((f) => f.toMap()));
      });
    }, onError: (err) {
      print("getIntentDataStream error: $err");
    });

    // Get the media sharing coming from outside the app while the app is closed.
    ReceiveSharingIntent.instance.getInitialMedia().then((value) {
      Fluttertoast.showToast(
          msg: value.toString(),
          backgroundColor: Colors.grey,
          gravity: ToastGravity.CENTER,
          fontSize: 16.0);

      setState(() {
        _sharedFiles.clear();
        _sharedFiles.addAll(value);
        print(_sharedFiles.map((f) => f.toMap()));

        // Tell the library that we are done processing the intent.
        ReceiveSharingIntent.instance.reset();
      });
    });
  }

  // _initDeeplink() {
  //   AppLinks appLinks = AppLinks(); // AppLinks is singleton
  //
  //   appLinks.uriLinkStream.listen((uri) {
  //     print('uri1 path : ${uri.path}');
  //     print('uri1 data: ${uri.data}');
  //
  //     if (uri.data != null) {
  //       setState(() {
  //         contentAppLink1 = uri.data.toString();
  //         app1 =uri.data.toString();
  //         textAppLink =uri.queryParameters['text']??'';
  //       });
  //     }
  //   });
  //   appLinks.stringLinkStream.listen((uri) {
  //     print('uri2  : ${uri.toString()}');
  //
  //     Uri urii = Uri.parse(uri.toString());
  //
  //     setState(() {
  //       app2 =uri.toString();
  //     });
  //     setState(() {
  //       contentAppLink2 = uri.toString();
  //       textAppLink =urii.queryParameters['text']??'';
  //     });
  //       });
  //   appLinks.getInitialLink().then((data) {
  //
  //     if (data != null) {
  //       print('uri3  path : ${data.path}');
  //       print('uri3 data : ${data.data}');
  //
  //       Uri uri = Uri.parse(data.toString());
  //       setState(() {
  //         app3 =data.toString();
  //         contentAppLink3 = data.toString();
  //         textAppLink =uri.queryParameters['text']??'';
  //       });
  //     }
  //   });
  //   appLinks.getInitialLinkString().then((data) {
  //     if (data != null) {
  //       print('uri4   : ${data.toString()}');
  //
  //       Uri uri = Uri.parse(data.toString());
  //       setState(() {
  //         app4 =data.toString();
  //         contentAppLink4 = data.toString();
  //         textAppLink =uri.queryParameters['text']??'';
  //       });
  //     }
  //   });
  //   appLinks.getLatestLinkString().then((data) {
  //     if (data != null) {
  //       print('uri5   : ${data.toString()}');
  //       Uri uri = Uri.parse(data.toString());
  //       setState(() {
  //         app5 =data.toString();
  //         contentAppLink5 = data.toString();
  //         textAppLink =uri.queryParameters['text']??'';
  //       });
  //     }
  //   });
  //
  // }
  // _initShare()async{
  //   final handler = ShareHandler.instance;
  //  await handler.getInitialSharedMedia();
  //
  //   handler.sharedMediaStream.listen((SharedMedia media) {
  //
  //     if(media.content!=null){
  //       setState(() {
  //         content =media.content!;
  //       });
  //       Uri uri = Uri.parse(media.content!);
  //       text =uri.queryParameters['text']??'';
  //     }
  //     //print('attachments: ${media.attachments}');
  //   });
  //   handler.getInitialSharedMedia().then((data) {
  //     if (data != null) {
  //       Uri uri = Uri.parse(data.content!);
  //       setState(() {
  //         content1 =data.content!;
  //         text1 =uri.queryParameters['text']??'';
  //       });
  //     }else{
  //       print('getInitialSharedMedia null');
  //     }
  //
  //   });
  //
  // }
  // _log(SharedMedia media){
  //   print('***************************************');
  //   print('content ${media.content}');
  //    print('attachments ${media.attachments}');
  //   // print('conversationIdentifier ${media.conversationIdentifier}');
  //   // print('senderIdentifier ${media.senderIdentifier}');
  //   // print('speakableGroupName ${media.speakableGroupName}');
  //   // print('serviceName ${media.serviceName}');
  //
  //   if(media.content!=null){
  //     setState(() {
  //       content ='content: ${media.content!}';
  //     });
  //     Uri uri = Uri.parse(media.content!);
  //     print('uri ${uri.toString()}');
  //     print('queryParameters ${uri.queryParameters['text']}');
  //     setState(() {
  //       text =uri.queryParameters['text']??'';
  //     });
  //   }else if(media.attachments!=null){
  //     setState(() {
  //       content ='attachments: ${media.attachments!.toString()}';
  //     });
  //   }
  // }
}

