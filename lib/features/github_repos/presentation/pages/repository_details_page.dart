import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/repository.dart';

class RepositoryDetailsPage extends StatelessWidget {
  final Repository repository;

  const RepositoryDetailsPage({
    super.key,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(repository.name),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(repository.ownerAvatarUrl),
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: 'Owner',
              content: repository.ownerName,
            ),
            _buildInfoCard(
              title: 'Description',
              content: repository.description ?? 'No description available',
            ),
            _buildInfoCard(
              title: 'Last Updated',
              content: DateFormat('MM-dd-yyyy HH:mm')
                  .format(DateTime.parse(repository.updatedAt)),
            ),
            _buildStatsRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({required String title, required String content}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(content),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.star_border,
            label: 'Stars',
            value: repository.stargazersCount.toString(),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            icon: Icons.remove_red_eye_outlined,
            label: 'Watchers',
            value: repository.watchersCount.toString(),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon),
            const SizedBox(height: 8),
            Text(label),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 