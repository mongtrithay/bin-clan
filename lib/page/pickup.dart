import 'package:flutter/material.dart';
import 'package:binclan/components/bottom_nav_bar.dart';
import 'package:binclan/services/api_service.dart'; // Ensure this path is correct

class PickupFormPage extends StatefulWidget {
  const PickupFormPage({super.key});

  @override
  _PickupFormPageState createState() => _PickupFormPageState();
}

class _PickupFormPageState extends State<PickupFormPage> {
  // Define the controllers for your form fields
  final TextEditingController dateController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController estimatedWeightController = TextEditingController();  
  final TextEditingController otherRecurringController = TextEditingController();

  String? selectedWasteType;
  String? selectedRecurring;

  // API function to schedule the pickup
  Future<void> schedulePickup() async {
    // Ensure required fields are filled before proceeding
    if (dateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select a date.")));
      return;
    }

    if (selectedWasteType == null || selectedWasteType!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select a waste type.")));
      return;
    }

    if (estimatedWeightController.text.isEmpty || double.tryParse(estimatedWeightController.text) == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter a valid estimated weight.")));
      return;
    }

    try {
      await _submitPickupRequest();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Pickup Scheduled Successfully!")),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $error")),
      );
    }
  }

  // Extract the API call to a separate method
  Future<void> _submitPickupRequest() async {
    final apiService = ApiService();
    await apiService.schedulePickup(
      userId: "123456", // Change to dynamic user ID
      date: dateController.text,
      wasteTypes: [selectedWasteType ?? ""],
      estimateWeight: double.tryParse(estimatedWeightController.text) ?? 0,
      recurring: selectedRecurring != null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel("Select Date"),
            _buildDatePicker(),
            SizedBox(height: 10),

            _buildLabel("Waste Type"),
            DropdownButtonFormField<String>(
              value: selectedWasteType,
              decoration: _inputDecoration(),
              hint: Text("Type"),
              items: ["Plastic", "Paper", "Metal", "Glass or Electronic"].map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (value) => setState(() => selectedWasteType = value),
            ),
            SizedBox(height: 10),

            _buildLabel("Weight/Volume"),
            _buildTextField(weightController, "Enter your weight/volume"),
            SizedBox(height: 10),

            _buildLabel("Estimated Weight"),
            _buildTextField(estimatedWeightController, "Enter Estimated Weight"), 
            SizedBox(height: 10),

            _buildLabel("Recurring Pickup"),
            Column(
              children: [
                _buildRadioTile("1 Day"),
                _buildRadioTile("1 Week"),
                _buildRadioTile("1 Month"),
                _buildRadioTile("1 Year"),
                _buildRadioTile("Other"),
                _buildTextField(otherRecurringController, "Other"),
              ],
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildButton("Pickup", schedulePickup), // Call API on button press
                SizedBox(width: 10),
                _buildButton("Pickup History", () {}),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 0,
        onItemTapped: (index) {},
      ),
    );
  }

  // Date picker method for better user experience
  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: () async {
        DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );

        if (selectedDate != null) {
          setState(() {
            dateController.text = "${selectedDate.toLocal()}".split(' ')[0]; // Formatting the date
          });
        }
      },
      child: AbsorbPointer(
        child: _buildTextField(dateController, "dd/mm/yy"),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
      child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        decoration: _inputDecoration().copyWith(hintText: hintText),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }

  Widget _buildRadioTile(String value) {
    return RadioListTile<String>(
      title: Text(value),
      value: value,
      groupValue: selectedRecurring,
      onChanged: (val) => setState(() {
        selectedRecurring = val;
        if (val != "Other") {
          otherRecurringController.clear(); // Clear text when not "Other"
        }
      }),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
      ),
      onPressed: onPressed,
      child: Text(text, style: TextStyle(color: Colors.white)),
    );
  }
}
