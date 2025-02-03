import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/github_repository.dart';
import '../datasources/github_local_datasource.dart';
import '../datasources/github_remote_datasource.dart';
import '../../domain/entities/repository.dart';

class GithubRepositoryImpl implements GithubRepository {
  final GithubRemoteDataSource remoteDataSource;
  final GithubLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  GithubRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Repository>>> getAndroidRepositories({int page = 1}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRepos = await remoteDataSource.getAndroidRepositories(page: page);
        if (page == 1) {
          await localDataSource.cacheAndroidRepositories(remoteRepos);
        }
        return Right(remoteRepos);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      try {
        final localRepos = await localDataSource.getLastAndroidRepositories();
        return Right(localRepos);
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }
} 