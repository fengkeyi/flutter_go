import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TravelTabPage extends StatefulWidget {

  final String travelUrl;
  final String groupChannelCode;
  final Map<String,dynamic> params;

  const TravelTabPage({Key key, this.travelUrl, this.groupChannelCode, this.params}) : super(key: key);

  @override
  _TravelTabPageState createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

