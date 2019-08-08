import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isCover;
  final bool isLoading;

  const LoadingContainer(
      {Key key,
      this.isCover = false,
      @required this.isLoading,
      @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !isCover
        ? !isLoading ? child : _loadingView
        : Stack(
            children: <Widget>[child, isLoading ? _loadingView : Container()],
          );
  }

  Widget get _loadingView {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.yellow,
        strokeWidth: 2,
      ),
    );
  }
}
