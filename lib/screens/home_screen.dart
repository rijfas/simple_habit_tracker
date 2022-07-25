import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('Simple Habbit Tracker'),
        backgroundColor: Colors.grey.shade900,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => const HabitTile(),
        itemCount: 5,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Habit Title',
                          focusColor: Colors.grey.shade900),
                    ),
                  ),
                  const Text(
                    'Habit Time:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  CupertinoTimerPicker(
                    initialTimerDuration: const Duration(minutes: 5),
                    onTimerDurationChanged: (value) => {},
                    mode: CupertinoTimerPickerMode.hm,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Save',
                            style: TextStyle(color: Colors.grey.shade900),
                          )),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.red.shade300),
                          )),
                    ],
                  ),
                  const SizedBox(height: 10.0)
                ],
              ),
            ),
          );
        },
        backgroundColor: Colors.grey.shade900,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class HabitTile extends StatelessWidget {
  const HabitTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Icon(
                  Icons.play_arrow,
                  color: Colors.grey.shade900,
                ),
                CircularProgressIndicator(
                  value: 0.5,
                  color: Colors.grey.shade900,
                )
              ],
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Habbit title',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 2.5),
                Text(
                  '00:05:00 = 20%',
                  style: TextStyle(color: Colors.grey.shade500),
                )
              ],
            ),
            const Spacer(),
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
          ],
        ),
      ),
    );
  }
}
