import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

void main() async {
  Map _data = await getQuacks();

  List _features = _data['Bangladesh'];

  runApp(new MaterialApp(
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "BD Corona Virus Update",
          style: new TextStyle(fontSize: 20.0, color: Colors.grey[200]),
        ),
        backgroundColor: Colors.red,
      ),
      body: new Center(
              child: new ListView.builder(
                // reverse: true,
                  padding: EdgeInsets.all(5.0),
                  itemCount: _features.length,
                  itemBuilder: (BuildContext context, int position) {
                    return Card(
                      child: ListTile(
                        title: new Text("${_features[(_features.length - 1) - position]['date']},",),
                        subtitle: new Text("""
                  Confirmed: ${_features[(_features.length - 1) - position]['confirmed']}
                  death: ${_features[(_features.length - 1) - position]['deaths']} 
                  recoverd: ${_features[(_features.length - 1) - position]['recovered']}
                """),
                        leading: new CircleAvatar(
                          backgroundColor: Colors.greenAccent,
                          child: new Text("${_features[(_features.length - 1) - position]['confirmed']}",
                          style: new TextStyle(
                            color: Colors.black
                          ),
                          ),
                        ),
                        onTap: (){_showAlertDetails(context, "${_features[(_features.length - 1) - position]['confirmed'] - _features[(_features.length - 2) - position ]['confirmed']}","${_features[(_features.length - 1) - position]['deaths'] - _features[(_features.length - 2) - position ]['deaths']}" );}
                      ),

                    );

                  })
          ),
    ),
  ));
}

Future<Map> getQuacks() async {
  String api = await "https://pomber.github.io/covid19/timeseries.json";

  http.Response response = await http.get(api);
  return json.decode(response.body);
}


void _showAlertDetails(BuildContext context, String msg, String msg1){
    var alert = new AlertDialog(
      title: new Text('Chart'),
      content: new Text(
          """New Confirm Cases: $msg
             New Death: $msg1
          """),
      actions: <Widget>[
        new FlatButton(onPressed: (){Navigator.pop(context);}, child: new Text('ok'))
      ],
    );
    showDialog(context: context,child: alert);
  }