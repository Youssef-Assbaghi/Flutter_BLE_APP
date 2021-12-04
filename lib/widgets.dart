import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'globals.dart' as globals;
import 'dart:async';

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
      this.onReadPressed})
      : super(key: key);

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

          return Padding(
            //BOTON COMENZAR
            padding: EdgeInsets.symmetric(
                horizontal: 00.0, vertical: 24.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 1,
              child: RaisedButton(
                onPressed: (){
                  onReadPressed();
                  },
                child: Text("Actualziar datos",
                    style: TextStyle(fontSize:35)),
                textColor: Colors.white,
                color: Colors.green,

                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              ),
            ),
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
