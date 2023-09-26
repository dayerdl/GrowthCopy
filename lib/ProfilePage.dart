import 'dart:io';

import 'package:Growth/profile/PersonalMarks.dart';
import 'package:Growth/signup/SignupScreen.dart';
import 'package:Growth/signup/UserProvider.dart';
import 'package:csv/csv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'MusclePart.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _selectedFilter = 'Last 7 days';
  final List<String> _filterOptions = [
    'Last 7 days',
    'Last 15 days',
    'Last 30 days',
    'Last 3 months'
  ];
  final muscleDistribution = <MusclePart, double>{};

  @override
  Widget build(BuildContext context) {
    muscleDistribution[MusclePart.SHOULDERS] = 4;
    muscleDistribution[MusclePart.ARMS] = 5;
    muscleDistribution[MusclePart.CHEST] = 24;
    muscleDistribution[MusclePart.BACK] = 44;
    muscleDistribution[MusclePart.LEGS] = 24;
    muscleDistribution[MusclePart.CORE] = 0;

    final List<ExerciseMark> exercises = [
      ExerciseMark("Push-ups", "20 rep"),
      ExerciseMark("Sit-ups", "30 rep"),
      ExerciseMark("Squats", "140kg"),
      ExerciseMark("Jumping Jacks", "25 rep"),
      ExerciseMark("Planks", "60 sec"),
    ];

    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(child: Text("Log out, user ${FirebaseAuth.instance.currentUser?.email}"), onTap: (){
                final userProvider = Provider.of<UserProvider>(context, listen: false);
                userProvider.signOut().then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupScreen()));
                });
              },),
              Container(
                margin: const EdgeInsets.only(
                    left: 16.0, right: 16, bottom: 5, top: 5),
                child: Row(
                  children: [
                    GestureDetector(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 40.0,
                        child: SvgPicture.asset(
                          'images/profile.svg',
                          height: 120.0,
                          width: 120.0,
                        ),
                      ),
                      onTap: () {
                        addImageURLColumnToCSV();
                      },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(left: 20),
                          child: const Text(
                            'Dayerman',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(left: 20),
                          child: const Text(
                            'Created workouts 6',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Padding(
                  padding:
                      EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 16),
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("3 workouts completed in",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 18)),
                  Container(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 150,
                      child: DropdownButtonFormField<String>(
                        value: _selectedFilter,
                        items: _filterOptions.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _selectedFilter = value!;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
              const Padding(
                  padding:
                      EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 16),
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  )),
              PersonalMarks(exercises: exercises)
            ],
          ),
        ));
  }
}

Future<void> addImageURLColumnToCSV() async {
  String bucketURL = 'gs://growth-app-50738.appspot.com';

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  firebase_storage.Reference ref = storage.refFromURL(bucketURL);

  List<String> imageURLs = ['URL'];

  try {
    firebase_storage.ListResult result = await ref.child('gifs/180').listAll();
    for (firebase_storage.Reference itemRef in result.items) {
      String downloadURL = await itemRef.getDownloadURL();
      imageURLs.add(downloadURL);
    }

    String exercisesDataString =
        await rootBundle.loadString('assets/male_3830.csv'); //3830 + 1 rows
    List<Map<String, dynamic>> exercisesData =
        const CsvToListConverter().convert(exercisesDataString).map((row) {
      return {
        'id': row[0],
        'name': row[1],
        'name_es': row[2],
        'type': row[3],
        'part': row[4],
        'equipment': row[5],
        'gender': row[6],
        'target': row[7],
        'synergistic': row[8],
      };
    }).toList();

    // // Make sure the number of URLs matches the number of rows
    // if (exercisesData.length != imageURLs.length) {
    //   throw ArgumentError("The number of URLs must match the number of rows.");
    // }

    // Add the Image URL column to each row
    List<List<dynamic>> updatedRows = [];
    for (int i = 0; i < exercisesData.length; i++) {
      Map<String, dynamic> row = exercisesData[i];
      updatedRows.add([
        ...row.values.toList(),
        findImageURL(row, imageURLs, i),
        // Assuming the URLs list corresponds to the order of exercises in the rows list
      ]);
    }

    // Convert the updated rows to CSV format
    String csvData = const ListToCsvConverter().convert(updatedRows);

    // Save the modified CSV data to a new file in the app's local directory
    String newFilePath =
        '${(await getApplicationDocumentsDirectory()).path}/test-url-added.csv';
    File newFile = File(newFilePath);
    await newFile.writeAsString(csvData);

    print(
        'Image URL column added to the CSV data and saved to a new file: $newFilePath');
  } catch (e) {
    print("Error $e");
  }
}

findImageURL(row, List<String> imageURLs, int i) {
  var index = "${row['id']}13";
  var url = i == 0
      ? imageURLs[i]
      : imageURLs.firstWhere((element) => element.contains(index),
          orElse: () => '');
  print("found the url for ${row['id']}: $url");
  return url;
}
