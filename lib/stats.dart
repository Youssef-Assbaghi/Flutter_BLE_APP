import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter_blue_example/datosDia.dart';
import 'package:flutter_blue_example/datosRango.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_blue_example/widgets.dart';
import 'globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter_blue_example/main.dart';
import 'package:flutter_blue_example/globals.dart' as globals;

class stats extends StatefulWidget{
  @override
  _statsState createState() => _statsState();
}

class _statsState extends State<stats>{


  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text(globals.nombre_dispositivo),
        ),
        body: SingleChildScrollView(
            child: Column(
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 00.0, vertical: 10.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 1,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (context) => datosDia(),
                            ),
                          );
                        },
                        child: Text('Datos de un solo día',
                            style: TextStyle(fontSize:35)),
                        textColor: Colors.white,
                        color: Colors.deepOrangeAccent,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      ),
                    ),
                  ),



                  Container(
                      child: Column(children: <Widget>[
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("DATOS HISTÓRICOS",
                                      style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700)),
                                ])),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Mínimas",
                                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
                                ])),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                            child: Row(
                                children: <Widget>[
                                  Text('Temperatura mínima   ' + globals.temp_hist_min.toString() + 'ºC',
                                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                                ])),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                            child: Row(
                                children: <Widget>[
                                  Text('Humedad mínima        ' + globals.hum_hist_min.toString() + '%',
                                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                                ])),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                            child: Row(
                                children: <Widget>[
                                  Text('Aforo mínimo                ' + globals.aforo_hist_min.toString() + ' personas',
                                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                                ])),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Máximas",
                                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
                                ])),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                            child: Row(
                                children: <Widget>[
                                  Text('Temperatura máxima     ' + globals.temp_hist_max.toString() + 'ºC',
                                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                                ])),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                            child: Row(
                                children: <Widget>[
                                  Text('Humedad máxima         ' + globals.hum_hist_max.toString() + '%',
                                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                                ])),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                            child: Row(
                                children: <Widget>[
                                  Text('Aforo máximo                ' + globals.aforo_hist_max.toString() + ' personas',
                                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                                ])),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Medias",
                                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
                                ])),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                            child: Row(
                                children: <Widget>[
                                  Text('Media histórica temperatura ' + globals.media_hist_temp.toString() + 'ºC',
                                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                                ])),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                            child: Row(
                                children: <Widget>[
                                  Text('Media histórica humedad      ' + globals.media_hist_hum.toString() + '%',
                                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                                ])),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                            child: Row(
                                children: <Widget>[
                                  Text('Media histórica aforo             ' + globals.media_hist_aforo.toString(),
                                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                                ])),
                      ])
                  ),
                ]))
    );
  }
}