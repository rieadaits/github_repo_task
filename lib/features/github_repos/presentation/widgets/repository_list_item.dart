import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/repository.dart';

class RepositoryListItem extends StatelessWidget {
  final Repository repository;
  final VoidCallback onTap;

  const RepositoryListItem({
    super.key,
    required this.repository,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: CachedNetworkImage(
            imageUrl: repository.ownerAvatarUrl,
            width: 50,
            height: 50,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        title: Text(
          repository.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              repository.description ?? 'No description available',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star_border, size: 16),
                const SizedBox(width: 4),
                Text(repository.stargazersCount.toString()),
                const SizedBox(width: 16),
                const Icon(Icons.remove_red_eye_outlined, size: 16),
                const SizedBox(width: 4),
                Text(repository.watchersCount.toString()),
              ],
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
} 