import 'package:flutter/material.dart';

class ChatWithAdvisorPage extends StatefulWidget {
  const ChatWithAdvisorPage({super.key});

  @override
  State<ChatWithAdvisorPage> createState() => _ChatWithAdvisorPageState();
}

class _ChatWithAdvisorPageState extends State<ChatWithAdvisorPage> {
  final TextEditingController _phoneController = TextEditingController();
  String? _selectedTopic;
  String? _selectedAdvisor;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  final List<String> _topics = ['Investments', 'Savings', 'Loans', 'Retirement'];
  final List<String> _advisors = ['John Doe', 'Jane Smith', 'Alex Johnson'];

  void _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _selectTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _submitForm() {
    if (_selectedTopic == null ||
        _selectedAdvisor == null ||
        _selectedDate == null ||
        _selectedTime == null ||
        _phoneController.text.isEmpty ||
        !_isValidPhoneNumber(_phoneController.text)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: const Text("Please fill out all fields correctly."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    // Navigate to confirmation page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmationPage(
          topic: _selectedTopic!,
          advisor: _selectedAdvisor!,
          date: _selectedDate!,
          time: _selectedTime!,
          phoneNumber: _phoneController.text,
        ),
      ),
    );
  }

  bool _isValidPhoneNumber(String phone) {
    final phoneRegex = RegExp(r'^\+?[0-9\s\-]{10,15}$');
    return phoneRegex.hasMatch(phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat with Advisor',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Financial Topic Dropdown
              const Text(
                'I need help with:',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedTopic,
                items: _topics
                    .map((topic) => DropdownMenuItem(
                          value: topic,
                          child: Text(topic),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTopic = value;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Select Financial Topic',
                ),
              ),
              const SizedBox(height: 16),
              // Advisor Dropdown
              const Text(
                'Advisor:',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedAdvisor,
                items: _advisors
                    .map((advisor) => DropdownMenuItem(
                          value: advisor,
                          child: Text(advisor),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedAdvisor = value;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Select Advisor',
                ),
              ),
              const SizedBox(height: 16),
              // Date and Time Pickers
              const Text(
                'Please enter your preferred appointment time:',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _selectDate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                    ),
                    child: Text(
                      _selectedDate == null
                          ? 'Select Date'
                          : '${_selectedDate!.month}/${_selectedDate!.day}/${_selectedDate!.year}',
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _selectTime,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                    ),
                    child: Text(
                      _selectedTime == null
                          ? 'Select Time'
                          : _selectedTime!.format(context),
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Phone Number Input
              const Text(
                'Phone Number:',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: 'Enter your phone number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Centered Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    backgroundColor: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConfirmationPage extends StatelessWidget {
  final String topic;
  final String advisor;
  final DateTime date;
  final TimeOfDay time;
  final String phoneNumber;

  const ConfirmationPage({
    super.key,
    required this.topic,
    required this.advisor,
    required this.date,
    required this.time,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Confirmed!"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 100,
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                "Booking Confirmed!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Appointment Details:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text("Topic: $topic"),
            Text("Advisor: $advisor"),
            Text("Date: ${date.month}/${date.day}/${date.year}"),
            Text("Time: ${time.format(context)}"),
            Text("Phone: $phoneNumber"),
            const SizedBox(height: 32),
            // Button to navigate back to the home screen
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  backgroundColor: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Go to Home",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}