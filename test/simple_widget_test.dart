import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yuya/yuya.dart';

void main() {
  late YuyaGrpcClient client;

  setUpAll(() async {
    print('1. setUpAll: Creating client...');
    client = YuyaGrpcClient();
    print('2. setUpAll: Initializing client...');
    await client.initialize();
    print('3. setUpAll: Client initialized!');
  });

  tearDownAll(() async {
    print('4. tearDownAll: Shutting down client...');
    await client.shutdown();
    print('5. tearDownAll: Client shut down!');
  });

  testWidgets('Simple widget test with gRPC', (tester) async {
    print('A. Test starting...');
    await tester.pumpWidget(MaterialApp(home: Text('Hello')));
    print('B. Widget pumped');
  });
}
