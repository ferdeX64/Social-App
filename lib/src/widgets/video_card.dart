import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:socialapp/src/widgets/video_details.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../models/video_model.dart';

class VideoCard extends StatefulWidget {
  const VideoCard({Key? key, required this.videoModel}) : super(key: key);
  final Video videoModel;

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Tooltip(
      message: 'Desliza para eliminar',
      child: InkWell(
        onTap: () {
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) =>
                  VideoDetails(videoModel: widget.videoModel),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: SizedBox(
                  height: 150,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FutureBuilder<File>(
                          future: image(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Center(
                                child: SizedBox(
                                    child:
                                        Text('Error al consultar los videos.')),
                              );
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Skeletonizer(
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/video.png',
                                    scale: 0.2,
                                  ),
                                ),
                              );
                            }
    
                            return Stack(alignment: Alignment.center, children: [
                              AspectRatio(
                                aspectRatio: 1,
                                child: Image.file(snapshot.data!.absolute),
                              ),
                              const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 50.0,
                                semanticLabel: 'Play',
                              )
                            ]);
                          }),
                      Expanded(
                        child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        widget.videoModel.videoName!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(bottom: 2.0)),
                                      Text(
                                        widget.videoModel.videoDescription!,
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        'Autor: ${widget.videoModel.userName}',
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(bottom: 2.0)),
                                      Text(
                                        "Fecha: ${widget.videoModel.videoDate}",
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

  @override

  bool get wantKeepAlive => true;
}
