import 'package:flutter/material.dart';
import 'package:kucing_otomatis/screens/smart/components/device_detail.dart';
import 'package:kucing_otomatis/screens/smart/components/schedule.dart';
import 'package:http/http.dart' as http;

class DeviceInfoScreen extends StatefulWidget {
  final String deviceName;
  final String imagePath;

  const DeviceInfoScreen({
    super.key,
    required this.deviceName,
    required this.imagePath,
  });

  @override
  _DeviceInfoScreenState createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  bool isDeviceOnline = false; // Default value
  bool isLoading = true; // Loading indicator

  @override
  void initState() {
    super.initState();
    checkDeviceStatus(); // Check device status when screen loads
  }

  Future<void> checkDeviceStatus() async {
    final response = await http.get(
      Uri.parse(
          'https://blynk.cloud/external/api/isHardwareConnected?token=oLIG87p8FBDcZeJorMYEddV1bKjvw-qH'),
    );

    if (response.statusCode == 200) {
      setState(() {
        isDeviceOnline = response.body == 'true';
        isLoading = false; // Stop loading when status is fetched
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal memeriksa status perangkat')),
      );
      setState(() {
        isLoading = false; // Stop loading even on failure
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff7469B6),
      appBar: AppBar(
        title: Text(widget.deviceName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(
                widget.imagePath,
                height: 200.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              widget.deviceName,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),

            // Status Perangkat
            isLoading
                ? const CircularProgressIndicator() // Show loading spinner while fetching status
                : Text(
                    isDeviceOnline
                        ? "Status Perangkat: Online"
                        : "Status Perangkat: Offline",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: isDeviceOnline ? Colors.green : Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),

            const SizedBox(height: 10.0),
            const Text(
              "Koneksi Internet: Tersambung",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10.0),
            const Text(
              "Kapasitas Pakan: Full 100%",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              onPressed: () async {
                final response = await http.post(
                  Uri.parse(
                    'https://profound-opossum-loudly.ngrok-free.app/api/feed-now',
                  ),
                );

                if (response.statusCode == 200) {
                  print('Feed Now action successful');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Makanan Kucing diberikan')),
                  );
                } else {
                  print('Failed to perform Feed Now action');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Gagal memberi makan kucing')),
                  );
                }
              },
              child: const Text('Feed Now'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ScheduleScreen(deviceName: widget.deviceName),
                  ),
                );
                print('Schedule pressed');
              },
              child: const Text('Schedule'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DeviceDetailScreen(deviceName: widget.deviceName),
                  ),
                );
              },
              child: const Text('Detail'),
            ),
          ],
        ),
      ),
    );
  }
}
