import 'package:elms/providers/module_provider.dart';
import 'package:elms/screens/videos_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

class ModulesScreen extends StatelessWidget {
  final int subjectId;
  final String subjectTitle;

  const ModulesScreen(
      {super.key, required this.subjectId, required this.subjectTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            subjectTitle,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.teal,
        ),
        body: FutureBuilder(
            future: Provider.of<ModulesProvider>(context, listen: false)
                .fetchModules(subjectId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong!'));
              } else {
                final modules = Provider.of<ModulesProvider>(context).modules;
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: modules.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VideosListScreen(
                                  moduleId: modules[index].id,
                                  moduleTitle: modules[index].title)),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          title: Text(
                            modules[index].title,
                            style: const TextStyle(fontSize: 18),
                          ),
                          subtitle: Text(
                            modules[index].description,
                            style: const TextStyle(fontSize: 12),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              color: Colors.teal),
                        ),
                      ).animate().slide(
                            duration: 500.ms,
                            curve: Curves.easeOut,
                          ),
                    );
                  },
                );
              }
            }));
  }
}
