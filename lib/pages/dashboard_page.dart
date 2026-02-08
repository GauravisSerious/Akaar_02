import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/'),
            child: const Text('Home'),
          ),
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/dashboard'),
            child: const Text('Dashboard'),
          ),
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/detect'),
            child: const Text('Detect Emotion'),
          ),
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/about'),
            child: const Text('About'),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          int crossAxisCount = 1;
          if (width >= 1200) crossAxisCount = 3;
          else if (width >= 700) crossAxisCount = 2;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                Expanded(
                  child: GridView.count(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: crossAxisCount == 1 ? 1.0 : (crossAxisCount == 2 ? 0.95 : 0.9),
                    children: const [
                      _RoleCard(title: 'Parent', icon: Icons.family_restroom, description: 'Monitor progress and insights'),
                      _RoleCard(title: 'Teacher', icon: Icons.school, description: 'Guide learning sessions'),
                      _RoleCard(title: 'Child', icon: Icons.child_care, description: 'Simple, friendly tools'),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () => Navigator.pushReplacementNamed(context, '/detect'),
                    label: const Text('Continue to Emotion Detection'),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;
  const _RoleCard({required this.title, required this.icon, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$title dashboard coming soon'), duration: const Duration(seconds: 2)),
        ),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 48),
              ),
              const SizedBox(height: 16),
              Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Flexible(
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
