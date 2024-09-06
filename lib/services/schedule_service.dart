// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ScheduleService {
//   static const String baseUrl = 'http://10.0.2.2:3000';

//   Future<List<dynamic>> getAllSchedules() async {
//     final response = await http.get(Uri.parse('$baseUrl/schedules'));
//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load schedules');
//     }
//   }

//   Future<Map<String, dynamic>> getScheduleByDeviceName(
//       String deviceName) async {
//     final response =
//         await http.get(Uri.parse('$baseUrl/schedules/$deviceName'));
//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load schedule for $deviceName');
//     }
//   }

//   Future<void> createSchedule(Map<String, dynamic> schedule) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/schedules'),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode(schedule),
//     );
//     if (response.statusCode != 201) {
//       throw Exception('Failed to create schedule');
//     }
//   }

//   Future<void> updateSchedule(
//       String deviceName, Map<String, dynamic> schedule) async {
//     final response = await http.put(
//       Uri.parse('$baseUrl/schedules/$deviceName'),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode(schedule),
//     );
//     if (response.statusCode != 200) {
//       throw Exception('Failed to update schedule for $deviceName');
//     }
//   }

//   Future<void> deleteSchedule(String deviceName) async {
//     final response =
//         await http.delete(Uri.parse('$baseUrl/schedules/$deviceName'));
//     if (response.statusCode != 200) {
//       throw Exception('Failed to delete schedule for $deviceName');
//     }
//   }

//   Future<bool> scheduleExists(String deviceName) async {
//     try {
//       await getScheduleByDeviceName(deviceName);
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

class ScheduleService {
  // static const String baseUrl = 'http://10.0.2.2:3000';
  static const String baseUrl = 'https://profound-opossum-loudly.ngrok-free.app';

  Future<List<dynamic>> getAllSchedules() async {
    final response = await http.get(Uri.parse('$baseUrl/schedules'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load schedules');
    }
  }

  Future<Map<String, dynamic>> getScheduleByDeviceName(
      String deviceName) async {
    final response =
        await http.get(Uri.parse('$baseUrl/schedules/$deviceName'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load schedule for $deviceName');
    }
  }

  Future<void> createSchedule(Map<String, dynamic> schedule) async {
    final response = await http.post(
      Uri.parse('$baseUrl/schedules'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(schedule),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create schedule');
    }
  }

  Future<void> updateSchedule(
      String deviceName, Map<String, dynamic> schedule) async {
    final response = await http.put(
      Uri.parse('$baseUrl/schedules/$deviceName'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(schedule),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update schedule for $deviceName');
    }
  }

  Future<void> deleteSchedule(String deviceName) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/schedules/$deviceName'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete schedule for $deviceName');
    }
  }

  Future<bool> scheduleExists(String deviceName) async {
    try {
      await getScheduleByDeviceName(deviceName);
      return true;
    } catch (e) {
      return false;
    }
  }
}

