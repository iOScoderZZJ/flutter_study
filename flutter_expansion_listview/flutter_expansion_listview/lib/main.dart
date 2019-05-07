import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final CITY_NAMES = {
    '北京' : ['东城区','西城区'],
    '广州' : ['越秀区','粑粑区','A区','剑帝区','红眼区'],
    '上海' : ['长宁区','徐汇区'],
  };

  final title = '列表的展开和收起';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Container(
          child: ListView(
            children: _buildList(),
          ),
        )
      ),
    );
  }

  List<Widget> _buildList()  {
    List<Widget> widgets = [];
    CITY_NAMES.keys.forEach((key){
      widgets.add(_item(key, CITY_NAMES[key]));
    });
    return widgets;
  }

  Widget _item (String city,List<String> subCitys){
    print(subCitys);
    
    return ExpansionTile(
        title: Text(city,
        style: TextStyle(color: Colors.lightGreen,fontSize: 20),
      ),
//      children: _setup(subCitys),
       children: subCitys.map((subCity) => _buildSub(subCity)).toList(),
    );
  }

  //两种方法创建
  List<Widget> _setup(List<String> subCitys){
    List<Widget> widgets = [];
    for(int i = 0;i<subCitys.length;i++){
      widgets.add(_buildSub(subCitys[i]));
    }
    return widgets;
  }

  Widget _buildSub(String subCity){
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(color: Colors.lightBlueAccent),
        child: Text(subCity),
      ),
    );
  }

}


