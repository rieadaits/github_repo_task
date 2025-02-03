import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/github_repos_bloc.dart';
import '../bloc/github_repos_event.dart';
import '../bloc/github_repos_state.dart';
import '../widgets/repository_list_item.dart';
import 'repository_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _loadRepositories();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadRepositories() {
    context.read<GithubReposBloc>().add(const FetchGithubRepos());
  }

  void _loadMoreRepositories() {
    if (!_isLoadingMore) {
      _isLoadingMore = true;
      context.read<GithubReposBloc>().add(const LoadMoreGithubRepos());
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreRepositories();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Android GitRepos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocConsumer<GithubReposBloc, GithubReposState>(
        listener: (context, state) {
          if (state is GithubReposLoaded) {
            _isLoadingMore = state.isLoadingMore;
          }
        },
        builder: (context, state) {
          if (state is GithubReposLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Fetching repositories...'),
                ],
              ),
            );
          } else if (state is GithubReposLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                _loadRepositories();
              },
              child: state.repositories.isEmpty
                  ? const Center(
                      child: Text('No repositories found'),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: state.repositories.length + 1,
                      itemBuilder: (context, index) {
                        if (index == state.repositories.length) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: state.isLoadingMore
                                  ? const CircularProgressIndicator()
                                  : state.hasReachedMax
                                      ? const Text('No more repositories')
                                      : const SizedBox.shrink(),
                            ),
                          );
                        }

                        final repository = state.repositories[index];
                        return RepositoryListItem(
                          repository: repository,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RepositoryDetailsPage(
                                  repository: repository,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            );
          } else if (state is GithubReposError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _loadRepositories,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
} 