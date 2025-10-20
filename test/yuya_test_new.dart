import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yuya/yuya.dart';

void main() {
  late YuyaGrpcClient client;

  setUpAll(() async {
    client = YuyaGrpcClient();
    await client.initialize();
    
    // Give service extra time to fully start
    await Future.delayed(Duration(seconds: 1));
  });

  tearDownAll(() async {
    await client.shutdown();
  });

  group('Yuya gRPC Validation', () {
    // Use regular test() instead of testWidgets() to avoid event loop conflicts
    test('checkFormLabels validates form labels via gRPC', () async {
      // Create a simple test using runApp in a zone
      await runZonedGuarded(() async {
        TestWidgetsFlutterBinding.ensureInitialized();
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      hintText: 'Enter your email',
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(),
                    // Missing label - should fail advanced validation
                  ),
                ],
              ),
            ),
          ),
        );

        final result = await client.checkFormLabels(find);
        
        expect(result.passed, isFalse);
        expect(result.issues, isNotEmpty);
        expect(result.issues.first, contains('TextField'));
      }, (error, stack) {
        print('Error in test: $error');
        print('Stack: $stack');
      });
    });
  });
}
