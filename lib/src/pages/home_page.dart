
import 'dart:io';

import 'package:band_name/src/models/band_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [ 
    Band(id: '1', name: 'Metalica', votes: 5), 
    Band(id: '2', name: 'Queen', votes: 1), 
    Band(id: '3', name: 'Heroes del Cielo', votes: 2), 
    Band(id: '4', name: 'Bon Jovi', votes: 5), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Band Names', style: TextStyle( color: Colors.black87, ),),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 1,
        ),
        body: Padding(
          padding: EdgeInsets.only( top: 2.0, left: 2.0, right: 2.0, ),
          child: ListView.builder(
            itemCount: bands.length,
            itemBuilder: (BuildContext context, int index) { 
              return _bandTile( bands[index] );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addNewBand,
          child: Icon( Icons.add ),
          elevation: 1,
        ),
      );
  }

  Widget _bandTile( Band band ) {
    return Dismissible(
      key: Key( band.id ),
      direction: DismissDirection.startToEnd,
      onDismissed: ( DismissDirection direction ) {

      },
      background: Container(
        padding: EdgeInsets.only( left: 8.0 ),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text( 'Delete band', style: TextStyle( color: Colors.white ), ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text( band.name.substring( 0, 2 ) ),
          backgroundColor: Colors.blue[100],
        ),
        title: Text( band.name ),
        trailing: Text( '${ band.votes }', style: TextStyle( fontSize: 20.0, ), ),
        onTap: () {},
      ),
    );
  }

  _addNewBand() {

    final textController = TextEditingController();

    if ( Platform.isAndroid ) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text( 'New Band name:' ),
            content: TextField(
              controller: textController,
            ),
            actions: <Widget>[
              MaterialButton(
                onPressed: () => _addBandToList( textController.text ),
                child: Text( 'Add' ),
                elevation: 5,
                textColor: Colors.blue,
              ),
            ],
          );
        },
      );
    }

    showCupertinoDialog(
      context: context,
      builder: ( _ ) {
        return CupertinoAlertDialog(
          title: Text( 'New Band name:' ),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text( 'Add' ),
              isDefaultAction: true,
              onPressed: () => _addBandToList( textController.text ),
            ),
            CupertinoDialogAction(
              child: Text( 'Dismiss' ),
              isDestructiveAction: true,
              onPressed: () => Navigator.pop( context ),
            ),
          ],
        );
      },
    );

  }

  void _addBandToList( String name ) {
    if ( name.length > 1 ) {
      this.bands.add( new Band( id: DateTime.now().toString(), name: name, votes: 0, ) );
      setState(() { });
    }
    Navigator.pop( context );
  }

}


