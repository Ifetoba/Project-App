import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class EGovernmentFirebaseUser {
  EGovernmentFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

EGovernmentFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<EGovernmentFirebaseUser> eGovernmentFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<EGovernmentFirebaseUser>(
      (user) {
        currentUser = EGovernmentFirebaseUser(user);
        return currentUser!;
      },
    );
