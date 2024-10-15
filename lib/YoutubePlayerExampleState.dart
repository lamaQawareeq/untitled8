import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  YoutubePlayerController ytcontrol = YoutubePlayerController(
    initialVideoId: 'fK9oJwWcQks', // معرف الفيديو على يوتيوب
    flags: YoutubePlayerFlags(
      autoPlay: true, // عدم التشغيل التلقائي
      mute: false, // تشغيل الفيديو على الوضع الصامت
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: YoutubePlayer(
          controller: ytcontrol,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.green,
          topActions: [
            SizedBox(width: 8,),
            Text(ytcontrol.metadata.title)
          ],
        ),
      ),
    );
  }
}
