class Repository {
  final int id;
  final String name;
  final String? description;
  final String ownerAvatarUrl;
  final String ownerName;
  final int stargazersCount;
  final int watchersCount;
  final String updatedAt;

  const Repository({
    required this.id,
    required this.name,
    this.description,
    required this.ownerAvatarUrl,
    required this.ownerName,
    required this.stargazersCount,
    required this.watchersCount,
    required this.updatedAt,
  });
} 