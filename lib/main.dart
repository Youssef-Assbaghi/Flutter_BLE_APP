import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_blue_example/widgets.dart';
import 'globals.dart' as globals;
import 'requests.dart' as requests;

void main() {
  runApp(FlutterBlueApp());
}

class FlutterBlueApp extends StatelessWidget {
  String time = "";
  @override
  void initState() {
    Timer mytimer = Timer.periodic(Duration(seconds: 1), (timer) {
      print("PRINT CADA SEGUNDO");
      //mytimer.cancel() //to terminate this timer
    });
    //super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.lightBlue,
      home: StreamBuilder<BluetoothState>(
          stream: FlutterBlue.instance.state,
          initialData: BluetoothState.unknown,
          builder: (c, snapshot) {
            final state = snapshot.data;
            if (state == BluetoothState.on) {
              return FindDevicesScreen();
            }
            return BluetoothOffScreen(state: state);
          }),
    );
  }
}

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key key, this.state}) : super(key: key);

  final BluetoothState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.bluetooth_disabled,
              size: 200.0,
              color: Colors.white54,
            ),
            Text(
              'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',

            ),
          ],
        ),
      ),
    );
  }
}

class FindDevicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar dispositivos'),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            FlutterBlue.instance.startScan(timeout: Duration(seconds: 4)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder<List<BluetoothDevice>>(
                stream: Stream.periodic(Duration(seconds: 2))
                    .asyncMap((_) => FlutterBlue.instance.connectedDevices),
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data
                      .map((d) => ListTile(
                            title: Text(d.name),
                            subtitle: Text(d.id.toString()),
                            trailing: StreamBuilder<BluetoothDeviceState>(
                              stream: d.state,
                              initialData: BluetoothDeviceState.disconnected,
                              builder: (c, snapshot) {
                                if (snapshot.data ==
                                    BluetoothDeviceState.connected) {
                                  return RaisedButton(
                                    child: Text('ABRIR'),
                                    onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DeviceScreen(device: d))),
                                  );
                                }
                                return Text(snapshot.data.toString());
                              },
                            ),
                          ))
                      .toList(),
                ),
              ),
              StreamBuilder<List<ScanResult>>(
                stream: FlutterBlue.instance.scanResults,
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data
                      .map(
                        (r) => ScanResultTile(
                          result: r,
                          onTap: () => Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            r.device.connect();
                            return DeviceScreen(device: r.device);
                          })),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: FlutterBlue.instance.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data) {
            return FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: () => FlutterBlue.instance.stopScan(),
              backgroundColor: Colors.red,
            );
          } else {
            return FloatingActionButton(
                child: Icon(Icons.search),
                onPressed: () => FlutterBlue.instance
                    .startScan(timeout: Duration(seconds: 4)));
          }
        },
      ),
    );
  }
}

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({Key key, this.device}) : super(key: key);


  final BluetoothDevice device;


  List<int> _getRandomBytes() {
    final math = Random();
    return [
      math.nextInt(88),
      math.nextInt(88),
      math.nextInt(88),
      math.nextInt(88)
    ];
  }
  void conversion(String valores){
    //temperatura
    String temperaturaStr=valores.substring(1,3);
    int temperatura=int.parse(temperaturaStr);

    if(valores[0]=='-')
      temperatura=temperatura*(-1);

    //Personas
    String personasStr=valores.substring(4,5);
    int personas=int.parse(personasStr);

    if(valores[3]=='-')
      personas=personas*(-1);

    //Humedad
    int humedad=int.parse(valores.substring(5,7));

    globals.temperatura=temperatura;
    globals.personas=personas;
    globals.humedad=humedad;
  }


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

  void superado(){
    if (globals.max_aforo<globals.aforo_actual){
      globals.aforo_superado=true;
    } else{
      globals.aforo_superado=false;
    }
  }

  List<Widget> _buildServiceTiles(List<BluetoothService> services)  {
    return services
        .map(
          (s) => ServiceTile(
            service: s,
            characteristicTiles: s.characteristics
                .map(
                  (c) => CharacteristicTile(
                    characteristic: c,
                    onReadPressed: () async {
                      //c.read();
                      List list;

                      //cambiarEstado();
                      print("Entramos al on read pressed");
                      if(globals.contador==0){
                        //globals.conectado=true;
                        globals.contador=1;
                        globals.nombre_dispositivo=device.name;
                        while(globals.conectado==true){
                          globals.datos2=c.read();
                          list= await globals.datos2 ;
                          var character=utf8.decode(list);
                          print(character);
                          this.conversion(character);
                          globals.valores=character;
                          print(globals.temperatura.toString());
                          print(globals.humedad.toString());
                          print(globals.personas.toString());
                          superado();
                          globals.iterable++;
                          requests.addDatos();
                          await Future.delayed(Duration(seconds: 5));
                        }
                      }else{
                        globals.contador=0;
                      }
                    }  ,
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name),
        actions: <Widget>[
          StreamBuilder<BluetoothDeviceState>(
            stream: device.state,
            initialData: BluetoothDeviceState.connecting,

            builder: (c, snapshot) {
              VoidCallback onPressed;
              String text;
              switch (snapshot.data) {
                case BluetoothDeviceState.connected:
                  text = 'DESCONECTAR';
                  globals.existe_conexion=false;
                  globals.contador=0;
                  globals.conectado=false;
                  globals.estado='RECIBIR DATOS';
                  onPressed = () {
                      Navigator.pop(context);
                      device.disconnect();
                  } ;

                  break;
                case BluetoothDeviceState.disconnected:
                  text = 'CONECTAR';
                  globals.existe_conexion=true;
                  onPressed = () async {
                    device.connect();
                    requests.start();
                  };
                  break;
                default:
                  onPressed = null;
                  text = snapshot.data.toString().substring(21).toUpperCase();
                  break;
              }
              return FlatButton(
                  onPressed: onPressed,
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .button
                        .copyWith(color: Colors.white),
                  ));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<BluetoothDeviceState>(
              stream: device.state,
              initialData: BluetoothDeviceState.connecting,
              builder: (c, snapshot) => ListTile(
                leading: (snapshot.data == BluetoothDeviceState.connected)
                    ? Icon(Icons.bluetooth_connected)
                    : Icon(Icons.bluetooth_disabled),
                title: Text(
                    'Device is ${snapshot.data.toString().split('.')[1]}.'),
                subtitle: Text('${device.id}'),
                trailing: StreamBuilder<bool>(
                  stream: device.isDiscoveringServices,
                  initialData: false,
                  builder: (c, snapshot) => IndexedStack(
                    index: snapshot.data ? 1 : 0,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () => device.discoverServices(),

                      ),
                      IconButton(
                        icon: SizedBox(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.grey),
                          ),
                          width: 18.0,
                          height: 18.0,
                        ),
                        onPressed: null,
                      )
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder<List<BluetoothService>>(
              stream: device.services,
              initialData: [],
              builder: (c, snapshot) {
                return Column(
                  children: _buildServiceTiles(snapshot.data),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

}
