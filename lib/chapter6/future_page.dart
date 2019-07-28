
main(){
 test();
}

test(){
  print(DateTime.now());
  Future.delayed(Duration(seconds: 3),(){
    print('wait 3 second and return 0');
    print(DateTime.now());
    return 0;
  }).then((value){
    print('return value is $value');
    return 4;
  }).then((value2){
    print('2 return value is $value2');
    return 5;
  }).whenComplete((){
    print('future perform over.');
  });
}