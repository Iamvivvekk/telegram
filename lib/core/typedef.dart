import 'package:fpdart/fpdart.dart';
import 'package:telegram/core/utils/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
