import 'package:material_ui/material_ui.dart';

import '../models/project.dart';

class ProjectDetailPage extends StatelessWidget {
  final Project project;

  const ProjectDetailPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Proyek'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            if (project.projectImageUrl.isNotEmpty) ...[
              Image.network(
                project.projectImageUrl,
                height: 220,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 120,
                    child: Center(child: Text('Gambar tidak dapat dimuat.')),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
            Text(
              project.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Text('Deskripsi', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(project.description),
            const SizedBox(height: 20),
            Text('Teknologi', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(project.techStack),
            const SizedBox(height: 20),
            Text('URL Proyek', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            SelectableText(project.projectUrl),
          ],
        ),
      ),
    );
  }
}
