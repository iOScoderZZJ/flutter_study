import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip_test/dao/home_dao.dart';
import 'package:flutter_trip_test/model/common_model.dart';
import 'package:flutter_trip_test/model/grid_nav_model.dart';
import 'dart:convert';

import 'package:flutter_trip_test/model/home_model.dart';
import 'package:flutter_trip_test/widget/grid_nav.dart';
import 'package:flutter_trip_test/widget/local_nav.dart';

const APPBAR_SCROLL_OFFSET = 100;
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List _imageUrls = [
    'http://www.devio.org/io/flutter_app/img/banner/100h10000000q7ght9352.jpg',
    'https://dimg04.c-ctrip.com/images/300h0u000000j05rnD96B_C_500_280.jpg',
    'http://pages.ctrip.com/hotel/201811/jdsc_640es_tab1.jpg',
    'https://dimg03.c-ctrip.com/images/fd/tg/g1/M03/7E/19/CghzfVWw6OaACaJXABqNWv6ecpw824_C_500_280_Q90.jpg'
  ];
/*
  {
  "icon": "http://www.devio.org/io/flutter_app/img/banner/100h10000000q7ght9352.jpg",
  "url": "https://gs.ctrip.com/html5/you/travels/1422/3771516.html?from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F"
  },
  {
  "icon": "https://dimg04.c-ctrip.com/images/300h0u000000j05rnD96B_C_500_280.jpg",
  "url": "https://m.ctrip.com/webapp/vacations/tour/detail?productid=3168213&departcityid=2&salecityid=2&from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F"
  },
  {
  "icon": "http://pages.ctrip.com/hotel/201811/jdsc_640es_tab1.jpg",
  "url": "https://m.ctrip.com/events/jiudianshangchenghuodong.html?disable_webview_cache_key=1"
  },
  {
  "icon": "https://dimg03.c-ctrip.com/images/fd/tg/g1/M03/7E/19/CghzfVWw6OaACaJXABqNWv6ecpw824_C_500_280_Q90.jpg",
  "url": "https://m.ctrip.com/webapp/vacations/tour/detail?productid=53720&departcityid=2&salecityid=2&from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F"
  }
*/

  double appbarAlpha = 0;

  _onScroll(offset){
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0){
      alpha = 0;
    }else if(alpha > 1){
      alpha = 1;
    }
    setState(() {
      appbarAlpha = alpha;
    });
  }


  String resultString = '';
  List<CommonModel> localNavList = [];
  GridNavModel gridNavModel;

  @override
  void initState() {
    super.initState();
    loadData();
  }


  loadData() async{
    try{
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
        gridNavModel = model.gridNav;
      });
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          //默认ListView上面会有一个空白padding,可以用MediaQuery包裹并且移除掉
          MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: NotificationListener(
                onNotification: (scrollNotification){
                  //判断是 ScrollUpdateNotification类型的通知 && 深度==0
                  //注:scrollNotification也监听了Swiper的滚动,所以要过滤掉,通过depth
                  if(scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0){
                    //列表滚动的时候,拿到了偏移量
                    _onScroll(scrollNotification.metrics.pixels);
                  }
                },
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 160,
                      child: Swiper(
                        itemCount: _imageUrls.length,
                        autoplay: true,
                        duration:1000,
                        itemBuilder: (BuildContext context,int index){
                          return Image.network(
                            _imageUrls[index],
                            fit: BoxFit.fill,
                          );
                        },
                        pagination: SwiperPagination(
                            builder: DotSwiperPaginationBuilder(
                                activeColor: Colors.lightGreenAccent
                            )
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                        child: LocalNav(localNavList: localNavList),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                      child: GridNav(gridNavModel: gridNavModel,),
                    ),
                    Container(
                      height: 800,
                      child: ListTile(title: Text(resultString),),
                    )
                  ],
                ),
              )
          ),
          //flutter中不透明度可以用Opacity包裹
          Opacity(
            opacity: appbarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('首页',style: TextStyle(fontSize: 20),),
                ),
              ),
            )
          )
        ],
      )
    );
  }
}

/*

* */