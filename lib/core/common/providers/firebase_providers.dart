import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

// final firebaseStorageProvider =
//     Provider<FirebaseStorage>((ref) => FirebaseStorage.instance);

// final firebaseFirestoreProvider =
//     Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);
