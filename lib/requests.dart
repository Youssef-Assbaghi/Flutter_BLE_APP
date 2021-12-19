import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'tree.dart';
import 'globals.dart' as globals;

final http.Client client = http.Client();
// better than http.get() if multiple requests to the same server

// If you connect the Android emulator to the webserver listening to localhost:8080
const String baseUrl = "http://192.168.1.49:8080";
//192.168.1.49

// If instead you want to use a real phone, run this command in the linux terminal
//   ssh -R joans.serveousercontent.com:80:localhost:8080 serveo.net
//const String baseUrl = "https://joans.serveousercontent.com";

Future<Tree> getTree(int id) async {
  String uri = "$baseUrl/get_tree?$id";
  final response = await client.get(uri);
  // response is NOT a Future because of await but since getTree() is async,
  // execution continues (leaves this function) until response is available,
  // and then we come back here
  if (response.statusCode == 200) {
    print("statusCode=$response.statusCode");
    print(response.body);
    // If the server did return a 200 OK response, then parse the JSON.
    Map<String, dynamic> decoded = convert.jsonDecode(response.body);
    return Tree(decoded);
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    print("statusCode=$response.statusCode");
    throw Exception('Failed to get children');
  }
}

Future<void> start() async {
  String uri = "$baseUrl/start";
  final response = await client.get(uri);
  if (response.statusCode == 200) {
    print("statusCode=$response.statusCode");
  } else {
    print("statusCode=$response.statusCode");
    throw Exception('Failed to get children');
  }
}

Future<void> stop(int id) async {
  String uri = "$baseUrl/stop?$id";
  final response = await client.get(uri);
  if (response.statusCode == 200) {
    print("statusCode=$response.statusCode");
  } else {
    print("statusCode=$response.statusCode");
    throw Exception('Failed to get children');
  }
}

Future<void> addDatos() async {
  String uri = "";
  int temperatura=globals.temperatura;
  int humedad=globals.humedad;
  int personas=globals.personas;
  print("EL ID ES : "+ globals.id.toString());
  if(globals.id==null){
    uri = "$baseUrl/start";
  }else{
    int id=globals.id;
    uri = "$baseUrl/get_ble?$temperatura?$personas?$humedad?$id";
  }
  final response = await client.get(uri);
  print(response.body);
  Map<String, dynamic> decoded = convert.jsonDecode(response.body);
  if(globals.id==null){
    globals.id=decoded["id"];
  }
  globals.media_temp=decoded["media_temp"];
  globals.media_hum=decoded["media_hum"];
  globals.aforo_actual=decoded["aforo_actual"];
  globals.aforo_superado=decoded["aforo_superado"];
  globals.sensacion_texto=decoded["texto_sensacion"];
  if(decoded["sensacion"]==1){
    globals.sensacion=true;
  }else{
    globals.sensacion=false;
  }

  if (response.statusCode == 200) {
    print("statusCode=$response.statusCode");
  } else {
    print("statusCode=$response.statusCode");
    throw Exception('Failed to add Activity');
  }
}

Future<Tree> recibirDatos() async {
  var aforo= globals.max_aforo;
  int id=globals.id;
  String uri = "$baseUrl/actualizar_aforo_maximo?$aforo?$id";
  final response = await client.get(uri);
  // response is NOT a Future because of await but since getTree() is async,
  // execution continues (leaves this function) until response is available,
  // and then we come back here
  if (response.statusCode == 200) {
    print("statusCode=$response.statusCode");
    print(response.body);
    // If the server did return a 200 OK response, then parse the JSON.
    Map<String, dynamic> decoded = convert.jsonDecode(response.body);

    globals.aforo_superado=decoded["aforo_superado"];
    globals.max_aforo=decoded["aforo_maximo"];
    return Tree(decoded);
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    print("statusCode=$response.statusCode");
    throw Exception('Failed to get children');
  }
}

Future<void> getHistoricos_total() async {
  int id=globals.id;
  String uri = "$baseUrl/historicos?$id";

  final response = await client.get(uri);
  // response is NOT a Future because of await but since getTree() is async,
  // execution continues (leaves this function) until response is available,
  // and then we come back here
  if (response.statusCode == 200) {
    print("statusCode=$response.statusCode");
    print(response.body);
    // If the server did return a 200 OK response, then parse the JSON.
    Map<String, dynamic> decoded = convert.jsonDecode(response.body);
    globals.temp_hist_max=decoded["temp_hist_max"];
    globals.aforo_hist_max=decoded["aforo_hist_max"];
    globals.hum_hist_max=decoded["hum_hist_max"];
    globals.temp_hist_min=decoded["temp_hist_min"];
    globals.aforo_hist_min=decoded["aforo_hist_min"];
    globals.hum_hist_min=decoded["hum_hist_min"];
    globals.media_hist_temp=decoded["media_hist_temp"];
    globals.media_hist_aforo=decoded["media_hist_aforo"];
    globals.media_hist_hum=decoded["media_hist_hum"];



  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    print("statusCode=$response.statusCode");
    throw Exception('Failed to get children');
  }
}

Future<void> getHistoricos_dia(variable) async {
  int id=globals.id;
  var xx=variable;
  print("La fecha es "+ xx);
  String uri = "$baseUrl/valoresDia?$id?$xx";

  final response = await client.get(uri);
  Map<String, dynamic> decoded = convert.jsonDecode(response.body);
  globals.temp_hist_max=decoded["temp_hist_max"];
  globals.aforo_hist_max=decoded["aforo_hist_max"];
  globals.hum_hist_max=decoded["hum_hist_max"];
  globals.temp_hist_min=decoded["temp_hist_min"];
  globals.aforo_hist_min=decoded["aforo_hist_min"];
  globals.hum_hist_min=decoded["hum_hist_min"];
  globals.media_hist_temp=decoded["media_hist_temp"];
  globals.media_hist_aforo=decoded["media_hist_aforo"];
  globals.media_hist_hum=decoded["media_hist_hum"];
  // response is NOT a Future because of await but since getTree() is async,
  // execution continues (leaves this function) until response is available,
  // and then we come back here
  if (response.statusCode == 200) {
    print("statusCode=$response.statusCode");
    print(response.body);
    // If the server did return a 200 OK response, then parse the JSON.
    Map<String, dynamic> decoded = convert.jsonDecode(response.body);
    globals.temp_hist_max=decoded["temp_hist_max"];
    globals.aforo_hist_max=decoded["aforo_hist_max"];
    globals.hum_hist_max=decoded["hum_hist_max"];
    globals.temp_hist_min=decoded["temp_hist_min"];
    globals.aforo_hist_min=decoded["aforo_hist_min"];
    globals.hum_hist_min=decoded["hum_hist_min"];
    globals.media_hist_temp=decoded["media_hist_temp"];
    globals.media_hist_aforo=decoded["media_hist_aforo"];
    globals.media_hist_hum=decoded["media_hist_hum"];



  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    print("statusCode=$response.statusCode");
    throw Exception('Failed to get children');
  }
}