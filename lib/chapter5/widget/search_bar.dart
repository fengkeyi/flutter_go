import 'package:flutter/material.dart';

enum SearchBarType { home, homeLight, normal }

class SearchBar extends StatefulWidget {
  final bool enable;
  final bool hideLeft;
  final SearchBarType barType;
  final String hintText;
  final String defaultText;
  final void Function() inputBoxClick;
  final void Function() leftButtonClick;
  final void Function() rightButtonClick;
  final void Function() speakClick;
  final ValueChanged<String> onChange;

  const SearchBar(
      {Key key,
      this.enable = true,
      this.hideLeft = true,
      this.barType = SearchBarType.normal,
      this.hintText,
      this.defaultText,
      this.inputBoxClick,
      this.leftButtonClick,
      this.rightButtonClick,
      this.speakClick,
      this.onChange})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _showClear = false;

  @override
  void initState() {
    if (widget.defaultText != null) {
      setState(() {
        _controller.text = widget.defaultText;
        _showClear = widget.barType==SearchBarType.normal?true:false;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.barType == SearchBarType.normal
        ? _buildNormalSearch()
        :_buildHomeSearch() ;
  }

  Widget _buildHomeSearch() {
    return Container(
      child: Row(
        children: <Widget>[
          _wrap(
              widget.leftButtonClick,
              Container(
                padding: EdgeInsets.fromLTRB(6, 5, 5, 5),
                child: Row(
                  children: <Widget>[
                    Text(
                      '上海',
                      style: TextStyle(color: _homeColor, fontSize: 14),
                    ),
                    Icon(
                      Icons.expand_more,
                      color: _homeColor,
                      size: 22,
                    ),
                  ],
                ),
              )),
          Expanded(flex: 1, child: _inputBox()),
          _wrap(
              widget.rightButtonClick,
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Icon(
                  Icons.comment,
                  color: _homeColor,
                  size: 22,
                ),
              )
              ),
        ],
      ),
    );
  }

  Widget _buildNormalSearch() {
    return Container(
      child: Row(
        children: <Widget>[
          _wrap(
            widget.leftButtonClick,
            Container(
              child: widget.hideLeft ?? false
                  ? null
                  : Icon(
                      Icons.arrow_back_ios,
                      size: 22,
                      color: Colors.grey,
                    ),
            ),
          ),
          Expanded(
            flex: 1,
            child: _inputBox(),
          ),
          _wrap(
              widget.rightButtonClick,
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Text(
                  '搜索',
                  style: TextStyle(color: Colors.lightBlue, fontSize: 17),
                ),
              )),
        ],
      ),
    );
  }

  Widget _inputBox() {
    Color inputBoxColor = widget.barType == SearchBarType.home
        ? Colors.white
        : Color(int.parse('0xffEDEDED'));
    return Container(
      height: 30,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: inputBoxColor,
        borderRadius: BorderRadius.circular(
            widget.barType == SearchBarType.normal ? 5 : 15),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.search,
            size: 20,
            color: widget.barType == SearchBarType.normal
                ? Color(0xffa9a9a9)
                : Colors.blue,
          ),
          Expanded(
              flex: 1,
              child: widget.barType == SearchBarType.normal
                  ? TextField(
                      controller: _controller,
                      onChanged: _onChange,
                      autofocus: true,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        hintText: widget.hintText ?? '',
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 15),
                      ),
                    )
                  : _wrap(
                      widget.inputBoxClick,
                      Container(
                        child: Text(
                          widget.defaultText,
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ))),
          !_showClear
              ? _wrap(
                  widget.speakClick,
                  Icon(
                    Icons.mic,
                    size: 22,
                    color: widget.barType == SearchBarType.normal
                        ? Colors.blue
                        : Colors.grey,
                  ))
              : _wrap(() {
                  _controller.clear();
                  setState(() {});
                  _onChange('');
                },
                  Icon(
                    Icons.clear,
                    size: 22,
                    color: Colors.grey,
                  )),
        ],
      ),
    );
  }

  _onChange(String text) {
    if (text.length > 0) {
      setState(() {
        _showClear = true;
      });
    } else {
      setState(() {
        _showClear = false;
      });
    }
    if (widget.onChange != null) {
      widget.onChange(text);
    }
  }

  Widget _wrap(VoidCallback onTap, Widget child) {
    return GestureDetector(
      onTap: onTap,
      child: child,
    );
  }

  Color get _homeColor {
    return widget.barType == SearchBarType.homeLight
        ? Colors.black54
        : Colors.white;
  }
}
