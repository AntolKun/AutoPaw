import 'package:http/http.dart' as http;
import 'dart:convert';

class BlynkService {
  final String _blynkToken =
      'your_blynk_token_here'; // Replace with your Blynk token

  Future<bool> getDeviceStatus(String deviceId) async {
    final url = 'http://blynk-cloud.com/$_blynkToken/get/v1/$deviceId';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['status'] == 'online';
      } else {
        throw Exception('Failed to fetch device status');
      }
    } catch (e) {
      print('Error getting device status: $e');
      return false;
    }
  }

  Future<String> getNextFeedingSchedule() async {
    final url = 'http://blynk-cloud.com/$_blynkToken/get/V1';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Assuming the response contains a JSON object with 'value' field for V1
        String timestamp = data['value'] ?? 'No upcoming feeding';
        return _formatTimestamp(timestamp);
      } else {
        throw Exception('Failed to fetch next feeding schedule');
      }
    } catch (e) {
      print('Error getting next feeding schedule: $e');
      return 'Error retrieving schedule';
    }
  }

  String _formatTimestamp(String timestamp) {
    try {
      final dateTime = DateTime.parse(timestamp);
      // Format as needed
      return '${dateTime.day}-${dateTime.month}-${dateTime.year} ${dateTime.hour}:${dateTime.minute} WIB';
    } catch (e) {
      print('Error parsing timestamp: $e');
      return 'Invalid date format';
    }
  }
}
