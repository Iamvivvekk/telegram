// import 'dart:io';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:telegram/core/common/providers/firebase_providers.dart';

// final commonFirebaseStorageRepositoryProvider =
//     Provider<CommonFirebaseStorageRepository>((ref) {
//   final storage = ref.read(firebaseStorageProvider);
//   return CommonFirebaseStorageRepository(storage: storage);
// });

// class CommonFirebaseStorageRepository {
//   final FirebaseStorage _storage;
//   CommonFirebaseStorageRepository({required FirebaseStorage storage})
//       : _storage = storage;

//   Future<String> uploadFileToFirebaseStorage({
//     required File file,
//     required String
//         reference, //differs with the usecase like for profile => profile/uuid
//   }) async {
//     try {
//       final UploadTask uploadTask =
//           _storage.ref().child(reference).putFile(file);

//       TaskSnapshot snap = await uploadTask;

//       String downloadUrl = await snap.ref.getDownloadURL();
//       return downloadUrl;
//     } on FirebaseException catch (e) {
//       throw e.toString();
//     } catch (e) {
//       throw e.toString();
//     }
//   }
// }
