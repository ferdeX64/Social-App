import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:socialapp/src/models/video_model.dart';
import 'package:socialapp/src/widgets/video_player.dart';
import 'package:socialapp/src/widgets/video_tabs.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoDetails extends StatefulWidget {
  const VideoDetails({Key? key, required this.videoModel}) : super(key: key);
  final Video videoModel;

  @override
  State<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
  
    _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoModel.videoUrl.toString()))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);  // to re-show bars
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return orientation==Orientation.portrait? FutureBuilder(
      future: show(),
      builder: (context, snapshot) {
        return SafeArea(
          child: Scaffold(
              body: CustomScrollView(
                shrinkWrap: true,
            slivers: [
              SliverAppBar(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 47, 62, 70),
                floating: false,
                pinned: false,
                expandedHeight: 280,
                flexibleSpace: FlexibleSpaceBar(
                    background: _controller.value.isInitialized
                        ? VideoPlayerWidget(videoModel:widget.videoModel.videoUrl!, controller:_controller,)
                        : const Center(child: CircularProgressIndicator())),
              ),
              SliverFillRemaining(
                
                  child: VideoTabs(
                videoModel: widget.videoModel,
              ))
            ],
          )),
        );
      }
    ):FutureBuilder(
      future: hide(),
      builder: (context, snapshot) {
        return FullScreenWidget(disposeLevel: DisposeLevel.High, child: VideoPlayerWidget(videoModel: widget.videoModel.videoUrl, controller: _controller,));
      }
    );
    }
  Future hide()async{
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    
  }
  Future show()async{
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    
  }

  Future<File> image() async {
    File image;

    final foto = await VideoThumbnail.thumbnailFile(
      video: widget.videoModel.videoUrl!,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      maxHeight:
          150, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 100,
    );
    image = File(foto!);
    return image;
  }
}
