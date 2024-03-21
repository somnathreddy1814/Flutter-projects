import 'package:flutter/material.dart';
import 'gymstruct.dart';
class ExerciseList extends StatelessWidget {
  final List<Exercise> exercises;

  ExerciseList(this.exercises, bool isSearching);

  @override
  Widget build(BuildContext context) {

    return exercises.isEmpty
        ? Center(
      child: Text(
        'Enter a body part to get personalized exercise suggestions and start your fitness journey today.',
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    )
        : ListView.builder(
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(vertical: 8),
            color: Colors.transparent,
            child: ListTile(
              title: Text(
                '${exercises[index].name}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Type: ${exercises[index].type}, Difficulty: ${exercises[index].difficulty}',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // You can implement a detailed view for each exercise here
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('${exercises[index].name}'),
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Type: ${exercises[index].type}'),
                            Text('Muscle: ${exercises[index].muscle}'),
                            Text('Equipment: ${exercises[index].equipment}'),
                            Text('Difficulty: ${exercises[index].difficulty}'),
                            SizedBox(height: 10),
                            Text('Instructions:'),
                            Text(exercises[index].instructions),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}