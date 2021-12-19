library my_proj.globals;
import 'package:flutter_blue/flutter_blue.dart';


List<int> datos;
List<String> datos3;
Future<List<int>> datos2;
Future<List<BluetoothService>> servicio;

String nombre_dispositivo="";
String temperaturaStr;
String humedadStr;
String perosnasStr;
String valores;

int id;
int temperatura=0;
int personas=0;
int humedad = 0;


bool aforo_superado=true;
int max_aforo=2;


bool conexion=false;
String estado='RECIBIR DATOS';
String datos_recibidos='AUN NO HAS RECIBIDO DATOS';

int cant=0;
int cant1=0;
int cant2=5;
int iterable=0;

double media_temp=10.6;
double aforo_actual=9;
double media_hum=15.5;



bool conectado=false; //Recibiendo datos
bool existe_conexion=false;
int contador=0;


bool sensacion=false;

int temp_hist_max=100;
int aforo_hist_max=179;
int hum_hist_max=97;
int temp_hist_min=-24;
int aforo_hist_min=13;
int hum_hist_min=6;
double media_hist_temp=22.6;
double media_hist_aforo=96;
double media_hist_hum=46.3;

bool datosDia_select=false;

bool datosRango1_select=false;
bool datosRango2_select=false;
bool datosRango_select=false;

String sensacion_texto ="Frio";