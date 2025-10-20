import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yuya/yuya_grpc_client.dart';

void main() {
  late YuyaGrpcClient client;

  setUpAll(() async {
    client = YuyaGrpcClient();
    await client.initialize();
  });

  tearDownAll(() async {
    await client.shutdown();
  });

  group('gRPC Client Tests', () {
    testWidgets('validates TextField without label via gRPC', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextField(
              controller: TextEditingController(),
              // No decoration - should fail validation
            ),
          ),
        ),
      );

      final result = await client.checkFormLabels(find);

      expect(result.passed, false);
      expect(result.issues.length, greaterThan(0));
      expect(result.issues.first, contains('Missing accessible label'));
    });

    testWidgets('validates TextField with label via gRPC', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextField(
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
          ),
        ),
      );

      final result = await client.checkFormLabels(find);

      expect(result.passed, true);
      expect(result.issues, isEmpty);
    });

    testWidgets('validates multiple TextFields via gRPC', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  // Missing label - should fail
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Password'),
                ),
              ],
            ),
          ),
        ),
      );

      final result = await client.checkFormLabels(find);

      expect(result.passed, false);
      expect(result.totalElements, 3);
      expect(result.issues.length, 1);
      expect(result.issues.first, contains('TextField #1'));
    });

    testWidgets('strong typing: request and response types are verified at compile time', (tester) async {
      // This test demonstrates the benefit of gRPC's strong typing
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextField(
              decoration: InputDecoration(labelText: 'Test'),
            ),
          ),
        ),
      );

      final result = await client.checkFormLabels(find);

      // All these properties are strongly typed - compile-time verified!
      expect(result.passed, isA<bool>());
      expect(result.totalElements, isA<int>());
      expect(result.issues, isA<List<String>>());
    });
  });
}
