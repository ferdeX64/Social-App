import 'package:rxdart/rxdart.dart';
import 'package:socialapp/src/bloc/validator_bloc.dart';



class SignUpBloc with Validator {
  SignUpBloc();
  //Controllers
  
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _usernameController = BehaviorSubject<String>();
  final _videonameController = BehaviorSubject<String>();
  final _videoDescriptionController = BehaviorSubject<String>();
  //Streams, vinculados con la validación
  Stream<String> get emailStream =>
      _emailController.stream.transform(emailValidator);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(passwordValidator);
  Stream<String> get usernameStream =>
      _usernameController.stream.transform(usernameValidator);
  Stream<bool> get formSignUpStream => Rx.combineLatest3(
      usernameStream, emailStream, passwordStream, (a, b, c) => true);
  Stream<String> get videonameStream =>
      _videonameController.stream.transform(videonameValidator);
  Stream<String> get videoDescriptionStream =>
      _videoDescriptionController.stream.transform(videoDescriptionValidator);
  Stream<bool> get formVideoStream => Rx.combineLatest2(
      videonameStream, videoDescriptionStream, (a, b) => true);

    
  //Funciones para el onChange cada control
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeUsername => _usernameController.sink.add;
   Function(String) get changeVideoname => _videonameController.sink.add;
  Function(String) get changeVideoDescription => _videoDescriptionController.sink.add;
  //Propiedades con el valor del texto ingreso
  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get username => _usernameController.value;
  String get videoname=>_videonameController.value;
  String get videodescription=>_videoDescriptionController.value;
  dispose() {
    _usernameController.close();
    _emailController.close();
    _passwordController.close();
    _videoDescriptionController.close();
    _videonameController.close();
  }
}
