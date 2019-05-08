
import 'package:flutter/material.dart';
///家在进度条
class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool cover;  ///是否覆盖整个界面 即是否在child之上

  const LoadingContainer(
      {Key key,
      @required this.isLoading,
      this.cover = false,
      @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!cover) {
      if (isLoading) {
        return _loadingView;
      }else{
        return child;
      }
    } else {
      return Stack(
        children: <Widget>[child, isLoading ? _loadingView : null],
      );
    }
  }

  Widget get _loadingView{
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

