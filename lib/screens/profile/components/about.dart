import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
      ),
      backgroundColor: const Color(0xff7469B6),
      body: SingleChildScrollView(
        // Tambahkan SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/AutoPaw.jpg',
                  height: 200,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: const Text(
                  'AutoPaw adalah aplikasi inovatif yang dirancang untuk memberikan kenyamanan dan kemudahan dalam merawat hewan peliharaan kesayangan Anda. Dengan AutoPaw, Anda dapat mengatur jadwal makan otomatis untuk hewan peliharaan Anda, sehingga Anda tidak perlu khawatir lagi jika harus meninggalkan mereka sendirian di rumah. Aplikasi ini dilengkapi dengan berbagai fitur yang memungkinkan Anda memantau dan mengatur kebutuhan hewan peliharaan Anda secara efektif. Dengan AutoPaw, memastikan hewan peliharaan Anda selalu terawat dengan baik menjadi lebih mudah dan praktis.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              // Tambahkan widget tambahan di bawah jika diperlukan
            ],
          ),
        ),
      ),
    );
  }
}
