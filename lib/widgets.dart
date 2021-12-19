import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_blue_example/stats.dart';
import 'globals.dart' as globals;
import 'dart:async';
import 'requests.dart' as requests;

class ScanResultTile extends StatelessWidget {
  const ScanResultTile({Key key, this.result, this.onTap}) : super(key: key);

  final ScanResult result;
  final VoidCallback onTap;

  Widget _buildTitle(BuildContext context) {
    if (result.device.name.length > 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            result.device.name,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            result.device.id.toString(),
            style: Theme.of(context).textTheme.caption,
          )
        ],
      );
    } else {
      return Text(result.device.id.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: _buildTitle(context),
      leading: Text(result.rssi.toString()),
      trailing: RaisedButton(
        child: Text('CONNECT'),
        color: Colors.black,
        textColor: Colors.white,
        onPressed: (result.advertisementData.connectable) ? onTap : null,
      ),

    );
  }
}

class ServiceTile extends StatelessWidget {
  final BluetoothService service;
  final List<CharacteristicTile> characteristicTiles;
  final BluetoothCharacteristic characteristic;
  final VoidCallback onReadPressed;

  const ServiceTile({
    Key key,
    this.service,
    this.characteristicTiles,
    this.characteristic,
    this.onReadPressed,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (characteristicTiles.length > 0 && (service.uuid.toString().toUpperCase().substring(4, 8))=="1101") {
      final value=globals.datos3;

      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
            //Text("hola"),
            characteristicTiles,
            //Text('Servicios a chequear'),
            //Text('0x${service.uuid.toString().toUpperCase().substring(4, 8)}',)


        //children: characteristicTiles,
      );
    } else {
      return Row(
      );
    }
  }

}

class CharacteristicTile extends StatelessWidget {
  final BluetoothCharacteristic characteristic;
  final VoidCallback onReadPressed;

  const CharacteristicTile(
      {Key key,
      this.characteristic,
      this.onReadPressed,})
      : super(key: key);


  void cambiarEstado(){
    if (globals.estado=='RECIBIR DATOS'){
      globals.estado='PAUSAR';
      globals.conectado=true;
      globals.datos_recibidos='ÚLTIMOS DATOS RECIBIDOS';
      globals.iterable=1;
    }
    else{
      globals.estado='RECIBIR DATOS';
      globals.conectado=false;
      if(globals.iterable>0)
        globals.datos_recibidos='ÚLTIMOS DATOS RECIBIDOS';
      else
        globals.datos_recibidos='AUN NO HAS RECIBIDO DATOS';
    }
  }

  String validateAforo1(String value){
    bool bien=true;
    bool correcto=false;
    if(value.isEmpty){
      bien=false;
      return '*Campo requerido';
    }
    else if (value.length > 6){
      bien=false;
      return 'El aforo máximo es de 999.999';
    }else if (bien==true)
    {
      correcto=validateAforo2(int.parse(value));
      if (correcto==bien){

        try{
          globals.max_aforo=(int.parse(value));
        }on Exception catch(_){
          globals.max_aforo=0;
        }
        if(globals.max_aforo<globals.aforo_actual){
          globals.aforo_superado=true;
        }else{
          globals.aforo_superado=false;
        }
        return null;
      } else {
        return 'Valor no válido';
      }
    }
  }

  bool validateAforo2(int value){
    if(value<0){
      return false;
    } else{
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<List<int>>(
      stream: characteristic.value,
      initialData: characteristic.lastValue,
      builder: (c, snapshot) {
        final value = snapshot.data;
        print("El valor value es " + value.toString());
        globals.datos= snapshot.data;

        if(characteristic.uuid.toString().toUpperCase().substring(4, 8)=="2102"){
          //print("Este es el codigo a enviar cada 3 seugndos");
          //onReadPressed;

          return SingleChildScrollView(
            child:Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 00.0, vertical: 5.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 1,
                    child: RaisedButton(
                      onPressed: (){
                        //cambiarEstado();
                        cambiarEstado();
                        onReadPressed();
                        (context as Element).markNeedsBuild();
                      },
                      child: Text(globals.estado,
                          style: TextStyle(fontSize:35)),
                      textColor: Colors.white,
                      color: globals.conectado
                          ? Colors.red
                          : Colors.green,

                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 00.0, vertical: 10.0),
                  child: ExpansionTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(globals.datos_recibidos,
                            style: TextStyle(fontSize:22, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    children: <Widget>[
                      //ENSEÑAMOS LOS 3 ÚLTIMOS DATOS RECIBIDOS
                      Column(mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:<Widget>[
                            Text('TEMPERATURA:   ' + globals.temperatura.toString() + 'ºC',
                                style: TextStyle(fontSize:25)),
                            Text('HUMEDAD:            ' + globals.humedad.toString() + '%',
                                style: TextStyle(fontSize:25)),
                            Text('PERSONAS:           ' + globals.personas.toString(),
                                style: TextStyle(fontSize:25)),
                          ]
                      ),
                    ],
                  ),
                ),
                if(globals.iterable>0)
                  Container(
                      child: Column(children: <Widget>[
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                            child: Row(
                                children: <Widget>[
                                  Text('SENSACIÓN TÉRMICA              ' + globals.sensacion_texto,
                                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500,
                                        color: globals.sensacion
                                            ? Colors.red
                                            : Colors.blue,)),
                                ])),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("MEDIAS",
                                      style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700)),
                                ])),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                            child: Row(
                                children: <Widget>[
                                  Text('MEDIA TEMPERATURA      ' + globals.media_temp.toString() + 'ºC',
                                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                                ])),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                            child: Row(
                                children: <Widget>[
                                  Text('MEDIA HUMEDAD                ' + globals.media_hum.toString() + '%',
                                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                                ])),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                            child: Row(
                                children: <Widget>[

                                  Text('AFORO ACTUAL                   ' + globals.aforo_actual.toString(),
                                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500,
                                        color: globals.aforo_superado
                                            ? Colors.red
                                            : Colors.green,)),
                                ])),
                        Padding( padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                            child: Row(
                                children:[
                                  Text('AFORO MAXIMO                  ',
                                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500,)),
                                  Expanded(
                                    child: TextField(
                                      onChanged: (text) {
                                        print("First text field: $text");
                                        validateAforo1(text);
                                        requests.recibirDatos();
                                        //globals.max_aforo=(int.parse(text));
                                        (context as Element).markNeedsBuild();

                                      },
                                      //controller: aforo_maximo,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Aforo Máximo',),
                                      keyboardType: TextInputType.number,
                                      //validator: validateAforo1,
                                    ),
                                  ),
                                ])),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 00.0, vertical: 24.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width * 1,
                            child: RaisedButton(
                              onPressed: () {
                                requests.getHistoricos_total();
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (context) => stats(),
                                  ),
                                );
                              },
                              child: Text('Estadísticas históricas',
                                  style: TextStyle(fontSize:35)),
                              textColor: Colors.white,
                              color: Colors.deepOrangeAccent,
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            ),
                          ),
                        ),
                      ])
                  ),
              ],
            ),
            //BOTON COMENZAR

          );
        }else{
        return Row();
        }
      },
    );
  }




}


class AdapterStateTile extends StatelessWidget {
  const AdapterStateTile({Key key, @required this.state}) : super(key: key);

  final BluetoothState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      child: ListTile(
        title: Text(
          'Bluetooth adapter is ${state.toString().substring(15)}',

        ),
        trailing: Icon(
          Icons.error,

        ),
      ),
    );
  }
}
