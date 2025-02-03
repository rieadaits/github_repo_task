import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../models/repository_model.dart';

abstract class GithubRemoteDataSource {
  Future<List<RepositoryModel>> getAndroidRepositories({int page = 1});
}

class GithubRemoteDataSourceImpl implements GithubRemoteDataSource {
  final http.Client client;
  final String _baseUrl = 'https://api.github.com';
  final int _perPage = 15;

  GithubRemoteDataSourceImpl({required this.client});

  @override
  Future<List<RepositoryModel>> getAndroidRepositories({int page = 1}) async {
    try {
      final response = await client.get(
        Uri.parse(
          '$_baseUrl/search/repositories?q=Android&sort=stars&order=desc&page=$page&per_page=$_perPage'
        ),
        headers: {
          'Accept': 'application/vnd.github+json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<dynamic> items = jsonData['items'];
        return items.map((item) => RepositoryModel.fromJson(item)).toList();
      } else {
        final errorMessage = json.decode(response.body)['message'] ?? 'Failed to fetch repositories';
        throw ServerException(errorMessage);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
} 