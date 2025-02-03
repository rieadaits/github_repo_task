import '../../domain/entities/repository.dart';

class RepositoryModel extends Repository {
  const RepositoryModel({
    required super.id,
    required super.name,
    super.description,
    required super.ownerAvatarUrl,
    required super.ownerName,
    required super.stargazersCount,
    required super.watchersCount,
    required super.updatedAt,
  });

  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      ownerAvatarUrl: json['owner']?['avatar_url'] ?? json['owner_avatar_url'],
      ownerName: json['owner']?['login'] ?? json['owner_name'],
      stargazersCount: json['stargazers_count'],
      watchersCount: json['watchers_count'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'owner_avatar_url': ownerAvatarUrl,
      'owner_name': ownerName,
      'stargazers_count': stargazersCount,
      'watchers_count': watchersCount,
      'updated_at': updatedAt,
    };
  }
} 