import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    const MaterialApp(
      home: VideoPage(),
    ),
  );
}

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  static const platform =
      MethodChannel('https://www.youtube.com/watch?v=jfKfPfyJRdk');

  // YouTube yayınının ID'sini buraya yazın
  final String videoId = 'VIDEO_ID';

  Future<void> _openYoutubeVideo() async {
    try {
      await platform.invokeMethod('openYoutubeVideo', {'videoId': videoId});
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _openYoutubeVideo,
          child: const Text('Open YouTube Video'),
        ),
      ),
    );
  }
}
