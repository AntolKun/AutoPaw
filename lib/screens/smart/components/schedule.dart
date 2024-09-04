// import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart'; // Add this import for date formatting
// import 'package:kucing_otomatis/services/schedule_service.dart';

// class ScheduleScreen extends StatefulWidget {
//   final String deviceName;

//   const ScheduleScreen({Key? key, required this.deviceName}) : super(key: key);

//   @override
//   _ScheduleScreenState createState() => _ScheduleScreenState();
// }

// class _ScheduleScreenState extends State<ScheduleScreen> {
//   final ScheduleService _scheduleService = ScheduleService();
//   List<Map<String, dynamic>> schedules = [
//     {'time': TimeOfDay.now(), 'amount': 0},
//   ];

//   void _addSchedule() {
//     setState(() {
//       schedules.add({'time': TimeOfDay.now(), 'amount': 0});
//     });
//   }

//   void _removeSchedule(int index) {
//     setState(() {
//       schedules.removeAt(index);
//     });
//   }

//   void _pickTime(BuildContext context, int index) async {
//     final pickedTime = await showTimePicker(
//       context: context,
//       initialTime: schedules[index]['time'],
//     );
//     if (pickedTime != null) {
//       setState(() {
//         schedules[index]['time'] = pickedTime;
//       });
//     }
//   }

//   Map<String, dynamic> _convertSchedulesToJson() {
//     return {
//       'schedules': schedules.map((schedule) {
//         final timeOfDay = schedule['time'] as TimeOfDay;
//         final timeString =
//             '${timeOfDay.hour.toString().padLeft(2, '0')}:${timeOfDay.minute.toString().padLeft(2, '0')}';
//         return {
//           'time': timeString,
//           'amount': schedule['amount'],
//         };
//       }).toList(),
//     };
//   }

//   Future<void> _submitSchedules() async {
//     try {
//       // Coba periksa apakah jadwal dengan deviceName sudah ada
//       bool exists = await _scheduleService.scheduleExists(widget.deviceName);
//       if (exists) {
//         // Jika ada, perbarui jadwal
//         await _scheduleService.updateSchedule(
//             widget.deviceName, _convertSchedulesToJson());
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Schedules updated successfully')),
//         );
//       } else {
//         // Jika tidak ada, buat jadwal baru
//         await _scheduleService.createSchedule({
//           'deviceName': widget.deviceName,
//           ..._convertSchedulesToJson(),
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Schedules created successfully')),
//         );
//       }
//     } catch (e) {
//       // Tangani kesalahan
//       print('Failed to submit schedules: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Schedule Feeding for ${widget.deviceName}'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: schedules.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     margin: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: GestureDetector(
//                                   onTap: () => _pickTime(context, index),
//                                   child: AbsorbPointer(
//                                     child: TextFormField(
//                                       decoration: InputDecoration(
//                                         labelText: 'Time',
//                                         hintText: schedules[index]['time']
//                                             .format(context),
//                                       ),
//                                       controller: TextEditingController(
//                                         text: schedules[index]['time']
//                                             .format(context),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 16.0),
//                               Expanded(
//                                 child: TextFormField(
//                                   decoration: const InputDecoration(
//                                     labelText: 'Amount',
//                                   ),
//                                   keyboardType: TextInputType.number,
//                                   initialValue:
//                                       schedules[index]['amount'].toString(),
//                                   onChanged: (value) {
//                                     setState(() {
//                                       schedules[index]['amount'] =
//                                           int.tryParse(value) ?? 0;
//                                     });
//                                   },
//                                 ),
//                               ),
//                               IconButton(
//                                 icon: const Icon(Icons.delete),
//                                 onPressed: () => _removeSchedule(index),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xff7469B6)),
//                     onPressed: _addSchedule,
//                     child: const Text('+ Add Schedule'),
//                   ),
//                 ),
//                 const SizedBox(width: 16.0),
//                 Expanded(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff7469B6)),
//                     onPressed: _submitSchedules,
//                     child: const Text('Submit Schedules'),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import untuk format tanggal
import 'package:kucing_otomatis/services/schedule_service.dart';

class ScheduleScreen extends StatefulWidget {
  final String deviceName;

  const ScheduleScreen({Key? key, required this.deviceName}) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final ScheduleService _scheduleService = ScheduleService();
  List<Map<String, dynamic>> schedules = [
    {'time': TimeOfDay.now()}
  ];

  String? startDate;

  void _pickTime(BuildContext context, int index) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: schedules[index]['time'],
    );
    if (pickedTime != null) {
      setState(() {
        schedules[index]['time'] = pickedTime;
      });
    }
  }

  Future<void> _pickDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        startDate = DateFormat('yyyy-MM-dd')
            .format(pickedDate); // Use format YYYY-MM-DD
      });
    }
  }

  Map<String, dynamic> _convertSchedulesToJson() {
    return {
      'deviceName': widget.deviceName,
      'startDate': startDate,
      'time': schedules.first['time']
          .format(context), // Only send the first schedule time
    };
  }

  Future<void> _submitSchedules() async {
    if (startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a start date')),
      );
      return;
    }

    try {
      bool exists = await _scheduleService.scheduleExists(widget.deviceName);
      if (exists) {
        await _scheduleService.updateSchedule(
          widget.deviceName,
          _convertSchedulesToJson(),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Schedules updated successfully')),
        );
      } else {
        await _scheduleService.createSchedule({
          'deviceName': widget.deviceName,
          ..._convertSchedulesToJson(),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Schedules created successfully')),
        );
      }
    } catch (e) {
      print('Failed to submit schedules: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to submit schedules')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Feeding for ${widget.deviceName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Start Date: ${startDate ?? 'Select Date'}'),
              trailing: Icon(Icons.calendar_today),
              onTap: () => _pickDate(context),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: schedules.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _pickTime(context, index),
                              child: AbsorbPointer(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Time',
                                    hintText: schedules[index]['time']
                                        .format(context),
                                  ),
                                  controller: TextEditingController(
                                    text: schedules[index]['time']
                                        .format(context),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff7469B6),
              ),
              onPressed: _submitSchedules,
              child: const Text('Submit Schedules'),
            ),
          ],
        ),
      ),
    );
  }
}


