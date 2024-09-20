import 'package:flutter/material.dart';

class Tenses extends StatelessWidget {
  final List<TenseCategory> tenses = [
    TenseCategory(
      title: 'Simple Present',
      description:
      'The simple present tense is used to describe habitual actions, general truths, and scheduled events.',
      examples: [
        'I eat',
        'She reads books',
        'He goes to school',
      ],
    ),
    TenseCategory(
      title: 'Present Continuous',
      description:
      'The present continuous tense is used to describe actions that are happening now or ongoing actions.',
      examples: [
        'I am eating',
        'She is reading books',
        'He is going to school',
      ],
    ),
    TenseCategory(
      title: 'Present Perfect',
      description:
      'The present perfect tense is used to describe actions that happened at an unspecified time in the past or actions that started in the past and continue into the present.',
      examples: [
        'I have eaten',
        'She has read books',
        'He has gone to school',
      ],
    ),
    TenseCategory(
      title: 'Present Perfect Continuous',
      description:
      'The present perfect continuous tense is used to describe actions that started in the past and continue into the present or actions that have just stopped.',
      examples: [
        'I have been eating',
        'She has been reading books',
        'He has been going to school',
      ],
    ),
    TenseCategory(
      title: 'Simple Past',
      description:
      'The simple past tense is used to describe actions that were completed in the past.',
      examples: [
        'I ate',
        'She read books',
        'He went to school',
      ],
    ),
    TenseCategory(
      title: 'Past Continuous',
      description:
      'The past continuous tense is used to describe actions that were ongoing in the past or actions that were interrupted by another action in the past.',
      examples: [
        'I was eating',
        'She was reading books',
        'He was going to school',
      ],
    ),
    TenseCategory(
      title: 'Past Perfect',
      description:
      'The past perfect tense is used to describe actions that happened before another action in the past.',
      examples: [
        'I had eaten',
        'She had read books',
        'He had gone to school',
      ],
    ),
    TenseCategory(
      title: 'Past Perfect Continuous',
      description:
      'The past perfect continuous tense is used to describe actions that started in the past and continued up to another action in the past or actions that had been going on before something else happened.',
      examples: [
        'I had been eating',
        'She had been reading books',
        'He had been going to school',
      ],
    ),
    TenseCategory(
      title: 'Future Simple',
      description:
      'The future simple tense is used to describe actions that will happen in the future.',
      examples: [
        'I will eat',
        'She will read books',
        'He will go to school',
      ],
    ),
    TenseCategory(
      title: 'Future Continuous',
      description:
      'The future continuous tense is used to describe ongoing actions that will happen in the future.',
      examples: [
        'I will be eating',
        'She will be reading books',
        'He will be going to school',
      ],
    ),
    TenseCategory(
      title: 'Future Perfect',
      description:
      'The future perfect tense is used to describe actions that will be completed at some point in the future before another action takes place.',
      examples: [
        'I will have eaten',
        'She will have read books',
        'He will have gone to school',
      ],
    ),
    TenseCategory(
      title: 'Future Perfect Continuous',
      description:
      'The future perfect continuous tense is used to describe actions that will continue up to a certain point in the future or actions that will be ongoing when another action takes place in the future.',
      examples: [
        'I will have been eating',
        'She will have been reading books',
        'He will have been going to school',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore Tenses'),
      ),
      body: ListView.builder(
        itemCount: tenses.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(tenses[index].title),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tenses[index].description,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Examples:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    ..._buildExamplesList(tenses[index].examples),
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

class TenseCategory {
  final String title;
  final String description;
  final List<String> examples;

  TenseCategory({
    required this.title,
    required this.description,
    required this.examples,
  });
}


