import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewExample(),
    );
  }
}

class WebViewExample extends StatefulWidget {
  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  final String url = 'https://namu.wiki/w/%EB%A0%88%ED%82%B9%EB%B3%BC'; // 연결할 사이트 URL
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("햄스터 정보 확인",
          style: TextStyle(
              fontSize: 25
          ),),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
