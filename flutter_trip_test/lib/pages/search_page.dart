import 'package:flutter/material.dart';
import 'package:flutter_trip_test/model/search_model.dart';
import 'package:flutter_trip_test/widget/search_bar.dart';
import 'package:flutter_trip_test/dao/search_dao.dart';

const URL = 'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';
class SearchPage extends StatefulWidget {
  final bool hideLeft;
  final String searchUrl;
  final String keyword;
  final String hint;

  const SearchPage({Key key, this.hideLeft, this.searchUrl = URL, this.keyword, this.hint}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String keyword;
  SearchModel searchModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(),
          Expanded(
            flex: 1,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                  itemCount: searchModel?.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int positon) {
                    return _item(positon);
                  }),
            )
          ),
        ],
      ),
    );
  }

  _appBar() {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(top: 20),
            height: 80,
            decoration: BoxDecoration(
                color: Colors.white
            ),
            child: SearchBar(
              hideLeft: widget.hideLeft,
              defaultText: widget.keyword,
              hint: widget.hint,
              leftButtonClick: () {
                Navigator.pop(context);
              },
              onChanged: _onTextChange,
            ),
          ),
        ),
      ],
    );
  }

  _onTextChange(String text){
    keyword = text;
     if(text.length == 0){
      setState(() {
        searchModel = null;
      });
      return;
    }
    String url = widget.searchUrl + text;
    SearchDao.fetch(url,text).then((SearchModel model){
      ///只有当当前输入的内容和服务端返回的内容一致时才渲染
      if(model.keyword == keyword){
        setState(() {
          searchModel = model;
        });
      }
    }).catchError((e){
      print(e);
    });
  }

  _item(int positon){
    if(searchModel == null || searchModel.data == null) return null;
    SearchItem item = searchModel.data[positon];
    return Text(item.word);
  }
}
