import 'package:flutter/material.dart';
import 'package:flutter_go/chapter5/model/common_model.dart';
import 'package:flutter_go/chapter5/model/salesbox_model.dart';
import 'package:flutter_go/chapter5/widget/webview.dart';

class SalesBoxView extends StatelessWidget {
  final SalesBoxModel salesBoxModel;

  const SalesBoxView({Key key, this.salesBoxModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: _items(context),
      ),
    );
  }

  List<Widget> _items(BuildContext context) {
    if(salesBoxModel==null) return null;
    List<Widget> items = [];
    items.add(_buildSalesBoxbar(context));
    items.add(_buildDoubleItems(
        context, salesBoxModel.bigCard1, salesBoxModel.bigCard2, true, false));
    items.add(_buildDoubleItems(context, salesBoxModel.smallCard1,
        salesBoxModel.smallCard2, false, false));
    items.add(_buildDoubleItems(context, salesBoxModel.smallCard3,
        salesBoxModel.smallCard4, false, true));
    return items;
  }

  Widget _buildSalesBoxbar(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Color(0xfff2f2f2))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.network(
            salesBoxModel.icon,
            height: 15,
            fit: BoxFit.fill,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
            margin: EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xffff4e63),
                Color(0xffff6cc9),
              ], begin: Alignment.centerLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(12),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return WebView(
                    url: salesBoxModel.moreUrl,
                    title: '更多活动',
                  );
                }));
              },
              child: Text(
                '获取更多福利 >',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoubleItems(BuildContext context, CommonModel leftModel,
      CommonModel rightModel, bool isBig, bool isLast) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildItem(context, leftModel, isBig, true, isLast),
        _buildItem(context, rightModel, isBig, false, isLast),
      ],
    );
  }

  Widget _buildItem(BuildContext context, CommonModel model, bool isBig,
      bool isLeft, bool isLast) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WebView(
            url: model.url,
            title: model.title,
            hideAppBar: model.hideAppBar,
            statusBarColor: model.statusBarColor,
          );
        }));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: isLeft
                ? BorderSide(
                    width: 0.8,
                    color: Color(0xfff2f2f2),
                  )
                : BorderSide.none,
            bottom: isLast
                ? BorderSide.none
                : BorderSide(
                    width: 0.8,
                    color: Color(0xfff2f2f2),
                  ),
          ),
        ),
        child: Image.network(
          model.icon,
          fit: BoxFit.fill,
          height: isBig ? 129 : 80,
          width: MediaQuery.of(context).size.width / 2 - 10,
        ),
      ),
    );
  }
}
