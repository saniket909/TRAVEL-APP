import 'package:flutter/material.dart';
import 'package:flutter_application_1/tripmodel.dart';
 // Import the Trip model

class CreatePage extends StatefulWidget {
  final Function(Trip) onTripCreated; // Callback to handle trip creation

  const CreatePage({super.key, required this.onTripCreated});

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  int _maxPeople = 1; // Initial number of people
  DateTime? _selectedDate; // Selected date
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  String? _carType; // Variable to hold selected car type

  final Color primaryColor = const Color.fromARGB(255, 8, 140, 249);
  final Color dropdownFillColor = const Color.fromARGB(255, 243, 242, 243);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          "Create Trip",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildLocationField("Enter source location", Icons.add, _sourceController),
              const SizedBox(height: 20),
              _buildLocationField("Enter destination location", Icons.add, _destinationController),
              const SizedBox(height: 20),
              _buildCarTypeDropdown(),
              const SizedBox(height: 20),
              _buildMaxPeopleSelector(),
              const SizedBox(height: 20),
              _buildDatePicker(),
              const SizedBox(height: 20),
              _buildSubmitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationField(String hintText, IconData icon, TextEditingController controller) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Icon(icon, size: 24, color: primaryColor),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarTypeDropdown() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Select Car Type',
          border: InputBorder.none,
          filled: true,
          fillColor: dropdownFillColor,
        ),
        items: <String>['Sedan', 'SUV', 'Hatchback', 'Luxury']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _carType = newValue; // Update car type
          });
        },
      ),
    );
  }

  Widget _buildMaxPeopleSelector() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Max People:',
              style: TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (_maxPeople > 1) {
                        _maxPeople--;
                      }
                    });
                  },
                ),
                Text(
                  '$_maxPeople',
                  style: const TextStyle(fontSize: 24),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _maxPeople++;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Select Date:',
              style: TextStyle(fontSize: 16),
            ),
            TextButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate ?? DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != _selectedDate) {
                  setState(() {
                    _selectedDate = picked;
                  });
                }
              },
              child: Text(
                _selectedDate == null
                    ? 'Choose Date'
                    : '${_selectedDate!.toLocal()}'.split(' ')[0],
                style: TextStyle(color: primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Validate input fields
        if (_sourceController.text.isEmpty || 
            _destinationController.text.isEmpty ||
            _carType == null || 
            _selectedDate == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please fill all fields")),
          );
          return;
        }

        // Create a new Trip instance
        Trip newTrip = Trip(
          source: _sourceController.text,
          destination: _destinationController.text,
          carType: _carType!,
          date: _selectedDate!,
          maxPeople: _maxPeople,
        );

        // Call the callback to add the trip
        widget.onTripCreated(newTrip);
        
        // Navigate back to the homepage
        Navigator.pop(context);
      },
      child: const Text("Create Trip"),
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
