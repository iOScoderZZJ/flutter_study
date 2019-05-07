import 'package:flutter/material.dart';
import 'package:flutter_trip_test/navigator/tab_navigator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';  //提供序列化相关函数

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabNavigator(),
    );
  }
}

/*
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String showResult = '';

  Future<CommonModel> fetchPost() async{
    final response = await http.get('http://www.devio.org/io/flutter_app/json/test_common_model.json');
//    final result = json.decode(response.body);
    Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
    var result = json.decode(utf8decoder.convert(response.bodyBytes));
    return CommonModel.fromJson(result);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('http'),
        ),
        body: FutureBuilder<CommonModel>(future: fetchPost(),builder: (BuildContext context, AsyncSnapshot<CommonModel> snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
              return Text('input a url to start');

            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(),);

            case ConnectionState.active:
              return Text('');

            case ConnectionState.done:
              if(snapshot.hasError){
                return Text(
                  '${snapshot.error}',
                  style: TextStyle(color: Colors.red),
                );
              }else{
                return Column(children: <Widget>[
                    Text('icon : ${snapshot.data.icon}'),
                    Text('url : ${snapshot.data.url}'),
                    Text('statusBarColor : ${snapshot.data.statusBarColor}'),
                    Text('title : ${snapshot.data.title}'),
                ]);
              }

          }
        }
        ),

      ),
    );
  }
}

//showResult = '请求结果:\nicon:${value.icon} \ntitle:${value.title} \nurl:${value.url} \nstatusBarColor:${value.statusBarColor}\nhideAppBar:${value.hideAppBar}';

class CommonModel{
  final String icon;
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;

  CommonModel({this.icon,this.title,this.url,this.statusBarColor,this.hideAppBar});

  factory CommonModel.fromJson(Map<String,dynamic>json){
    return CommonModel(
      icon: json['icon'],
      title: json['title'],
      url: json['url'],
      statusBarColor: json['statusBarColor'],
      hideAppBar: json['hideAppBar']
    );
  }
}

*/