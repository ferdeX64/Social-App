import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';

import '../models/video_model.dart';

class VideoService {
  VideoService();
  final db = FirebaseFirestore.instance;
  Future deleteVideo(String videoUrl) async {
    db.collection("Videos").where("video_url", isEqualTo: videoUrl).get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          db.collection("Videos").doc(docSnapshot.id).delete();

  
        }
      },

    );
  }

  Future<int> postVideo(Video video, BuildContext context) async {
    List videos = [];

    db
        .collection('Videos')
        .where("user_name", isEqualTo: video.userName)
        .where("video_name", isEqualTo: video.videoName)
        .get()
        .then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        videos.add(docSnapshot.data());
      }
      if (videos.isEmpty) {
        db.collection('Videos').add({
          "user_name": video.userName,
          "video_date": video.videoDate,
          "video_description": video.videoDescription,
          "video_name": video.videoName,
          "video_url": video.videoUrl
        });
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              surfaceTintColor: Colors.white,
                  title: const Text('Exito'),
                  content: const Text('Video agregado correctamente.'),
                  actions: <Widget>[
                    // ignore: deprecated_member_use
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('Ok'))
                  ],
                ));
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Alerta'),
                  content: const Text('Ya existe un video con ese nombre.'),
                  actions: <Widget>[
                    // ignore: deprecated_member_use
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Ok'))
                  ],
                ));
        return 500;
      }
    }, onError: (e) {
      
    });
    return 201;
  }

  Future<String> uploadVideo(File video) async {
    final cloudinary = CloudinaryPublic('dcdvfurak', 'doyxxv6g', cache: false);
    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(video.path,
            resourceType: CloudinaryResourceType.Video),
      );
      return response.secureUrl;
    } on CloudinaryException catch (e) {
      // ignore: avoid_print
      print(e.message);
      // ignore: avoid_print
      print(e.request);
      return "";
    }
  }
}
