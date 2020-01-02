import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
//import 'package:flutter_jsonlist/data.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String url = 'https://facebook.github.io/react-native/movies.json';
  List datas;

  Future<String> getJSONdata() async {
    var response = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    print(response.body);

    setState(() {
      var dataConvertedToJSON = json.decode(response.body);
      datas = dataConvertedToJSON['movies'];
    });

    return 'successful';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Json"),
      ),
      body: ListView.builder(
          itemCount: datas == null ? 0 : datas.length,
          itemBuilder: (BuildContext context, index) {
            return Container(
              child: Center(
                child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[

                        Container(
                          child: Text(
                            'Id:' + datas[index]['id'].toString(),
                            style: TextStyle(fontSize: 20.0),
                          ),
                          padding: const EdgeInsets.all(15.0),
                        ),

                        Container(
                          child: Text(
                            'title: ' + datas[index]['title'],
                            style: TextStyle(fontSize: 20.0),
                          ),
                          padding: const EdgeInsets.all(15.0),
                        ),

                        Container(
                          child: Text(
                            'releaseYear: ' + datas[index]['releaseYear'].toString(),
                            style: TextStyle(fontSize: 20.0),
                          ),
                          padding: const EdgeInsets.all(15.0),
                        )
                      ],
                    )
                ),
              ),
            );
          }),
    );
  }

  @override
  void initState() {
    super.initState();

    this.getJSONdata();
  }
}