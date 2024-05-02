import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/src/models/video_model.dart';
import 'package:socialapp/src/providers/main_provider.dart';
import 'package:socialapp/src/services/video_service.dart';
import 'package:socialapp/src/widgets/video_card.dart';

class VideoList extends StatefulWidget {
  const VideoList({super.key});

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final Stream<QuerySnapshot> videoStream = FirebaseFirestore.instance
        .collection('Videos')
        .where("user_name", isEqualTo: mainProvider.name)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: videoStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: SizedBox(child: Text('Error al consultar los videos.')),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: CircularProgressIndicator()),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: SizedBox(
                  child: Text('Aun no has subido ningún video. Sube ya!')),
            );
          }

          return ListView(
            
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Video videoModel =
                  Video.fromJson(document.data() as Map<String, dynamic>);
              return Slidable(
                key: UniqueKey(),

                  // The start action pane is the one at the left or the top side.
                  startActionPane: ActionPane(
                    extentRatio: 0.3,
                    // A motion is a widget used to control how the pane animates.
                    motion: const StretchMotion(),
                    dismissible: DismissiblePane(onDismissed: ()  {
                      final videoSrv = VideoService();
                      videoSrv.deleteVideo(videoModel.videoUrl!);
                     
                    }),

                    // A pane can dismiss the Slidable.

                    // All actions are defined in the children parameter.
                    children: [
                      // A SlidableAction can have an icon and/or a label.
                      SlidableAction(
                        onPressed: doNothing,
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Eliminar',
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ],
                  ),
                child: VideoCard(videoModel: videoModel));
            }).toList(),
          );
        });
  }
}
void doNothing(BuildContext context) {}
