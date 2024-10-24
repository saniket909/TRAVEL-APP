import 'package:flutter/material.dart';
import 'package:flutter_application_1/tripmodel.dart';

class JoinTripPage extends StatelessWidget {
  final Trip trip;

  const JoinTripPage({Key? key, required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Join Trip"),
        backgroundColor: const Color.fromARGB(255, 8, 140, 249),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Source: ${trip.source}", style: const TextStyle(fontSize: 18)),
                Text("Destination: ${trip.destination}", style: const TextStyle(fontSize: 18)),
                Text("Car Type: ${trip.carType}", style: const TextStyle(fontSize: 18)),
                Text("Max People: ${trip.maxPeople}", style: const TextStyle(fontSize: 18)),
                Text("Date: ${trip.date.toLocal()}".split(' ')[0], style: const TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
