/// Yuya - WCAG Form Validation Package
/// 
/// Public API for WCAG accessibility validation using gRPC service.
/// 
/// Self-contained package with strongly-typed gRPC communication.

library;

// Core gRPC client - Communicates with AOT validation service
export 'yuya_grpc_client.dart' show YuyaGrpcClient;

// Data structures - Result types
export 'yuya_data_structures.dart' show FormLabelsResult;

// Test helpers - Clean API for flutter_test
// Provides simple test methods like Yuya.testFormLabels(tester)
export 'yuya_test_helpers.dart' show Yuya;
