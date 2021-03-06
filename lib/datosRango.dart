import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'package:flutter_blue_example/globals.dart' as globals;
import 'requests.dart' as requests;
class datosRango extends StatefulWidget{
  @override
  _datosRangoState createState() => _datosRangoState();
}

class _datosRangoState extends State<datosRango>{

  TextEditingController dateinput1 = TextEditingController();
  TextEditingController dateinput2 = TextEditingController();

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
                        controller: dateinput1, //editing controller of this TextField
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
                              dateinput1.text = formattedDate;
                              globals.datosRango1_select=true;

                            });
                          }else{
                            globals.datosRango1_select=false;
                          }
                          dos_fechas();
                        },
                      ),
                      TextField(
                        controller: dateinput2, //editing controller of this TextField
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
                              dateinput2.text = formattedDate;
                              globals.datosRango2_select=true;
                            });
                          }else{
                            globals.datosRango2_select=false;
                          }
                          dos_fechas();
                        },
                      ),

                      if (globals.datosRango_select==false)
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Selecciona las fechas que desees",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                                ])),
                      if (globals.datosRango_select==true)
                        Container(
                          child: Column(children: <Widget>[
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("DATOS HIST??RICOS",
                                          style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700)),
                                    ])),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("M??nimas",
                                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
                                    ])),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                                child: Row(
                                    children: <Widget>[
                                      Text('Temperatura m??nima   ' + globals.temp_hist_min.toString() + '??C',
                                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                                    ])),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                                child: Row(
                                    children: <Widget>[
                                      Text('Humedad m??nima        ' + globals.hum_hist_min.toString() + '%',
                                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                                    ])),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                                child: Row(
                                    children: <Widget>[
                                      Text('Aforo m??nimo                ' + globals.aforo_hist_min.toString() + ' personas',
                                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                                    ])),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("M??ximas",
                                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
                                    ])),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                                child: Row(
                                    children: <Widget>[
                                      Text('Temperatura m??xima    ' + globals.temp_hist_max.toString() + '??C',
                                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                                    ])),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                                child: Row(
                                    children: <Widget>[
                                      Text('Humedad m??xima         ' + globals.hum_hist_max.toString() + '%',
                                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                                    ])),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                                child: Row(
                                    children: <Widget>[
                                      Text('Aforo m??ximo                ' + globals.aforo_hist_max.toString() + ' personas',
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
                                      Text('Media hist??rica temperatura ' + globals.media_hist_temp.toString() + '??C',
                                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                                    ])),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                                child: Row(
                                    children: <Widget>[
                                      Text('Media hist??rica humedad      ' + globals.media_hist_hum.toString() + '%',
                                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                                    ])),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                                child: Row(
                                    children: <Widget>[
                                      Text('Media hist??rica aforo             ' + globals.media_hist_aforo.toString(),
                                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                                    ])),
                          ]),),
                    ]),),
                ]))
    );
  }

  void dos_fechas(){
    if(globals.datosRango1_select==true && globals.datosRango2_select==true){
      globals.datosRango_select=true;
    }
    else{
      globals.datosRango_select=false;
    }
  }

}