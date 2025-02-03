import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/repository.dart';


abstract class GithubRepository {
  Future<Either<Failure, List<Repository>>> getAndroidRepositories({int page = 1});
} 