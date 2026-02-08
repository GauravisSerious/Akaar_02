import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../data/behavior_guide_data.dart';
import 'behavior_detail_page.dart';

class BehaviorGuidePage extends StatefulWidget {
  const BehaviorGuidePage({super.key});

  @override
  State<BehaviorGuidePage> createState() => _BehaviorGuidePageState();
}

class _BehaviorGuidePageState extends State<BehaviorGuidePage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final guides = BehaviorGuideData.search(_searchQuery);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Behavior Guide'),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search behaviors...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // Guide list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
              itemCount: guides.length,
              itemBuilder: (context, index) {
                final guide = guides[index];
                return FadeInUp(
                  delay: Duration(milliseconds: index * 50),
                  child: Card(
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF7C4DFF).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            guide.emoji,
                            style: const TextStyle(fontSize: 28),
                          ),
                        ),
                      ),
                      title: Text(
                        guide.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        guide.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BehaviorDetailPage(guide: guide),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
