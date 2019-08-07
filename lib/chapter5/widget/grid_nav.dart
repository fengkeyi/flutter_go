import 'package:flutter/material.dart';
import 'package:flutter_go/chapter5/model/common_model.dart';
import 'package:flutter_go/chapter5/model/grid_item.dart';
import 'package:flutter_go/chapter5/model/grid_nav_model.dart';
import 'package:flutter_go/chapter5/widget/webview.dart';

class GridNavView extends StatelessWidget {
  final GridNavModel gridNavModel;

  const GridNavView({Key key, @required this.gridNavModel}) : super(key: key);

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

  List<Widget> _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    if (gridNavModel == null) return items;
    if (gridNavModel.hotel != null) {
      items.add(_gridNavItem(context, gridNavModel.hotel, true));
    }
    if (gridNavModel.flight != null) {
      items.add(_gridNavItem(context, gridNavModel.flight, false));
    }
    if (gridNavModel.travel != null) {
      items.add(_gridNavItem(context, gridNavModel.travel, false));
    }
    return items;
  }

  _gridNavItem(BuildContext context, GridItem gridItem, bool isFirst) {
    List<Widget> items = [];
    items.add(_mainItem(context, gridItem.mainItem));
    items.add(_doubleItem(context, gridItem.item1, gridItem.item3));
    items.add(_doubleItem(context, gridItem.item2, gridItem.item4));

    List<Widget> expandItems = [];
    items.forEach((widget) {
      expandItems.add(
        Expanded(flex: 1, child: widget),
      );
    });

    Color startColor = Color(int.parse('0xff${gridItem.startColor}'));
    Color endColor = Color(int.parse('0xff${gridItem.endColor}'));

    return Container(
      height: 88,
      margin: isFirst ? EdgeInsets.zero : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [startColor, endColor],
        ),
      ),
      child: Row(
        children: expandItems,
      ),
    );
  }

  _mainItem(BuildContext context, CommonModel model) {
    return _wrapGesture(
      context,
      model,
      Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Image.network(
            model.icon,
            width: 121,
            height: 88,
            alignment: AlignmentDirectional.bottomEnd,
            fit: BoxFit.contain,
          ),
          Container(
            margin: EdgeInsets.only(top: 11),
            child: Text(
              model.title,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  _doubleItem(
      BuildContext context, CommonModel topModel, CommonModel bottomModel) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _item(context, topModel, true),
        ),
        Expanded(
          child: _item(context, bottomModel, false),
        ),
      ],
    );
  }

  _item(BuildContext context, CommonModel model, bool isFirst) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: borderSide,
            bottom: isFirst ? borderSide : BorderSide.none,
          ),
        ),
        child: _wrapGesture(
          context,
          model,
          Center(
            child: Text(
              model.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  _wrapGesture(BuildContext context, CommonModel model, Widget widget) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WebView(
            url: model.url,
            title: model.title,
            statusBarColor: model.statusBarColor,
            hideAppBar: model.hideAppBar,
          );
        }));
      },
      child: widget,
    );
  }
}
