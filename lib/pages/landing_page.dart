import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:io';

class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  _LandingPage createState() => new _LandingPage();
}

class _LandingPage extends State<LandingPage> {
  var _driveDuration = '...';

  _getDriveDuration() async {
    var apiKey = 'AIzaSyD-ypp-3Uyq3BRDgJrwXnFD4u7FZrkE3Fc';
    var url = 'https://maps.googleapis.com/maps/api/directions/json?origin=140%20BPW%20Club%20Rd,%20Carrboro%20,NC&destination=Raleigh,NC&key=' + apiKey;
    var httpClient = new HttpClient();

    String result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var json = await response.transform(UTF8.decoder).join();
        var data = JSON.decode(json);
        result = data['routes'][0]['legs'][0]['duration']['text'];
      } else {
        result =
            'Error getting drive estimate:\nHttp status ${response.statusCode}';
      }
    } catch (exception) {
      result = 'Failed getting drive estimate';
    }

    // If the widget was removed from the tree while the message was in flight,
    // we want to discard the reply rather than calling setState to update our
    // non-existent appearance.
    if (!mounted) return;

    setState(() {
      _driveDuration = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    var spacer = new SizedBox(height: 32.0);

    return new Scaffold(
      backgroundColor: Colors.blueAccent,
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'Today I will make it to work in:',
              style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),),
            new Text(
              '$_driveDuration',
              style: new TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic, color: Colors.white),),
            spacer,
            new RaisedButton(
              color: Colors.white,
              onPressed: _getDriveDuration,
              child: new Text('Get Travel time'),
            ),
          ],
        ),
      ),
    );
  }
}