// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:telegram/core/configurations/routes/route_names.dart';
// import 'package:telegram/features/auth/presentation/controller/auth_controller.dart';
// import 'package:telegram/providers/user_data_provider.dart';

// final splashControllerProvider = Provider<SplashController>((ref) {
//   return SplashController(FirebaseAuth.instance, ref);
// });

// class SplashController {
//   // final FirebaseAuth _auth;
//   final Ref _ref;

//   SplashController(FirebaseAuth auth, Ref ref) :
//   //  _auth = auth,
//     _ref = ref;

//   Future<void> getUser(BuildContext context) async {
//     final user = await _ref
//         .read(authControllerProvider.notifier)
//         .getUser(context);

//     if (user == null || user.name!.isEmpty) {
//       if (context.mounted) {
//         context.goNamed(RouteNames.onBoarding);
//       }
//     } else {
//       _ref.read(userDataProvider.notifier).update((u) => user);
//       if (context.mounted) context.goNamed(RouteNames.home);
//     }
//   }
// }
