import 'package:flutter/material.dart';
import 'package:flutter_application_1/CreateTrip.dart';
import 'package:flutter_application_1/join_trip_page.dart';
import 'package:flutter_application_1/tripmodel.dart';
 // Import the Trip model

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<Trip> trips = []; // List to store trips

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 8, 140, 249),
        title: const Text(
          "JourneySync",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Color.fromARGB(255, 57, 251, 57),
              child: CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage("assets/img1.png"),
              ),
            ),
          ),
        ],
      ),
      body: HomeSelection(trips: trips, onTripCreated: _addTrip),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 222, 60, 251),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 28),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _addTrip(Trip trip) {
    setState(() {
      trips.add(trip);
    });
  }
}

class HomeSelection extends StatelessWidget {
  final List<Trip> trips;
  final Function(Trip) onTripCreated;

  const HomeSelection({super.key, required this.trips, required this.onTripCreated});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blueAccent, Colors.purpleAccent],
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 320,
              child: Image.asset("assets/logo.png"),
            ),
        
            _buildTripOption(context, "Create Trip", Icons.travel_explore, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreatePage(onTripCreated: onTripCreated)),
              );
            }),
            const SizedBox(height: 20),
       
            _buildTripOption(context, "Join Trip", Icons.location_city, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JoinTripPage(trip: Trip(source: "", destination: "", carType: "", date: DateTime.now(), maxPeople: 0))), // Placeholder
              );
            }),
            const SizedBox(height: 20),
            // Browse Packages Container
            _buildTripOption(context, "Browse Packages", Icons.card_travel, () {
              // Navigate to Browse Packages page
            }),
            const SizedBox(height: 20),
            // Display Created Trips
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: trips.map((trip) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: 300,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(4, 4),
                          blurRadius: 10,
                        ),
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(-4, -4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "${trip?.source} to ${trip.destination}",
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripOption(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreatePage(onTripCreated: onTripCreated)),
              );
      },
      child: Container(
        width: 300,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(4, 4),
              blurRadius: 10,
            ),
            BoxShadow(
              color: Colors.black12,
              offset: Offset(-4, -4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: Colors.white),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
