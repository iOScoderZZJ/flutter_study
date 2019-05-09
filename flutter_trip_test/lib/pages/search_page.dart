import 'package:flutter/material.dart';
import 'package:flutter_trip_test/model/search_model.dart';
import 'package:flutter_trip_test/widget/search_bar.dart';
import 'package:flutter_trip_test/dao/search_dao.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String showText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          SearchBar(
            hideLeft: true,
            defaultText: 'haha',
            hint: '123',
            leftButtonClick: (){
              Navigator.pop(context);
            },
            onChanged: _onTextChange,
          ),
          InkWell(
            onTap: (){
              SearchDao.fetch('https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=长城')
                  .then((SearchModel value){
                    setState(() {
                      showText = value.data[0].url;
                    });
              });
            },
            child: Text('请求数据'),
          ),
          Text(showText)
        ],
      ),
    );
  }

  _onTextChange(text){

  }

}
