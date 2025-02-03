import 'package:equatable/equatable.dart';
import '../../domain/entities/repository.dart';

abstract class GithubReposState extends Equatable {
  const GithubReposState();

  @override
  List<Object?> get props => [];
}

class GithubReposInitial extends GithubReposState {}

class GithubReposLoading extends GithubReposState {}

class GithubReposLoaded extends GithubReposState {
  final List<Repository> repositories;
  final bool hasReachedMax;
  final bool isLoadingMore;

  const GithubReposLoaded({
    required this.repositories,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  GithubReposLoaded copyWith({
    List<Repository>? repositories,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return GithubReposLoaded(
      repositories: repositories ?? this.repositories,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [repositories, hasReachedMax, isLoadingMore];
}

class GithubReposError extends GithubReposState {
  final String message;

  const GithubReposError(this.message);

  @override
  List<Object?> get props => [message];
} 