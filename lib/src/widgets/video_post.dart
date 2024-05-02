import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../models/video_model.dart';

class VideoPost extends StatefulWidget {
  const VideoPost({Key? key, required this.videoModel}) : super(key: key);
  final Video videoModel;

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  bool? _ttChecked = false;
  bool? _fbChecked = false;
  bool? _inChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Selecciona la red social a la que subiras el video:',
          textAlign: TextAlign.center,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
                value: _ttChecked,
                onChanged: (bool? value) {
                  setState(() {
                    _ttChecked = value;
                  });
                }),
            FadeInUp(
                duration: const Duration(milliseconds: 1900),
                child: Padding(
                  padding: const EdgeInsets.only(right:25.0, left: 15),
                  child: Image.asset(
                    'assets/icons/tiktok.png',
                    height: 30,
                    width: 30,
                  ),
                )),
            const Text('Tik tok')
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
                value: _fbChecked,
                onChanged: (bool? value) {
                  setState(() {
                    _fbChecked = value;
                  });
                }),
            FadeInUp(
                duration: const Duration(milliseconds: 1900),
                child: Padding(
                  padding: const EdgeInsets.only(right:12.0),
                  child: Image.asset(
                    'assets/icons/fb.png',
                    height: 50,
                    width: 50,
                  ),
                )),
            const Text('Facebook')
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
                value: _inChecked,
                onChanged: (bool? value) {
                  setState(() {
                    _inChecked = value;
                  });
                }),
            FadeInUp(
                duration: const Duration(milliseconds: 1900),
                child: Padding(
                  padding: const EdgeInsets.only(right: 13),
                  child: Image.asset(
                    'assets/icons/insta.png',
                    height: 50,
                    width: 50,
                  ),
                )),
            const Text('Instagram')
          ],
        ),
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: () {},
            icon: const Icon(Icons.post_add, color: Colors.white),
            label:
                const Text("Publicar", style: TextStyle(color: Colors.white))),
      ],
    );
  }
}
