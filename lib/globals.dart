library my_proj.globals;
import 'package:flutter_blue/flutter_blue.dart';


List<int> datos;
List<String> datos3;
Future<List<int>> datos2;
Future<List<BluetoothService>> servicio;


String temperaturaStr;
String humedadStr;
String perosnasStr;


int temperatura,personas,humedad;


bool aforo_superado=false;
bool conexion=false;



bool conectado=false;
int contador=0;

