import 'package:equatable/equatable.dart';

abstract class GithubReposEvent extends Equatable {
  const GithubReposEvent();

  @override
  List<Object?> get props => [];
}

class FetchGithubRepos extends GithubReposEvent {
  const FetchGithubRepos();
}

class LoadMoreGithubRepos extends GithubReposEvent {
  const LoadMoreGithubRepos();
} 