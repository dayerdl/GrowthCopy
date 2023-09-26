import 'package:flutter/material.dart';

class ExerciseMark {
  final String name;
  final String personalMark;

  ExerciseMark(this.name, this.personalMark);
}

class PersonalMarks extends StatefulWidget {
  final List<ExerciseMark> exercises;

  PersonalMarks({required this.exercises});

  @override
  _PersonalMarksState createState() => _PersonalMarksState();
}

class _PersonalMarksState extends State<PersonalMarks> {
  bool displayDelete = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 0, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/medal.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Personal records",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                  ),
                ],
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    displayDelete ? "Save" : "Edit" ,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                onTap: () {
                  setState(() {
                    displayDelete = !displayDelete;
                  });
                },
              )
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.exercises.length + 1, // Add 1 for the header
          itemBuilder: (context, index) {
            if (index == 0) {
              // Header row
              return SizedBox(
                height: 45,
                child: ListTile(
                  title: Text(
                    'Exercise',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Header text color
                    ),
                  ),
                  trailing: Text(
                    'Best Mark',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Header text color
                    ),
                  ),
                ),
              );
            }

            final exercise =
            widget.exercises[index - 1]; // Subtract 1 to adjust for header
            final bgColor = index % 2 == 0
                ? Colors.grey[200]
                : Colors.white; // Alternating row colors

            return Container(
              color: bgColor,
              child: ListTile(
                title: Row(
                  children: [
                    if (displayDelete)
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Add logic to delete the exercise
                          setState(() {
                            widget.exercises.removeAt(index - 1);
                          });
                        },
                      ),
                    Text(exercise.name),
                  ],
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Text(
                    exercise.personalMark,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                onTap: () {
                  // Add your logic here when a list item is tapped
                  // For example, you can navigate to a detailed view
                  // or perform some action.
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
