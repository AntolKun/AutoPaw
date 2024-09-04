import 'package:flutter/material.dart';

class CatTypesPage extends StatelessWidget {
  final List<Map<String, String>> catTypes = [
    {
      'name': 'Persian',
      'image': 'assets/images/persian_cat.jpg',
    },
    {
      'name': 'Siamese',
      'image': 'assets/images/siamese_cat.jpg',
    },
    {
      'name': 'Maine Coon',
      'image': 'assets/images/maine_coon.jpg',
    },
    {
      'name': 'Sphynx',
      'image': 'assets/images/sphynx_cat.jpg',
    },
    {
      'name': 'Ragdoll',
      'image': 'assets/images/ragdoll_cat.jpg',
    },
    {
      'name': 'Bengal',
      'image': 'assets/images/bengal_cat.jpg',
    },
    // Add more cat types as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Types of Cats'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: catTypes.length,
        itemBuilder: (context, index) {
          final catType = catTypes[index];
          return _buildCatTypeItem(catType['name']!, catType['image']!);
        },
      ),
    );
  }

  Widget _buildCatTypeItem(String name, String imagePath) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.asset(
            imagePath,
            height: 100.0,
            width: 100.0,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          name,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
