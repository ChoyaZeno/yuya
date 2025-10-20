import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yuya/yuya.dart';

void main() {
  test('Simple gRPC client test', () async {
    print('1. Creating client...');
    final client = YuyaGrpcClient();
    
    print('2. Initializing...');
    await client.initialize();
    
    print('3. Client initialized, shutting down...');
    await client.shutdown();
    
    print('4. Shutdown complete!');
  });
}
