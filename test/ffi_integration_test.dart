import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yuya/yuya_ffi_loader.dart';

void main() {
  group('FFI Integration Tests - Direct Bridge Calls', () {
    testWidgets('validates TextField without label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextField(
              decoration: InputDecoration(), // No label!
            ),
          ),
        ),
      );

      final yuya = YuyaFFILoader();
      final result = yuya.checkFormLabels(find);

      // Should FAIL - no label
      expect(result.passed, false);
      expect(result.issues, isNotEmpty);
      expect(result.issues.first, contains('TextField #0'));
      expect(result.issues.first, contains('Missing accessible label'));
      expect(result.totalElements, 1);
    });

    testWidgets('validates TextField with labelText', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextField(
              decoration: InputDecoration(
                labelText: 'Email Address',
              ),
            ),
          ),
        ),
      );

      final yuya = YuyaFFILoader();
      final result = yuya.checkFormLabels(find);

      // Should PASS - has label
      expect(result.passed, true);
      expect(result.issues, isEmpty);
      expect(result.totalElements, 1);
    });

    testWidgets('validates multiple TextFields mixed', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  decoration: InputDecoration(), // No label!
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Password'),
                ),
              ],
            ),
          ),
        ),
      );

      final yuya = YuyaFFILoader();
      final result = yuya.checkFormLabels(find);

      // Should FAIL - one field has no label
      expect(result.passed, false);
      expect(result.issues.length, 1);
      expect(result.issues.first, contains('TextField #1'));
      expect(result.totalElements, 3);
    });

    testWidgets('validates DropdownButton without hint', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DropdownButton<String>(
              items: [
                DropdownMenuItem(value: '1', child: Text('Option 1')),
              ],
              onChanged: (_) {},
            ),
          ),
        ),
      );

      final yuya = YuyaFFILoader();
      final result = yuya.checkFormLabels(find);

      // Should FAIL - no hint or value
      expect(result.passed, false);
      expect(result.issues, isNotEmpty);
      expect(result.issues.first, contains('DropdownButton #0'));
    });

    testWidgets('validates DropdownButton with hint', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DropdownButton<String>(
              hint: Text('Select Country'),
              items: [
                DropdownMenuItem(value: '1', child: Text('USA')),
              ],
              onChanged: (_) {},
            ),
          ),
        ),
      );

      final yuya = YuyaFFILoader();
      final result = yuya.checkFormLabels(find);

      // Should PASS - has hint
      expect(result.passed, true);
      expect(result.issues, isEmpty);
      expect(result.totalElements, 1);
    });

    testWidgets('validates complex form', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Email'),
                ),
                DropdownButton<String>(
                  hint: Text('Country'),
                  items: [DropdownMenuItem(value: '1', child: Text('USA'))],
                  onChanged: (_) {},
                ),
                TextField(
                  decoration: InputDecoration(), // Missing label!
                ),
              ],
            ),
          ),
        ),
      );

      final yuya = YuyaFFILoader();
      final result = yuya.checkFormLabels(find);

      // Should FAIL - one TextField missing label
      expect(result.passed, false);
      expect(result.issues.length, 1);
      expect(result.issues.first, contains('TextField #2'));
      expect(result.totalElements, 4); // 3 TextFields + 1 Dropdown
    });
  });
}
