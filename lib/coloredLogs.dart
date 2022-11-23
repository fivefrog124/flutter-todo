import 'dart:developer' as developer;

void logInfo(var msg) {
  developer.log('\x1B[34m$msg\x1B[0m');
  // ignore: avoid_print
  print("end");
}

// Green text
void logSuccess(var msg) {
  developer.log('\x1B[32m$msg\x1B[0m');
  // ignore: avoid_print
  print("end");
}

// Yellow text
void logWarning(var msg) {
  developer.log('\x1B[33m$msg\x1B[0m');
}

// Red text
void logError(var msg) {
  developer.log('\x1B[31m$msg\x1B[0m');
}
