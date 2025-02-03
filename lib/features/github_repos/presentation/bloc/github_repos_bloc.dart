import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/github_repository.dart';
import 'github_repos_event.dart';
import 'github_repos_state.dart';

class GithubReposBloc extends Bloc<GithubReposEvent, GithubReposState> {
  final GithubRepository repository;
  int _currentPage = 1;
  static const int _itemsPerPage = 15;

  GithubReposBloc({required this.repository}) : super(GithubReposInitial()) {
    on<FetchGithubRepos>(_onFetchGithubRepos);
    on<LoadMoreGithubRepos>(_onLoadMoreGithubRepos);
  }

  Future<void> _onFetchGithubRepos(
    FetchGithubRepos event,
    Emitter<GithubReposState> emit,
  ) async {
    emit(GithubReposLoading());
    _currentPage = 1;
    final result = await repository.getAndroidRepositories(page: _currentPage);
    result.fold(
      (failure) => emit(GithubReposError(failure.message)),
      (repositories) => emit(
        GithubReposLoaded(
          repositories: repositories,
          hasReachedMax: repositories.length < _itemsPerPage,
        ),
      ),
    );
  }

  Future<void> _onLoadMoreGithubRepos(
    LoadMoreGithubRepos event,
    Emitter<GithubReposState> emit,
  ) async {
    if (state is GithubReposLoaded) {
      final currentState = state as GithubReposLoaded;
      if (!currentState.hasReachedMax) {
        emit(currentState.copyWith(isLoadingMore: true));
        _currentPage++;
        
        final result = await repository.getAndroidRepositories(page: _currentPage);
        result.fold(
          (failure) => emit(GithubReposError(failure.message)),
          (newRepositories) {
            if (newRepositories.isEmpty) {
              emit(currentState.copyWith(
                hasReachedMax: true,
                isLoadingMore: false,
              ));
            } else {
              emit(GithubReposLoaded(
                repositories: [...currentState.repositories, ...newRepositories],
                hasReachedMax: newRepositories.length < _itemsPerPage,
                isLoadingMore: false,
              ));
            }
          },
        );
      }
    }
  }
} 