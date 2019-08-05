import 'package:flutter/material.dart';
import 'package:flutter_go/chapter5/dao/home_dao.dart';
import 'package:flutter_go/chapter5/model/home_model.dart';
import 'package:flutter_go/chapter5/widget/local_nav.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class NavigationBarHomePage extends StatefulWidget {
  @override
  _NavigationBarHomePageState createState() => _NavigationBarHomePageState();
}

class _NavigationBarHomePageState extends State<NavigationBarHomePage> {
  List<String> _images = [
    "https://img04.sogoucdn.com/app/a/100520093/c583df4cdb382aff-50aefb79b44e9cc2-dc8275ee979b40e648fecb4d6d3ffcbb.jpg",
    "https://img04.sogoucdn.com/app/a/100520093/e7d4cac126941b5a-396dcc73e3007ef8-ed5fadd3bf0ae241d3f2fd3371f0b535.jpg",
    "https://img03.sogoucdn.com/app/a/100520093/61782be166c826c8-653ea5468e5789eb-6fe1b4d36104bebb2ca90dd2f5b8d75a.jpg",
    "https://i02piccdn.sogoucdn.com/0183cc6a19ec4363",
    "https://img04.sogoucdn.com/app/a/100520024/04495b806930e772ab490ddf57f224e2"
  ];

  HomeModel _homeModel;
  double _appBarAlpha = 0;
  static const int APPBAR_MAX_SCROLL_LEN = 80;

  @override
  void initState() {
    // TODO: implement initState
    HomeDao.get().then((HomeModel homeModel) {
      setState(() {
        _homeModel = homeModel;
      });
      print('home model is null ? ${_homeModel == null}');
    }, onError: (e) {
      print('get json data error ${e}');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x0ff2f22f),
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: NotificationListener(
              onNotification: _onNotification,
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 180,
                    child: Swiper(
                      itemCount: _images.length,
                      autoplay: true,
                      pagination: SwiperPagination(),
                      controller: SwiperController(),
                      itemBuilder: (context, index) {
                        return Image.network(
                          _images[index],
                          fit: BoxFit.fill,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                    child: _homeModel!=null?LocalNavWidget(
                      localNavList: _homeModel.localNavList,
                    ):Container(
                      height: 64,
                    ),
                  ),
                  Container(
                    height: 800,
                    child: Text('HOME PAGE'),
                  ),
                ],
              ),
            ),
          ),
          Opacity(
            opacity: _appBarAlpha,
            child: Container(
              height: 80,
              padding: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Text(
                  '首页',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _onNotification(Notification notification) {
    if (notification is ScrollUpdateNotification && notification.depth == 0) {
      double alpha = notification.metrics.pixels / APPBAR_MAX_SCROLL_LEN;
      print(_appBarAlpha);
      setState(() {
        _appBarAlpha = alpha < 0 ? 0 : (alpha > 1 ? 1 : alpha);
      });
    }
  }
}
