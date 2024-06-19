import 'package:flutter/material.dart';
import 'package:miapp_web/my_web_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Brunner App',
      debugShowCheckedModeBanner: false,
      theme:  ThemeData(useMaterial3: true),
      home: WebViewApp(),
    );
  }
}

class WebViewApp extends StatefulWidget{
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp>{
  late final WebViewController controller;

  @override
  void initState(){
    super.initState();
    controller = WebViewController()..loadRequest(
      Uri.parse('https://grupobrunner.com/intranet_brunner/'),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(25.0),
        child: AppBar(
          title: Text("Brunner App",
            style: TextStyle(fontSize: 14.0)),
          actions: [
            Row(
              children: [
                SizedBox(
                  height: 25.0,
                  child: IconButton(
                    iconSize: 15.0,
                    icon: Icon(Icons.arrow_back_ios),
                      onPressed: () async{
                      final messenger = ScaffoldMessenger.of(context);
                      if(await controller.canGoBack()){
                        await controller.goBack();
                      }
                      else {
                        messenger.showSnackBar(
                          SnackBar(content: Text("No hay historial disponible")),
                          );
                        return;
                      }
                    }, 
                  ),
                ),
                SizedBox(
                  height: 25.0,
                  child: IconButton(
                    iconSize: 15.0,
                    icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () async{
                      final messenger = ScaffoldMessenger.of(context);
                      if(await controller.canGoForward()){
                        await controller.goForward();
                      }
                      else {
                        messenger.showSnackBar(
                          SnackBar(content: Text("No hay historial de avance")),
                          );
                        return;
                      }
                      }, 
                  ),
                ),

                SizedBox(
                  height: 25.0,
                  child: IconButton(
                    iconSize: 15.0,
                    icon: Icon(Icons.replay),
                    onPressed: () {
                      controller.reload();
                    },
                  ),
                ),
            ],
          )
        ],
      ),
      ),
      
      body: MyWebView(controller: controller,),
    );
  }
}