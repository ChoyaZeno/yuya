import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yuya/yuya.dart';

void main() {
  testWidgets('checkFormLabels validates form labels', (WidgetTester tester) async {
    // Create the Yuya plugin instance
    final yuya = YuyaPlugin();

    // Build a test widget with form fields
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              // TextField with proper label
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'Enter your email',
                ),
              ),
              // TextField without label (should fail)
              TextField(
                decoration: InputDecoration(),
              ),
            ],
          ),
        ),
      ),
    );

    // Run the form labels check - this should fail due to unlabeled field
    expect(
      () async => await yuya.checkFormLabels(tester),
      throwsA(isA<TestFailure>()),
    );
  });

  testWidgets('checkFormLabels passes with properly labeled forms',
      (WidgetTester tester) async {
    final yuya = YuyaPlugin();

    // Build a test widget with properly labeled form fields
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

    // This should pass without issues
    await yuya.checkFormLabels(tester);
  });
}
