import 'package:flutter/material.dart';

import '../models/video_model.dart';

class VideoTabDetails extends StatefulWidget {
  const VideoTabDetails({Key? key, required this.videoModel}) : super(key: key);
  final Video videoModel;

  @override
  State<VideoTabDetails> createState() => _VideoTabDetailsState();
}

class _VideoTabDetailsState extends State<VideoTabDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.symmetric(horizontal:10.0),
          child: Row(
            
            mainAxisSize: MainAxisSize.min,
            children: [
               const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    
                     Text("Nombre del video:",
                         style: TextStyle(fontWeight: FontWeight.bold)),
                     Text("Descripción:",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                     Text("Fecha:",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Flexible(
                     flex:4,
                     child: Text("URL:",
                         style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                        ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    
                    Text(" ${widget.videoModel.videoName}",maxLines: 1,overflow: TextOverflow.ellipsis),
                    Text(" ${widget.videoModel.videoDescription}",maxLines: 1,overflow: TextOverflow.ellipsis),
                    Text(" ${widget.videoModel.videoDate}"),
                    Flexible(flex: 1,
                      child: Text(" ${widget.videoModel.videoUrl}",maxLines: 1, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis
                      ,)),
                  ],
                ),
              ),
            ],
          ),
        );
  }
}