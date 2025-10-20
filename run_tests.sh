#!/bin/bash
set -e

echo "🧪 Running Yuya tests with gRPC service..."
echo ""

# Run tests
flutter test test/yuya_test.dart -r expanded

echo ""
echo "✅ All tests completed!"
