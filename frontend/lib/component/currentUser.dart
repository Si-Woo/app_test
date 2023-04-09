import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = FlutterSecureStorage();

  Future writeSecureData(String key, String value) async {
    var writeData = await _storage.write(key: "login", value: value);
    return writeData;
  }

  Future readSecureData(String key) async {
    var readData = await _storage.read(key: "login");
    return readData;
  }

  Future deleteSecureData(String key) async {
    var deleteData = await _storage.delete(key: 'login');
    return deleteData;
  }
}
