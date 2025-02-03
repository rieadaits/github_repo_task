import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/repository.dart';


abstract class GithubRepository {
  Future<Either<Failure, List<Repository>>> getAndroidRepositories({int page = 1});
} 