import 'package:flutter/material.dart';
import 'package:kucing_otomatis/screens/smart/components/device_detail.dart';
import 'package:kucing_otomatis/screens/smart/components/schedule.dart';

class DeviceInfoScreen extends StatelessWidget {
  final String deviceName;
  final String imagePath;

  const DeviceInfoScreen({
    super.key,
    required this.deviceName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xff7469B6),
      appBar: AppBar(
        title: Text(deviceName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(
                imagePath,
                height: 200.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              deviceName,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            const Text(
              "Status Perangkat: On",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
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
                  foregroundColor: Colors.black),
              onPressed: () {
                // Handle Feed Now action
                print('Feed Now pressed');
              },
              child: const Text('Feed Now'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black
              ),
              onPressed: () {
                // Handle Schedule action
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ScheduleScreen(deviceName: deviceName),
                  ),
                );
                print('Schedule pressed');
              },
              child: const Text('Schedule'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, foregroundColor: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DeviceDetailScreen(deviceName: deviceName),
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
