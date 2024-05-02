import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/src/models/video_model.dart';
import 'package:socialapp/src/providers/main_provider.dart';
import 'package:socialapp/src/services/video_service.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../bloc/signup_bloc.dart';

class AddVideoPage extends StatefulWidget {
  const AddVideoPage({super.key});

  @override
  State<AddVideoPage> createState() => _AddVideoPageState();
}

class _AddVideoPageState extends State<AddVideoPage> {
  late SignUpBloc bloc;
  final TextEditingController _videoNameTextController =
      TextEditingController();
  final TextEditingController _videoDescriptionTextController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late Video _video;
  File? _vidio;
  Uint8List? _thumb;
  final ImagePicker _picker = ImagePicker();
  bool _onSaving = false;
  bool videoSelected = false;
  final VideoService _videosService = VideoService();
  @override
  void initState() {
    bloc = SignUpBloc();
    super.initState();

    _video = Video.created();
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    _video.userName = mainProvider.name;
    var date = DateTime.parse(DateTime.now().toString());
    var formattedDate = "${date.day}/${date.month}/${date.year}";
    _video.videoDate = formattedDate;

    return Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text("Agregar video",
                style: TextStyle(color: Colors.white)),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 47, 62, 70)),
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(width: 2.0, color: Colors.black)),
              child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                         horizontal: 7.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        StreamBuilder(
                            stream: bloc.videonameStream,
                            builder: (BuildContext context,
                                    AsyncSnapshot snapshot) =>
                                TextFormField(
                                    onChanged: bloc.changeVideoname,
                                    controller: _videoNameTextController,
                                    keyboardType: TextInputType.text,
                                    textCapitalization: TextCapitalization.words,
                                    onSaved: (value) {
                                      _video.videoName = value.toString();
                                    },
                                    decoration: InputDecoration(
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        labelStyle: const TextStyle(
                                            color: Colors.black),
                                        errorStyle:
                                            const TextStyle(color: Colors.red),
                                        errorText: snapshot.error?.toString(),
                                        labelText: "Nombre del video"),
                                    maxLength: 20,
                                    maxLines: 1)),
                        StreamBuilder(
                            stream: bloc.videoDescriptionStream,
                            builder: (context, snapshot) {
                              return TextFormField(
                                  onChanged: bloc.changeVideoDescription,
                                  controller: _videoDescriptionTextController,
                                  keyboardType: TextInputType.text,
                                  textCapitalization: TextCapitalization.sentences,
                                  onSaved: (value) {
                                    //Este evento se ejecuta cuando se cumple la validación y cambia el estado del Form
                                    _video.videoDescription = value.toString();
                                  },
                                  decoration: InputDecoration(
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    labelText: "Descripción",
                                    labelStyle:
                                        const TextStyle(color: Colors.black),
                                    errorStyle:
                                        const TextStyle(color: Colors.red),
                                    errorText: snapshot.error?.toString(),
                                  ),
                                  maxLength: 255,
                                  maxLines: 2);
                            }),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 7.0),
                          child: Text("Seleccionar video"),
                        ),
                        SizedBox(
                          height: 100,
                          width: 150,
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: _thumb == null
                                ? Image.asset('assets/images/video.png')
                                : Image.memory(_thumb!),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black),
                                onPressed: () =>
                                    _selectVideo(ImageSource.camera),
                                icon: const Icon(Icons.camera,
                                    color: Colors.white),
                                label: const Text(
                                  "Cámara",
                                  style: TextStyle(color: Colors.white),
                                )),
                            ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black),
                                onPressed: () =>
                                    _selectVideo(ImageSource.gallery),
                                icon: const Icon(Icons.image,
                                    color: Colors.white),
                                label: const Text("Galería",
                                    style: TextStyle(color: Colors.white))),
                          ],
                        ),
                        _onSaving
                            ? const Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.0),
                                child: CircularProgressIndicator())
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: Tooltip(
                                  message: "Guardar los datos de tu video.",
                                  child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue),
                                      onPressed: () {
                                        if (_videoNameTextController
                                                    .text.length >=
                                                5 &&
                                            _videoDescriptionTextController
                                                    .text.length >=
                                                8) {
                                          _sendForm(context);
                                        }
                                      },
                                      label: const Text("Guardar",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      icon: const Icon(Icons.save,
                                          color: Colors.white)),
                                ),
                              )
                      ],
                    ),
                  )),
            ),
          ),
        ]));
  }

  Future _selectVideo(ImageSource source) async {
    XFile? pickedFile = await _picker.pickVideo(source: source);
    if (pickedFile != null) {
      _vidio = File(pickedFile.path);
      _thumb = await VideoThumbnail.thumbnailData(
        video: pickedFile.path,
        imageFormat: ImageFormat.JPEG,
        maxWidth:
            128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
        quality: 25,
      );
      videoSelected = true;
    } else {
      _vidio = null;

      //print('No image selected.');
    }
    setState(() {});
  }

  _sendForm(context) async {
    if (!_formKey.currentState!.validate()) return;

    if (videoSelected == false) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                surfaceTintColor: Colors.white,
                title: const Text('Error'),
                content: const Text('Seleccione un video.'),
                actions: <Widget>[
                  // ignore: deprecated_member_use
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Ok'))
                ],
              ));
    } else {
      _onSaving = true;
      setState(() {});

      //Vincula el valor de las controles del formulario a los atributos del modelo
      _formKey.currentState!.save();

      if (_vidio != null) {
        _video.videoUrl = await _videosService.uploadVideo(_vidio!);
      }

      //Invoca al servicio POST para enviar la Foto

      int? estado = await _videosService.postVideo(_video, context);

      if (estado == 201) {
        _formKey.currentState!.reset();
        _onSaving = false;
        _formKey.currentState!.setState(() {});
        videoSelected = false;
        setState(() {});
      }
    }
  }
}
