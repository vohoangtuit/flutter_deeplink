import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';
import 'package:share_handler/share_handler.dart';
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
  String from = '';
  String content = '';
  String text = '';

  String contentAppLink = '';
  String textAppLink = '';
  String app1 = '';
  String app2 = '';
  String app3 = '';
  String app4 = '';
  String app5 = '';

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
            Text(
              'share_handler',
            ),
            Text(
              text,
            ),
            SizedBox(height: 5,),
            Text(
              content,
            ),
            SizedBox(height: 10,),
            Text(
              '***************************************',
            ),
            SizedBox(height: 10,),
            Text(
              'app_links',
            ),
            SizedBox(height: 10,),
            Text(
              textAppLink,

            ),
            SizedBox(height: 4,),
            Text(contentAppLink,),
            Text(
              '***************************************',
            ),
            Text(app1,),
            Text(app2,),
            Text(app3,),
            Text(app4,),
            Text(app5,),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initDeeplink();
    _initShare();
  }

  _initDeeplink() {
    AppLinks appLinks = AppLinks(); // AppLinks is singleton

    appLinks.uriLinkStream.listen((uri) {

      if (uri.data != null) {
        setState(() {
          contentAppLink = uri.data.toString();
          app1 =uri.data.toString();
          textAppLink =uri.queryParameters['text']??'';
        });
      }
    });
    appLinks.stringLinkStream.listen((uri) {
      Uri urii = Uri.parse(uri.toString());

      setState(() {
        app2 =uri.toString();
      });
      setState(() {
        contentAppLink = uri.toString();
        textAppLink =urii.queryParameters['text']??'';
      });
        });
    appLinks.getInitialLink().then((data) {
      if (data != null) {
        Uri uri = Uri.parse(data.toString());
        setState(() {
          app3 =data.toString();
          contentAppLink = data.toString();
          textAppLink =uri.queryParameters['text']??'';
        });
      }
    });
    appLinks.getInitialLinkString().then((data) {
      if (data != null) {
        Uri uri = Uri.parse(data.toString());
        setState(() {
          app4 =data.toString();
          contentAppLink = data.toString();
          textAppLink =uri.queryParameters['text']??'';
        });
      }
    });
    appLinks.getLatestLinkString().then((data) {
      if (data != null) {
        Uri uri = Uri.parse(data.toString());
        setState(() {
          app5 =data.toString();
          contentAppLink = data.toString();
          textAppLink =uri.queryParameters['text']??'';
        });
      }
    });

  }
  _initShare()async{
    SharedMedia? media;
    final handler = ShareHandler.instance;
    media = await handler.getInitialSharedMedia();

    handler.sharedMediaStream.listen((SharedMedia media) {
      setState(() {
        from ='listen';
      });
      log(media);
    });
    handler.getInitialSharedMedia().then((data) {
      if (data != null) {
        setState(() {
          from ='getInitialSharedMedia';
        });
        log(data);
      }else{
        print('getInitialSharedMedia null');
      }
    });

  }
  log(SharedMedia media){
    print('***************************************');
    print('content ${media.content}');
     print('attachments ${media.attachments}');
    // print('conversationIdentifier ${media.conversationIdentifier}');
    // print('senderIdentifier ${media.senderIdentifier}');
    // print('speakableGroupName ${media.speakableGroupName}');
    // print('serviceName ${media.serviceName}');

    if(media.content!=null){
      setState(() {
        content ='content: ${media.content!}';
      });
      Uri uri = Uri.parse(media.content!);
      print('uri ${uri.toString()}');
      print('queryParameters ${uri.queryParameters['text']}');
      setState(() {
        text =uri.queryParameters['text']??'';
      });
    }else if(media.attachments!=null){
      setState(() {
        content ='attachments: ${media.attachments!.toString()}';
      });
    }
  }
}

