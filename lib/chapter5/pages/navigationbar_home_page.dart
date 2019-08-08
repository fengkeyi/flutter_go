import 'package:flutter/material.dart';
import 'package:flutter_go/chapter5/dao/home_dao.dart';
import 'package:flutter_go/chapter5/model/home_model.dart';
import 'package:flutter_go/chapter5/widget/grid_nav.dart';
import 'package:flutter_go/chapter5/widget/loading_container.dart';
import 'package:flutter_go/chapter5/widget/local_nav.dart';
import 'package:flutter_go/chapter5/widget/sales_box.dart';
import 'package:flutter_go/chapter5/widget/webview.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class NavigationBarHomePage extends StatefulWidget {
  @override
  _NavigationBarHomePageState createState() => _NavigationBarHomePageState();
}

class _NavigationBarHomePageState extends State<NavigationBarHomePage> {
  HomeModel _homeModel;
  double _appBarAlpha = 0;
  bool _isLoading = true;
  static const int APPBAR_MAX_SCROLL_LEN = 80;

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  Future<Null> _handleRefresh() async {
    HomeDao.get().then((HomeModel homeModel) {
      setState(() {
        _homeModel = homeModel;
        _isLoading = false;
      });
    }, onError: (e) {
      print('get json data error ${e}');
      setState(() {
        _isLoading = false;
      });
    });
    return null;
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
              child: LoadingContainer(
                child: RefreshIndicator(
                    child: _listView, onRefresh: _handleRefresh),
                isCover: true,
                isLoading: _isLoading,
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

  Widget get _banner {
    return Container(
      height: 180,
      child: _homeModel == null
          ? null
          : Swiper(
              itemCount: _homeModel.bannerList.length,
              autoplay: true,
              pagination: SwiperPagination(),
              controller: SwiperController(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return WebView(
                        url: _homeModel.bannerList[index].url,
                        statusBarColor: _homeModel.bannerList[index].statusBarColor,
                        hideAppBar: true,
                      );
                    }));
                  },
                  child: Image.network(
                    _homeModel.bannerList[index].icon,
                    fit: BoxFit.fill,
                  ),
                );
              },
            ),
    );
  }

  Widget get _listView {
    return ListView(
      children: <Widget>[
        _banner,
        Padding(
            padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
            child: LocalNavWidget(
              localNavList: _homeModel?.localNavList,
            )),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: GridNavView(
            gridNavModel: _homeModel?.gridNav,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: SalesBoxView(
            salesBoxModel: _homeModel?.salesBox,
          ),
        ),
      ],
    );
  }

  bool _onNotification(Notification notification) {
    if (notification is ScrollUpdateNotification && notification.depth == 0) {
      double alpha = notification.metrics.pixels / APPBAR_MAX_SCROLL_LEN;
      setState(() {
        _appBarAlpha = alpha < 0 ? 0 : (alpha > 1 ? 1 : alpha);
      });
    }
  }
}
