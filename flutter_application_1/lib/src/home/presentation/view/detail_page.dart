import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.url});
  final String? url;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final controllers = WebViewController();

  @override
  Widget build(BuildContext context) {
    controllers.setJavaScriptMode(JavaScriptMode.unrestricted);
    controllers.setBackgroundColor(const Color(0x00000000));

    controllers.loadRequest(Uri.parse(widget.url ?? ""));
    return Scaffold(
        appBar: AppBar(), body: WebViewWidget(controller: controllers));
  }
}
