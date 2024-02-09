// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Begin custom action codewet

import 'package:uuid/uuid.dart';

Future<String> uuidGenerator() async {
  // Add your function code here!
  var uuid = const Uuid();
  return uuid.v4();
}
