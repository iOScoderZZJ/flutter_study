import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip_test/dao/home_dao.dart';
import 'package:flutter_trip_test/model/common_model.dart';
import 'package:flutter_trip_test/model/grid_nav_model.dart';
import 'dart:convert';

import 'package:flutter_trip_test/model/home_model.dart';
import 'package:flutter_trip_test/model/sales_box_model.dart';
import 'package:flutter_trip_test/widget/grid_nav.dart';
import 'package:flutter_trip_test/widget/local_nav.dart';
import 'package:flutter_trip_test/widget/seles_box.dart';
import 'package:flutter_trip_test/widget/sub_nav.dart';
import 'package:flutter_trip_test/widget/loading_Container.dart';
import 'package:flutter_trip_test/widget/webview.dart';

const APPBAR_SCROLL_OFFSET = 100;
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  GridNavModel gridNavModel;
  List<CommonModel> subNavList = [];
  SalesBoxModel salesBoxModel;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }


  Future<Null> _handleRefresh() async{
    try{
      HomeModel model = await HomeDao.fetch();
      setState(() {
        bannerList = model.bannerList;
        localNavList = model.localNavList;
        gridNavModel = model.gridNav;
        subNavList = model.subNavList;
        salesBoxModel = model.salesBox;
        _loading = false;
      });
    }catch(e){
      print(e);
      setState(() {
        _loading = false;
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70,
        body: LoadingContainer(
            isLoading: _loading,
            child: Stack(
              children: <Widget>[
                //默认ListView上面会有一个空白padding,可以用MediaQuery包裹并且移除掉
                MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: RefreshIndicator(
                        onRefresh: _handleRefresh,
                        child: NotificationListener(
                          onNotification: (scrollNotification) {
                            //判断是 ScrollUpdateNotification类型的通知 && 深度==0
                            //注:scrollNotification也监听了Swiper的滚动,所以要过滤掉,通过depth
                            if (scrollNotification is ScrollUpdateNotification &&
                                scrollNotification.depth == 0) {
                              //列表滚动的时候,拿到了偏移量
                              _onScroll(scrollNotification.metrics.pixels);
                            }
                          },
                          child: _listView,
                        )
                    )
                ),
                _appBar
              ],
            )
        )
    );
  }

  ///导航栏
  Widget get _appBar{
    //flutter中不透明度可以用Opacity包裹
    return Opacity(
        opacity: appbarAlpha,
        child: Container(
          height: 80,
          decoration: BoxDecoration(color: Colors.red),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text('首页', style: TextStyle(fontSize: 20),),
            ),
          ),
        )
    );
  }

  ///listView
  Widget get _listView{
    return ListView(
      children: <Widget>[
        _banner,
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(localNavList: localNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: GridNav(gridNavModel: gridNavModel,),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
          child: SubNav(subNavList: subNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SalesBox(salesBox: salesBoxModel),
        ),
      ],
    );
  }

  ///轮播图
  Widget get _banner {
    return Container(
      height: 160,
      child: Swiper(
        itemCount: bannerList.length,
        autoplay: true,
        duration: 1000,
        onTap: (index) {
          CommonModel model = bannerList[index];
          Navigator.push(context, MaterialPageRoute(
              builder: (context) =>
                  WebView(
                    url: model.url,
                    statusBarColor: model.statusBarColor,
                    hideAppBar: model.hideAppBar,
                    title: model.title,
                  )
          ));
        },
        itemBuilder: (BuildContext context,
            int index) {
          return Image.network(
            bannerList[index].icon,
            fit: BoxFit.fill,
          );
        },
        pagination: SwiperPagination(
            builder: DotSwiperPaginationBuilder(
                activeColor: Colors.lightGreenAccent
            )
        ),
      ),
    );
  }
}

