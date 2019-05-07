
import 'package:flutter/material.dart';
import 'package:flutter_trip_test/model/common_model.dart';
import 'package:flutter_trip_test/model/grid_nav_model.dart';
import 'package:flutter_trip_test/widget/webview.dart';

class GridNav extends StatelessWidget {
  final GridNavModel gridNavModel;

  const GridNav({Key key,@required this.gridNavModel}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }

  _gridNavItems(BuildContext context){
    List<Widget> items = [];
    if(gridNavModel == null) return items;
    if(gridNavModel.hotel != null){
      items.add(_gridNavItem(context, gridNavModel.hotel, true));
    }
    if(gridNavModel.flight != null){
      items.add(_gridNavItem(context, gridNavModel.flight, false));
    }
    if(gridNavModel.travel != null){
      items.add(_gridNavItem(context, gridNavModel.travel, false));
    }
    return items;
  }

  _gridNavItem(BuildContext context,GridNavItem gridNavItemitem,bool first){
    List<Widget> items = [];
    items.add(_mainItem(context, gridNavItemitem.mainItem));
    items.add(_doubleItem(context, gridNavItemitem.item1,gridNavItemitem.item2));
    items.add(_doubleItem(context, gridNavItemitem.item3,gridNavItemitem.item4));

    List<Widget> expanditems = [];
    items.forEach((item){
      expanditems.add(Expanded(child: item,flex: 1,));
    });
    
    Color startColor = Color(int.parse('0xff' + gridNavItemitem.startColor));
    Color endColor = Color(int.parse('0xff' + gridNavItemitem.endColor));
    return Container(
      height: 88,
      margin: first ? null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [startColor,endColor])
      ),
      child: Row(
        children: expanditems
      ),
    );
  }

  _mainItem(BuildContext context,CommonModel model){
    return _wrapGesture(context, model,
      Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Image.network(model.icon,
            fit: BoxFit.contain,
            height: 88,
            width: 121,
            alignment: AlignmentDirectional.bottomEnd,
          ),
          Container(
            margin: EdgeInsets.only(top: 11),
            child: Text(
              model.title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  _doubleItem(BuildContext context,CommonModel topItem,CommonModel bottomItem){
    return Column(
      children: <Widget>[
        Expanded(
          child: _item(context,topItem,true)
        ),
        Expanded(
            child: _item(context,bottomItem,false)
        )
      ],
    );
  }

  _item(BuildContext context,CommonModel item,bool first){
    BorderSide borderSide = BorderSide(color: Colors.white,width: 0.8);
    return FractionallySizedBox(
      ///撑满父布局的宽度
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: borderSide,
            bottom: first ? borderSide : BorderSide.none,
          )
        ),
        child: _wrapGesture(context, item,
          Center(
            child: Text(
              item.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14,color: Colors.white),
            ),
          ),
        )
      ),
    );
  }

  _wrapGesture(BuildContext context,CommonModel model,Widget widge){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => WebView(
              url: model.url,
              statusBarColor: model.statusBarColor,
              hideAppBar: model.hideAppBar,
              title: model.title,
            )
        ));
      },
      child: widge,
    );
  }
}


