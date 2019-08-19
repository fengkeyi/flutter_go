import 'package:flutter/material.dart';
import 'package:flutter_go/chapter5/dao/travel_tab_dao.dart';
import 'package:flutter_go/chapter5/model/travel_tab_model.dart';
import 'package:flutter_go/chapter5/pages/navigationbar_travel_tab_page.dart';

class NavigationBarTravelPage extends StatefulWidget {
  @override
  _NavigationBarTravelPageState createState() =>
      _NavigationBarTravelPageState();
}

class _NavigationBarTravelPageState extends State<NavigationBarTravelPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  List<TravelTab> tabs = [];
  TravelTabModel _model;

  @override
  void initState() {
    _controller = TabController(length: tabs.length, vsync: this);
    TravelTabDao.fetch().then((TravelTabModel model) {
      setState(() {
        _controller = TabController(length: model.tabs.length, vsync: this);
        tabs = model.tabs;
        _model = model;
      });
    }).catchError(print);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 30),
            child: TabBar(
                controller: _controller,
                isScrollable: true,
                labelColor: Colors.black,
                labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: Color(0xff2fcfbb),
                    width: 3,
                  ),
                  insets: EdgeInsets.only(bottom: 10),
                ),
                tabs: tabs.map((TravelTab tab) {
                  return Text(tab.labelName);
                }).toList()),
          ),
          Flexible(
              child: TabBarView(
                  controller: _controller,
                  children: tabs.map((TravelTab tab) {
                    return TravelTabPage(
                      travelUrl: _model.url,
                      params: _model.params,
                      groupChannelCode: tab.groupChannelCode,
                    );
                  }).toList())),
        ],
      ),
    );
  }
}
