import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'package:flutter_blue_example/globals.dart' as globals;
import 'requests.dart' as requests;

class datosDia extends StatefulWidget{
  @override
  _datosDiaState createState() => _datosDiaState();
}

class _datosDiaState extends State<datosDia>{

  TextEditingController dateinput = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text(globals.nombre_dispositivo),
        ),
        body: SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  Container(
                    child: Column(children: <Widget>[
                      TextField(
                        controller: dateinput, //editing controller of this TextField
                        decoration: InputDecoration(
                            icon: Icon(Icons.calendar_today), //icon of text field
                            labelText: "Enter Date" //label text of field
                        ),
                        readOnly: true,  //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime pickedDate = await showDatePicker(
                              context: context, initialDate: DateTime.now(),
                              firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101)
                          );
                          if(pickedDate != null ){
                            String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                            setState(() {
                              dateinput.text = formattedDate;
                              globals.datosDia_select=true;
                              requests.getHistoricos_dia(formattedDate);
                            });
                          }else{
                            globals.datosDia_select=false;
                          }
                        },
                      ),
                      if (globals.datosDia_select==false)
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Selecciona la fecha que desees",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                                ])),
                      if (globals.datosDia_select==true)
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
                                      Text('Temperatura máxima    ' + globals.temp_hist_max.toString() + 'ºC',
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
                          ]),),
                    ]),),
                ]))
    );
  }
}