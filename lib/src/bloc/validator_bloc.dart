import 'dart:async';

mixin Validator {
  final emailValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      String pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = RegExp(pattern);
      if (regExp.hasMatch(data)) {
        sink.add(data); //La validación se cumplió
      } 
      else {
        sink.addError('* Correo no válido.');
        
      }
    },
  );

  final passwordValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.length >= 6) {
        sink.add(data); //La validación se cumplió
      } else {
        sink.addError('* Contraseña de al menos 6 caracteres.');
      }
    },
  );

  final usernameValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.length >= 3) {
        sink.add(data); //La validación se cumplió
      } else {
        sink.addError('* Usuario de al menos 3 caracteres.');
      }
    },
  );
  final videonameValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.length >= 5) {
        sink.add(data); //La validación se cumplió
      } else {
        sink.addError('* Nombre de 5 caracteres.');
      }
    },
  );
  final videoDescriptionValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.length >= 8) {
        sink.add(data); //La validación se cumplió
      } else {
        sink.addError('* Descripcion de 8 caracteres.');
      }
    },
  );
}