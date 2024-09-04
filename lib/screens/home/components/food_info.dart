import 'package:flutter/material.dart';

class CatFoodInfoPage extends StatelessWidget {
  final List<Map<String, String>> catFoods = [
    {
      'name': 'Makanan Kering',
      'description':
          'Makanan kering mudah disajikan dan membantu menjaga kesehatan gigi kucing. Makanan ini juga memiliki umur simpan yang lebih lama dibandingkan dengan makanan basah.',
      'image': 'assets/images/dry_cat_food.jpg',
    },
    {
      'name': 'Makanan Basah',
      'description':
          'Makanan basah mengandung lebih banyak kelembapan dan biasanya lebih disukai oleh kucing. Makanan ini bisa membantu kucing yang membutuhkan hidrasi tambahan.',
      'image': 'assets/images/wet_cat_food.jpg',
    },
    {
      'name': 'Makanan Bebas Gandum',
      'description':
          'Makanan bebas gandum diformulasikan tanpa biji-bijian dan cocok untuk kucing dengan alergi atau sensitivitas tertentu.',
      'image': 'assets/images/grain_free_cat_food.jpg',
    },
    {
      'name': 'Makanan Anak Kucing',
      'description':
          'Makanan anak kucing khusus dirancang untuk memenuhi kebutuhan nutrisi anak kucing yang sedang tumbuh, dengan kandungan protein dan lemak yang lebih tinggi.',
      'image': 'assets/images/kitten_food.jpg',
    },
    {
      'name': 'Makanan Kucing Senior',
      'description':
          'Makanan kucing senior diformulasikan untuk memenuhi kebutuhan diet kucing yang lebih tua, dengan tambahan nutrisi untuk kesehatan sendi dan ginjal.',
      'image': 'assets/images/senior_cat_food.jpg',
    },
    {
      'name': 'Diet Resep',
      'description':
          'Diet resep adalah makanan kucing khusus yang direkomendasikan oleh dokter hewan untuk kucing dengan kondisi kesehatan tertentu.',
      'image': 'assets/images/prescription_cat_food.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info Makanan Kucing'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: catFoods.length,
        itemBuilder: (context, index) {
          final catFood = catFoods[index];
          return _buildCatFoodItem(
              catFood['name']!, catFood['description']!, catFood['image']!);
        },
      ),
    );
  }

  Widget _buildCatFoodItem(String name, String description, String imagePath) {
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
                    name,
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
