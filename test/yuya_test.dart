import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yuya/yuya.dart';

void main() {
  late YuyaGrpcClient client;

  setUpAll(() async {
    client = YuyaGrpcClient();
    await client.initialize();
  });

  tearDownAll(() async {
    await client.shutdown();
  });

  group('Yuya gRPC Advanced Validation', () {
    testWidgets('checkFormLabels validates with proprietary algorithms', (WidgetTester tester) async {
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

      // Use tester.runAsync to enable real async operations (gRPC)
      await tester.runAsync(() async {
        final result = await client.checkFormLabels(find);
        
        expect(result.passed, isFalse);
        expect(result.issues, isNotEmpty);
        expect(result.issues.first, contains('TextField'));
      });
    });

    testWidgets('checkFormLabels passes with properly labeled forms',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    helperText: 'Enter your username',
                  ),
                ),
                DropdownButton<String>(
                  hint: Text('Select an option'),
                  items: [
                    DropdownMenuItem(value: '1', child: Text('Option 1')),
                  ],
                  onChanged: (_) {},
                ),
              ],
            ),
          ),
        ),
      );

      // Use tester.runAsync for gRPC calls
      await tester.runAsync(() async {
        final result = await client.checkFormLabels(find);
        expect(result.passed, isTrue);
        expect(result.issues, isEmpty);
      });
    });

    testWidgets('checkFormLabels rejects generic labels (proprietary check)', 
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'text', // Generic label - should fail proprietary check
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'input', // Generic label - should fail proprietary check
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      // Use tester.runAsync for gRPC calls
      await tester.runAsync(() async {
        final result = await client.checkFormLabels(find);
        
        // Advanced validation should catch generic labels
        expect(result.passed, isFalse);
        expect(result.issues.length, greaterThan(0));
        
        // Should contain information about generic labels
        final issuesText = result.issues.join(' ');
        expect(issuesText.toLowerCase(), contains('generic'));
      });
    });
  });
}
