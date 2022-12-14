import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webtoons/services/anime_parsers/gogoanime_parser.dart';
import 'package:webtoons/models/entry_info.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AnimeViewer extends StatefulWidget {
  const AnimeViewer({Key? key, required this.episode}) : super(key: key);

  final Episode episode;

  @override
  State<AnimeViewer> createState() => _AnimeViewerState();
}

class _AnimeViewerState extends State<AnimeViewer> {
  late Episode stateEpisode;
  bool episodeLoaded = false;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    if (Platform.isIOS) WebView.platform = CupertinoWebView();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: []);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    GogoanimeParser().getViewerInfo(widget.episode).then((value) {
      setState(() {
        stateEpisode = value;
        episodeLoaded = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: buildUi(context)),
    );
  }

  Widget buildUi(BuildContext context) {
    if (episodeLoaded) {
      return WebView(
        initialUrl: stateEpisode.servers[0],
        javascriptMode: JavascriptMode.unrestricted,
        initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
        navigationDelegate: (request) async {
          if (!request.url.contains(stateEpisode.servers[0])) {
            return NavigationDecision.prevent;
          } else {
            return NavigationDecision.navigate;
          }
        },
      );
    } else {
      return const CircularProgressIndicator();
    }
  }
}
