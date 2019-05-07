import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

void main() => runApp(MaterialApp(home: HeroAnimation(),));

class PhotoHero extends StatelessWidget{

  final String photo;
  final VoidCallback ontap;
  final double width;

  const PhotoHero({Key key,this.photo,this.ontap,this.width}) : super(key :key);


  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      width: width,
      child: Hero(
          tag: photo,
            child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: ontap,
              child: Image.network(photo,fit: BoxFit.contain,),
          ),
        )
      ),
    );
  }
}

class HeroAnimation extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    timeDilation = 3.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero Animation'),
      ),
      body: Center(
        child: PhotoHero(
          photo: 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1554876703576&di=370fde9abcc30371b51d516c8b3ec823&imgtype=0&src=http%3A%2F%2Fimage.biaobaiju.com%2Fuploads%2F20181004%2F17%2F1538646709-JwVifpkBCe.jpg',
          width: 300.0,
          ontap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Push Controller'),
                ),
                body: Container(
                  color: Colors.lightBlueAccent,
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.topLeft,
                  child: PhotoHero(
                    photo: 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1554876703576&di=370fde9abcc30371b51d516c8b3ec823&imgtype=0&src=http%3A%2F%2Fimage.biaobaiju.com%2Fuploads%2F20181004%2F17%2F1538646709-JwVifpkBCe.jpg',
                    width: 100.0,
                    ontap: (){
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              );
            }));
          },
        ),
      ),
    );
  }
}