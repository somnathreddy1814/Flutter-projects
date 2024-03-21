import 'package:flutter/material.dart';
import 'gym_screen.dart';
import 'gymstruct.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        fontFamily: 'Roboto',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _bodyPartController = TextEditingController();
  final ApiService _apiService = ApiService('4rDLBAU94pK9PG/vNf0jew==N0g7X9Aa4VV97EnB');
  List<Exercise> _exercises = [];
  bool _isSearching = false;

  // Mock data for body part suggestions
  final List<String> _bodyPartSuggestions = [
    'abdominals',
    'abductors',
    'adductors',
    'biceps',
    'calves',
    'chest',
    'forearms',
    'glutes',
    'hamstrings',
    'lats',
    'lower_back',
    'middle_back',
    'neck',
    'quadriceps',
    'traps',
    'triceps',
  ];


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[100],
          elevation: 0.0,
          title: Text('GYM App'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // AutocompleteTextField for body part suggestions
                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<String>.empty();
                    }
                    return _bodyPartSuggestions.where((String suggestion) =>
                        suggestion.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                  },
                  onSelected: (String selected) {
                    setState(() {
                      _bodyPartController.text = selected;
                    });
                    _fetchExercises();
                  },
                  fieldViewBuilder: (BuildContext context, TextEditingController controller, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      onChanged: (value) {
                        // You can add additional logic here if needed
                      },
                      onSubmitted: (String value) {
                        onFieldSubmitted();
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter Body Part',
                        border: OutlineInputBorder(),
                      ),
                    );
                  },
                  optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        elevation: 4.0,
                        child: SizedBox(
                          height: 200.0,
                          child: ListView.builder(
                            padding: EdgeInsets.all(8.0),
                            itemCount: options.length,
                            itemBuilder: (BuildContext context, int index) {
                              final String option = options.elementAt(index);
                              return GestureDetector(
                                onTap: () {
                                  onSelected(option);
                                },
                                child: ListTile(
                                  title: Text(option),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _fetchExercises,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.orange[100],
                  ),
                  child: Text('Search Exercises'),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ExerciseList(_exercises, _isSearching),
                ),
              ],
            ),
          ),
        ),

    );
  }

  void _fetchExercises() async {
    final muscle = _bodyPartController.text;

    if (!_bodyPartSuggestions.contains(muscle.toLowerCase())) {
      // Body part not in the list
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Body Part Not Found'),
            content: Text('The entered body part is not in the list. We are adding it in the next update.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      setState(() {
        _isSearching = true;
      });

      List<Exercise> exercises = await _apiService.fetchExercises(muscle);
      setState(() {
        _exercises = exercises;
      });
    } catch (e) {
      // Handle error
      print('Error fetching exercises: $e');
    } finally {
      setState(() {
        _isSearching = false;
      });
    }
  }}
