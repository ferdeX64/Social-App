import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainProvider extends ChangeNotifier {
  bool _mode = true;
  String _token = "";
  String _language = "es";
  bool _intro = true;
  bool _mira = true;
  bool _compra = true;
  bool _carrito = true;
  bool _helados=true;
  String _name="";

  bool get mode {
    return _mode;
  }

  set mode(bool value) {
    _mode = value;
    notifyListeners();
  }

  String get token {
    return _token;
  }

  set token(String t) {
    _updateToken(t);
    _token = t;
  }
  
  String get name {
    return _name;
  }

  set name(String t) {
    _updateName(t);
    _name = t;
  }

  bool get intro {
    return _intro;
  }

  set intro(bool value) {
    _updateIntro(value);
    _intro = value;
  }

  bool get mira {
    return _mira;
  }

  set mira(bool value) {
    _updateMira(value);
    _mira = value;
  }

  bool get compra {
    return _compra;
  }

  set compra(bool value) {
    _updateCompra(value);
    _compra = value;
  }

  bool get carrito {
    return _carrito;
  }

  set carrito(bool value) {
    _updateCarrito(value);
    _carrito = value;
  }
  
  bool get helados {
    return _helados;
  }

  set helados(bool value) {
    _updateHelados(value);
    _helados = value;
  }

  String get language {
    return _language;
  }

  set language(String value) {
    _language = value;
    notifyListeners();
  }

  Future<bool> initPrefs() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _mode = prefs.getBool("mode") ?? true;
      _token = prefs.getString("token") ?? "";
      _name = prefs.getString("name") ?? "";
      _intro = prefs.getBool("intro") ?? true;
      _mira = prefs.getBool("mira") ?? true;
      _compra = prefs.getBool("compra") ?? true;
      _carrito=prefs.getBool("carrito")??true;
      _helados=prefs.getBool("helados")??true;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> _updateToken(String t) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", t);
  }
  
  Future<void> _updateName(String t) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", t);
  }


  Future<void> _updateIntro(bool t) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("intro", t);
  }

  Future<void> _updateMira(bool t) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("mira", t);
  }

  Future<void> _updateCompra(bool t) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("compra", t);
  }
  Future<void> _updateCarrito(bool t) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("carrito", t);
  }
  Future<void> _updateHelados(bool t) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("helados", t);
  }
}
