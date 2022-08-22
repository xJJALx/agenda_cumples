import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:agenda_cumples/data/models/models.dart';
import 'package:agenda_cumples/data/repositories/firebase_cumples_repository.dart';

class UserProvider extends ChangeNotifier {
  static User usuario = User(displayName: '');
  final FirebaseCumplesRepository _repository = FirebaseCumplesRepository();
  bool _isEditMode = false;
  String _uid = '';
  File? _filePicture;

  get displayName => usuario.displayName;
  get ocupacion => usuario.ocupacion;
  get isEditMode => _isEditMode;

  set setEditMode(bool value) {
    _isEditMode = value;
    notifyListeners();
  }

  void setUid(String id) {
    _uid = id;
    usuario.uid = _uid;
    loadUser();
  }

  loadUser() async {
    await _repository.getInfoUser(_uid).then((info) {
      usuario.displayName = info.displayName;
      usuario.ocupacion = info.ocupacion;
      usuario.docId = info.docId;
      usuario.profilePicture = info.profilePicture;
    });
    notifyListeners();
  }

  addInfoUser() async {
    _repository.addInfoUserFirebase(usuario).then((value) => usuario.docId = value);
    notifyListeners();
  }

  updateInfoUser() {
    _repository.updateInfoUserFirebase(usuario);
    notifyListeners();
  }

  void updateImage(String path) {
    _filePicture = File.fromUri(Uri(path: path));
    uploadImage();
  }

  void uploadImage() async {
    if (_filePicture == null) return null;

    final url = Uri.parse('https://api.cloudinary.com/v1_1/jjalcloud/image/upload?upload_preset=sy2n6oce');
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', _filePicture!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      debugPrint('algo salio mal');
      debugPrint(resp.body);
      return null;
    }

    _filePicture = null;

    final decodedData = json.decode(resp.body);
    usuario.profilePicture = decodedData['secure_url'];
    notifyListeners();
  }
}
