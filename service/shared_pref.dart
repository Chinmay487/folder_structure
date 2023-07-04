import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// SharedPreferences? prefs;
var _secureStorage;

final key = Key.fromUtf8("B294gJjYMZBacdJyYI0d508KPsDRoP7m");
final iv = IV.fromLength(16);

final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: "PKCS7"));

sharedPrefInit() async {
  // prefs = await SharedPreferences.getInstance();
  _secureStorage = const FlutterSecureStorage();
}

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      // encryptedSharedPreferences: true,
      keyCipherAlgorithm: KeyCipherAlgorithm.RSA_ECB_PKCS1Padding,
      storageCipherAlgorithm: StorageCipherAlgorithm.AES_CBC_PKCS7Padding,
    );

saveKeyValString(String key, String data) async {
  // await _secureStorage.write(
  //     key: key, value: data, aOptions: _getAndroidOptions());

  await _secureStorage.write(
      key: encrypter.encrypt(key, iv: iv).base64,
      value: data,
      aOptions: _getAndroidOptions());
}

saveKeyValInt(String key, data) async {
  // await _secureStorage.write(
  //     key: key, value: data.toString(), aOptions: _getAndroidOptions());

  await _secureStorage.write(
      key: encrypter.encrypt(key, iv: iv).base64,
      value: data.toString(),
      aOptions: _getAndroidOptions());
}

saveKeyValBool(String key, bool data) async {
  // await _secureStorage.write(
  //     key: key, value: data.toString(), aOptions: _getAndroidOptions());

  await _secureStorage.write(
      key: encrypter.encrypt(key, iv: iv).base64,
      value: data.toString(),
      aOptions: _getAndroidOptions());
}

saveKeyValDouble(String key, double data) async {
  // await _secureStorage.write(
  //     key: key, value: data.toString(), aOptions: _getAndroidOptions());

  await _secureStorage.write(
      key: encrypter.encrypt(key, iv: iv).base64,
      value: data.toString(),
      aOptions: _getAndroidOptions());
}

getStringVal(String key) async {
  // return await _secureStorage.read(key: key, aOptions: _getAndroidOptions()) ??
  //     '';

  var encrypted = encrypter.encrypt(key, iv: iv).base64;
  // return encrypter.decrypt64(prefs!.getString(key)!, iv: iv);
  return await _secureStorage.read(
          key: encrypted, aOptions: _getAndroidOptions()) ??
      '';
}

getIntVal(String key) async {
  // var data =
  //     await _secureStorage.read(key: key, aOptions: _getAndroidOptions());
  // return int.parse(data.toString());

  var encrypted = encrypter.encrypt(key, iv: iv).base64;
  var data =
      await _secureStorage.read(key: encrypted, aOptions: _getAndroidOptions());
  return int.parse(data.toString());
}

getDoubleVal(String key) async {
  // var data =
  //     await _secureStorage.read(key: key, aOptions: _getAndroidOptions());
  // return double.parse(data.toString());

  var encrypted = encrypter.encrypt(key, iv: iv).base64;
  var data =
      await _secureStorage.read(key: encrypted, aOptions: _getAndroidOptions());
  return double.parse(data.toString());
}

removeVal(String key) async {
  //return await _secureStorage.delete(key: key, aOptions: _getAndroidOptions());
  return await _secureStorage.delete(key: key, aOptions: _getAndroidOptions());
}

removeAllSharedPref() async {
  //return await _secureStorage.deleteAll(aOptions: _getAndroidOptions());
  return await _secureStorage.deleteAll(aOptions: _getAndroidOptions());
}

Future<bool?> getBoolValue(String key) async {
  // var data = // encrypter.decrypt64(prefs!.getString(key)!, iv: iv);
  //     await _secureStorage.read(key: key, aOptions: _getAndroidOptions());
  // return data.toString().toLowerCase() == 'true';

  var data = // encrypter.decrypt64(prefs!.getString(key)!, iv: iv);
      await _secureStorage.read(key: key, aOptions: _getAndroidOptions());
  // return prefs.getInt(key);
  return data.toString().toLowerCase() == 'true';
}

Future<void> saveboolValue(String key, bool data) async {
  await _secureStorage.write(
      key: key, value: data, aOptions: _getAndroidOptions());
}

getBoolVal(String key) async {
  var encrypted = encrypter.encrypt(key, iv: iv).base64;
  // return prefs.getBool(key);
  var data = // encrypter.decrypt64(prefs!.getString(key)!, iv: iv);
      await _secureStorage.read(key: encrypted, aOptions: _getAndroidOptions());
  return data.toString().toLowerCase() == 'true';
}
