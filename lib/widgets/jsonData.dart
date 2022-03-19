import 'dart:convert';

import 'package:apicallingproject/widgets/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JsonData extends StatefulWidget {
  const JsonData({Key? key}) : super(key: key);

  @override
  State<JsonData> createState() => _JsonDataState();
}

class _JsonDataState extends State<JsonData> {
  List<Welcome> JsonList = [];
  Future<Object> getData() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        Welcome welcome = Welcome(
            userId: i['userId'],
            id: i['id'],
            title: i['title'],
            body: i['body']);
        JsonList.add(welcome);
      }
      return JsonList;
    } else {
      return CircularProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "JSON Data Load Example",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 2,
        centerTitle: true,
        backgroundColor: Colors.yellow,
      ),
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount: JsonList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading:CircleAvatar(
                      backgroundColor: Colors.amber,
                      child: Center(child: Text(JsonList[index].id.toString(),
                      style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white
                    ),)
                      ),
                    ),
                    title: Text(JsonList[index].title.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black
                    ),
                    ),
                    subtitle:Text(JsonList[index].body.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black
                    ),
                    ),
                  );
                });
          }),
    );
  }
}
