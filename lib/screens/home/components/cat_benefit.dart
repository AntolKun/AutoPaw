import 'package:flutter/material.dart';

class CatBenefitsPage extends StatelessWidget {
  final List<Map<String, String>> catBenefits = [
    {
      'title': 'Mengurangi Stres',
      'description':
          'Memelihara kucing dapat membantu mengurangi stres dan kecemasan. Suara mendengkur kucing dan kehadirannya yang menenangkan bisa memberikan rasa nyaman.',
      'image': 'assets/images/stress_reduction.jpg',
    },
    {
      'title': 'Teman Sejati',
      'description':
          'Kucing bisa menjadi teman yang setia dan penuh kasih. Mereka menawarkan persahabatan tanpa syarat dan bisa menjadi sumber kebahagiaan di rumah.',
      'image': 'assets/images/loyal_companion.jpg',
    },
    {
      'title': 'Meningkatkan Kesehatan Jantung',
      'description':
          'Penelitian menunjukkan bahwa memiliki kucing dapat mengurangi risiko penyakit jantung. Interaksi dengan kucing dapat menurunkan tekanan darah dan detak jantung.',
      'image': 'assets/images/heart_health.jpg',
    },
    {
      'title': 'Mengurangi Risiko Alergi pada Anak',
      'description':
          'Anak-anak yang tumbuh bersama hewan peliharaan seperti kucing cenderung memiliki risiko lebih rendah terkena alergi di kemudian hari.',
      'image': 'assets/images/reduced_allergies.jpg',
    },
    {
      'title': 'Meningkatkan Mood',
      'description':
          'Kucing dapat membantu meningkatkan mood dan mengurangi perasaan kesepian, terutama bagi mereka yang tinggal sendiri.',
      'image': 'assets/images/improve_mood.jpg',
    },
    {
      'title': 'Meningkatkan Rasa Tanggung Jawab',
      'description':
          'Memelihara kucing mengajarkan rasa tanggung jawab karena harus merawat dan memberikan perhatian secara rutin kepada mereka.',
      'image': 'assets/images/responsibility.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manfaat Memelihara Kucing'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: catBenefits.length,
        itemBuilder: (context, index) {
          final benefit = catBenefits[index];
          return _buildBenefitItem(
              benefit['title']!, benefit['description']!, benefit['image']!);
        },
      ),
    );
  }

  Widget _buildBenefitItem(String title, String description, String imagePath) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imagePath,
                height: 80.0,
                width: 80.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
