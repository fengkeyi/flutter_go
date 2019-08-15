import 'package:flutter/services.dart';

class AsrManager{

  static const MethodChannel _channel = MethodChannel('asr_plugin');

  static Future<String> start({Map param}) async{
    return await _channel.invokeMethod('start',param??{});
  }

  static Future<String> stop() async{
    return await _channel.invokeMethod('stop');
  }

  static Future<String> cancel()async{
    return await _channel.invokeMethod('cancel');
  }


}