import 'package:flutter/material.dart';
import 'package:kucing_otomatis/screens/qrscan/qr_scan_screen.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                    child: Text(
                  "My Home",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
                const SizedBox(width: 16),
                PopupMenuButton<String>(
                    icon: const Icon(Icons.add),
                    onSelected: (value) {
                      switch (value) {
                        case 'add_device':
                          print("add device pushed");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const QRScanScreen()),
                          );
                      }
                    },
                    itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'add_device',
                            child: Row(
                              children: [
                                Icon(Icons.add, color: Colors.black),
                                SizedBox(width: 8),
                                Text("Add Device"),
                              ],
                            ),
                          ),
                        ])
              ],
            ),
            const Row(
              children: [
                SizedBox(height: 100),
                Text(
                  "Cat Feeder Automation App",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )
              ],
            )
          ],
        ));
  }
}
