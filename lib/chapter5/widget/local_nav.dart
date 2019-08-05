import 'package:flutter/material.dart';
import 'package:flutter_go/chapter5/model/common_model.dart';

class LocalNavWidget extends StatelessWidget {
  final List<CommonModel> localNavList;

  const LocalNavWidget({Key key, @required this.localNavList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(),
      ),
    );
  }

  Widget _items() {
    if (localNavList == null) return null;
    List<Widget> widgets = [];
    localNavList.forEach((model) {
      widgets.add(_item(model));
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widgets,
    );
  }

  Widget _item(CommonModel model) {
    return GestureDetector(
      onTap: () {

      },
      child: Column(children: [
        Image.network(
          model.icon,
          width: 32,
          height: 32,
        ),
        Text(
          model.title,
          style: TextStyle(fontSize: 14),
        ),
      ]),
    );
  }
}
