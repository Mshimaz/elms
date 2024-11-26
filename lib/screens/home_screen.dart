import 'package:elms/models/subject.dart';
import 'package:elms/providers/subject_provider.dart';
import 'package:elms/screens/modules_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Subjects',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.teal,
        ),
        body: FutureBuilder(
            future: Provider.of<SubjectsProvider>(context, listen: false)
                .fetchSubjects(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong!'));
              } else {
                final subjects =
                    Provider.of<SubjectsProvider>(context).subjects;
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: subjects.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ModulesScreen(
                                    subjectId: subjects[index].id,
                                    subjectTitle: subjects[index].title,
                                  )),
                        );
                      },
                      child: SubjectCard(
                        subject: subjects[index],
                      ),
                    ).animate().scale(duration: 500.ms, curve: Curves.easeOut);
                  },
                );
              }
            }));
  }
}

// Subject Card
class SubjectCard extends StatelessWidget {
  final Subject subject;

  const SubjectCard({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Image.network(subject.image),
        title: Text(subject.title, style: const TextStyle(fontSize: 18)),
        subtitle: Text(
          subject.description,
          style: const TextStyle(fontSize: 12),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.teal),
      ),
    );
  }
}
