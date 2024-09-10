import 'package:flutter/material.dart';
import 'package:kucing_otomatis/screens/smart/components/device_info.dart';

class DeviceInfoGrid extends StatelessWidget {
  const DeviceInfoGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 500,
      ),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildGridItem(
            context,
            'Pakan Kucing',
            'assets/images/alat.jpg',
            () => _navigateToDeviceInfo(
                context, 'Pakan Kucing', 'assets/images/alat.jpg'),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(
    BuildContext context,
    String label,
    String imagePath,
    VoidCallback onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 4),
                blurRadius: 8.0,
              ),
            ],
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset(
                  imagePath,
                  height: 140.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              Positioned(
                bottom: 20.0,
                left: 10.0,
                right: 10.0,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 2),
                        blurRadius: 4.0,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToDeviceInfo(
      BuildContext context, String deviceName, String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeviceInfoScreen(
          deviceName: deviceName,
          imagePath: imagePath,
        ),
      ),
    );
  }
}
