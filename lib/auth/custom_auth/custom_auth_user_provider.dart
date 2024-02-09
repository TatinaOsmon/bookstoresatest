import 'package:rxdart/rxdart.dart';

import '/backend/schema/structs/index.dart';
import 'custom_auth_manager.dart';

class BookStoreAuthUser {
  BookStoreAuthUser({
    required this.loggedIn,
    this.uid,
    this.userData,
  });

  bool loggedIn;
  String? uid;
  UserStruct? userData;
}

/// Generates a stream of the authenticated user.
BehaviorSubject<BookStoreAuthUser> bookStoreAuthUserSubject =
    BehaviorSubject.seeded(BookStoreAuthUser(loggedIn: false));
Stream<BookStoreAuthUser> bookStoreAuthUserStream() => bookStoreAuthUserSubject
    .asBroadcastStream()
    .map((user) => currentUser = user);
