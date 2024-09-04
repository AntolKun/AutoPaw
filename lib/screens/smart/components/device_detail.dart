// import 'package:flutter/material.dart';
// import 'package:kucing_otomatis/services/schedule_service.dart';

// class DeviceDetailScreen extends StatefulWidget {
//   final String deviceName;

//   const DeviceDetailScreen({Key? key, required this.deviceName})
//       : super(key: key);

//   @override
//   _DeviceDetailScreenState createState() => _DeviceDetailScreenState();
// }

// class _DeviceDetailScreenState extends State<DeviceDetailScreen> {
//   final ScheduleService _scheduleService = ScheduleService();
//   List<Map<String, dynamic>> _schedules = [];
//   String _nextFeedingTime = '';

//   @override
//   void initState() {
//     super.initState();
//     _fetchSchedules();
//   }

//   Future<void> _fetchSchedules() async {
//     try {
//       final scheduleData =
//           await _scheduleService.getScheduleByDeviceName(widget.deviceName);
//       setState(() {
//         _schedules = (scheduleData['schedules'] as List<dynamic>)
//             .map((schedule) => schedule as Map<String, dynamic>)
//             .toList();
//         _calculateNextFeedingTime();
//       });
//     } catch (e) {
//       // Handle error
//       print('Failed to load schedules: $e');
//     }
//   }

//   void _calculateNextFeedingTime() {
//     if (_schedules.isEmpty) {
//       return;
//     }

//     final now = TimeOfDay.now();
//     final nextTimes = _schedules
//         .map((schedule) {
//           final timeParts = (schedule['time'] as String).split(':');
//           final hour = int.parse(timeParts[0]);
//           final minute = int.parse(timeParts[1]);
//           return TimeOfDay(hour: hour, minute: minute);
//         })
//         .where((time) =>
//             time.hour > now.hour ||
//             (time.hour == now.hour && time.minute > now.minute))
//         .toList();

//     if (nextTimes.isNotEmpty) {
//       _nextFeedingTime = nextTimes.first.format(context);
//     } else {
//       _nextFeedingTime = TimeOfDay(
//         hour: int.parse(_schedules[0]['time'].split(':')[0]),
//         minute: int.parse(_schedules[0]['time'].split(':')[1]),
//       ).format(context);
//     }

//     _nextFeedingTime += " WIB";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xff7469B6),
//       appBar: AppBar(
//         title: Text(widget.deviceName),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 widget.deviceName,
//                 style: const TextStyle(
//                   fontSize: 28.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 16.0),
//               const Text(
//                 "Status perangkat: On",
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 10.0),
//               const Text(
//                 "Koneksi Internet: Terhubung",
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 10.0),
//               const Text(
//                 "Feed Capacity: 100%",
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 25.0),
//               _buildScheduleList(),
//               const SizedBox(height: 25.0),
//               const Text(
//                 "Next Feeding Schedule:",
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 10.0),
//               Text(
//                 _nextFeedingTime,
//                 style: const TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.green,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildScheduleList() {
//     return ListView.builder(
//       shrinkWrap: true,
//       itemCount: _schedules.length,
//       itemBuilder: (context, index) {
//         final schedule = _schedules[index];
//         return Center(
//           child: ListTile(
//             title: Text(
//               "Waktu: ${schedule['time']} WIB",
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             subtitle: Text(
//               "Jumlah: ${schedule['amount']} grm",
//               textAlign: TextAlign.center,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:kucing_otomatis/services/schedule_service.dart';

class DeviceDetailScreen extends StatefulWidget {
  final String deviceName;

  const DeviceDetailScreen({Key? key, required this.deviceName})
      : super(key: key);

  @override
  _DeviceDetailScreenState createState() => _DeviceDetailScreenState();
}

class _DeviceDetailScreenState extends State<DeviceDetailScreen> {
  final ScheduleService _scheduleService = ScheduleService();
  List<Map<String, dynamic>> _schedules = [];
  String _nextFeedingTime = '';
  String? _startDate;
  String? _endDate;

  @override
  void initState() {
    super.initState();
    _fetchSchedules();
  }

  Future<void> _fetchSchedules() async {
    try {
      final scheduleData =
          await _scheduleService.getScheduleByDeviceName(widget.deviceName);

      setState(() {
        _startDate = scheduleData['startDate'];
        _endDate = scheduleData['endDate'];
        _schedules = (scheduleData['schedules'] as List<dynamic>)
            .map((schedule) => schedule as Map<String, dynamic>)
            .toList();
        _calculateNextFeedingTime();
      });
    } catch (e) {
      print('Failed to load schedules: $e');
      // Handle error properly, maybe show a SnackBar or error message
    }
  }

  void _calculateNextFeedingTime() {
    if (_schedules.isEmpty) {
      _nextFeedingTime = 'No upcoming feedings';
      return;
    }

    final now = TimeOfDay.now();
    final nextTimes = _schedules
        .map((schedule) {
          final timeParts = (schedule['time'] as String).split(':');
          final hour = int.parse(timeParts[0]);
          final minute = int.parse(timeParts[1]);
          return TimeOfDay(hour: hour, minute: minute);
        })
        .where((time) =>
            time.hour > now.hour ||
            (time.hour == now.hour && time.minute > now.minute))
        .toList();

    if (nextTimes.isNotEmpty) {
      _nextFeedingTime = nextTimes.first.format(context);
    } else {
      _nextFeedingTime = TimeOfDay(
        hour: int.parse(_schedules[0]['time'].split(':')[0]),
        minute: int.parse(_schedules[0]['time'].split(':')[1]),
      ).format(context);
    }

    _nextFeedingTime += " WIB";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff7469B6),
      appBar: AppBar(
        title: Text(widget.deviceName),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.deviceName,
                style: const TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              _buildDeviceStatus(),
              const SizedBox(height: 25.0),
              _buildDateRange(),
              const SizedBox(height: 25.0),
              _buildScheduleList(),
              const SizedBox(height: 25.0),
              const Text(
                "Next Feeding Schedule:",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),
              Text(
                _nextFeedingTime,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 231, 248),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceStatus() {
    return const Column(
      children: [
        Text(
          "Status perangkat: On",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.0),
        Text(
          "Koneksi Internet: Terhubung",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.0),
        Text(
          "Feed Capacity: 100%",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDateRange() {
    return Column(
      children: [
        Text(
          "Tanggal Mulai: ${_startDate ?? 'Not set'}",
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10.0),
        Text(
          "Tanggal Selesai: ${_endDate ?? 'Not set'}",
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildScheduleList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _schedules.length,
      itemBuilder: (context, index) {
        final schedule = _schedules[index];
        return Center(
          child: ListTile(
            title: Text(
              "Waktu: ${schedule['time']} WIB",
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              style: const TextStyle(color: Color.fromARGB(255, 0, 231, 248)),
              "Jumlah: ${schedule['amount']} grm",
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
