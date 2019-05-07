import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'dart:math' as math;

void main() => runApp(MaterialApp(home: RedialExpansionDemo(),));

class Photo extends StatelessWidget{

  final String photo;
  final VoidCallback ontap;
  final double width;

  const Photo({Key key,this.photo,this.ontap,this.width}) : super(key :key);


  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Theme.of(context).primaryColor.withOpacity(0.25),
      child: InkWell(
        onTap: ontap,
        child: LayoutBuilder(builder: (context,size){
          Image.network(photo,fit: BoxFit.contain,);
        }),
      ),
    );
  }
}

class RadialExpansion extends StatelessWidget{
  final double maxRadius;
  final clipRectSize;
  final Widget child;


  RadialExpansion({
    Key key,
    this.maxRadius,
    this.child}) : clipRectSize = 2.0 * (maxRadius / math.sqrt2),
        super(key: key);


  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Center(
        child: SizedBox(
          width: clipRectSize,
          height: clipRectSize,
          child: ClipRect(
            child: child,
          ),
        ),
      ),
    );
  }
}

class RedialExpansionDemo extends StatelessWidget{
  static const double kMinRedius = 32.0;
  static const double kMaxRedius = 128.0;
  static const opacityCurve = const Interval(0.0, 0.75,curve: Curves.fastOutSlowIn);

  static RectTween _creatRectTween(Rect begin,Rect end){
    return MaterialRectArcTween(begin: begin,end: end);
  }

  Widget _buildHero(BuildContext context,String imageName,String description){
    return Container(
      width: kMinRedius * 2,
      height: kMinRedius * 2,
      child: Hero(
          createRectTween: _creatRectTween,
          tag: imageName, child:
      RadialExpansion(maxRadius: kMaxRedius,
      child: Photo(
        photo: imageName,
        ontap: ()
    {
      Navigator.of(context).push(
          PageRouteBuilder<void>(
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    return Opacity(opacity:
                    opacityCurve.transform(animation.value),
                      child: _buildPage(context, imageName, description),
                    );
                  },
                );
              }));
         }),

      ),
      ));
  }

  static Widget _buildPage(BuildContext context,String imageName,String description){
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Card(
          elevation: 8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: kMaxRedius * 2,
                height: kMaxRedius * 2,
                child: Hero(createRectTween : _creatRectTween,tag: imageName,
                    child: RadialExpansion(
                      maxRadius: kMaxRedius,
                      child: Photo(
                        photo: imageName,
                        ontap: (){
                          Navigator.of(context).pop();
                        },
                      ),
                    )),
              ),
              Text(
                description,
                style: TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 3.0,
              ),
              const SizedBox(height: 16,)
            ],
          ),
        ),
      ),

    );
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero Animation 2'),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        alignment: FractionalOffset.bottomLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildHero(context, 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1554876703576&di=370fde9abcc30371b51d516c8b3ec823&imgtype=0&src=http%3A%2F%2Fimage.biaobaiju.com%2Fuploads%2F20181004%2F17%2F1538646709-JwVifpkBCe.jpg', '第一张'),
            _buildHero(context, 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1554876703576&di=db8466423ec6222a92d8e39cdb6d7f7f&imgtype=0&src=http%3A%2F%2Fwww.jituwang.com%2Fuploads%2Fallimg%2F140703%2F259388-140F30U43886.jpg', '第二张'),
            _buildHero(context, 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1554876703576&di=ccda0cb8b7b4db00dea25939b2f4008c&imgtype=0&src=http%3A%2F%2Fimg18.3lian.com%2Fd%2Ffile%2F201711%2F11%2Faff81832b1472c2a44f2c703a4c0236c.png', '第三张')
          ],
        ),
      ),
    );
  }
}

