import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yuya/yuya.dart';
import 'package:yuya/yuya_finder_adapter.dart';

void main() {
  testWidgets('checkFormLabels validates form labels', (WidgetTester tester) async {
    final yuya = YuyaFFILoader();
    await yuya.initialize();

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
              ),
            ],
          ),
        ),
      ),
    );

    // Use copied core validation logic with the adapter
    final finder = FlutterTestFinderAdapter(find);
    final widgetData = YuyaWidgetValidator.extractWidgets(finder);
    final result = yuya.checkFormLabels(widgetData);
    
    expect(result.passed, isFalse);
    expect(result.errorMessage, contains('WCAG 3.3.2'));
    expect(result.errorMessage, contains('TextField #'));
  });

  testWidgets('checkFormLabels passes with properly labeled forms',
      (WidgetTester tester) async {
    final yuya = YuyaFFILoader();
    await yuya.initialize();

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

    // Use copied core validation logic with the adapter
    final finder = FlutterTestFinderAdapter(find);
    final widgetData = YuyaWidgetValidator.extractWidgets(finder);
    final result = yuya.checkFormLabels(widgetData);
    expect(result.passed, isTrue);
  });
}
