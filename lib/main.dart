import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.red),
        home: MyApp(),
      ),
    );

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String url = 'https://unsplash.com/napi/photos/mX_jnMXOXrg/related';
  List data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});


    setState(() {
      var convertedData = jsonDecode(response.body);
      data = convertedData['results'];
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo App'),
      ),
      body: ListView.builder(
          itemCount: data==null? 0:data.length,
          itemBuilder: (context, index) {
            return Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image.network(data[index]['urls']['small']),
                            Text("Name : "+data[index]['user']['name'],style: TextStyle(
                              fontSize: 17.0,
                            ),),
                            Text("Likes : "+data[index]['likes'].toString(),style: TextStyle(
                              fontSize: 15.0,),
                            ),
                          ],
                        ),
                        
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
