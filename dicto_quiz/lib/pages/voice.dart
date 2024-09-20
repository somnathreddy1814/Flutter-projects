import 'package:flutter/material.dart';

class Voice extends StatelessWidget {
  final List<VoiceCategory> voices = [
    VoiceCategory(
      title: 'Active Voice',
      description:
      'In active voice, the subject performs the action of the verb. Active voice is more direct and vigorous than passive voice.',
      examples: [
        'The cat chased the mouse.',
        'She writes a letter.',
        'He is playing the guitar.',
      ],
    ),
    VoiceCategory(
      title: 'Passive Voice',
      description:
      'In passive voice, the subject is acted upon by the verb. Passive voice is often used to emphasize the action itself or the receiver of the action.',
      examples: [
        'The mouse was chased by the cat.',
        'A letter is written by her.',
        'The guitar is being played by him.',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Active and Passive Voice'),
      ),
      body: ListView.builder(
        itemCount: voices.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(voices[index].title),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      voices[index].description,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Examples:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    ..._buildExamplesList(voices[index].examples),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildExamplesList(List<String> examples) {
    return examples.map((example) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Text('- $example'),
      );
    }).toList();
  }
}

class VoiceCategory {
  final String title;
  final String description;
  final List<String> examples;

  VoiceCategory({
    required this.title,
    required this.description,
    required this.examples,
  });
}
