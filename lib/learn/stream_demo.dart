import 'dart:isolate';
import 'dart:async';

void main() async{

  final ReceivePort receivePort = ReceivePort();

  await Isolate.spawn(_isolate, receivePort.sendPort);

  //获取sendPort来发送数据
  final sendPort = await receivePort.first as SendPort;
  //接收消息的ReceivePort
  final answer = new ReceivePort();
  //发送数据
  print('send 20');
  sendPort.send([6,answer.sendPort]);

}

void _isolate(SendPort message) {
  print('_isolate $message');
  final port = new ReceivePort();
  //绑定
  message.send(port.sendPort);
  //监听
  port.listen((message){
    //获取数据并解析
    print('listen $message');
    final data = message[0] as int;
    final send = message[1] as SendPort;
    //返回结果
    send.send(syncFibonacci(data));
  });

}

int syncFibonacci(int n){
  print('syncFibonacci $n');
  return n < 2 ? n : syncFibonacci(n-2) + syncFibonacci(n-1);
}
