import 'package:flutter/material.dart';
import 'package:kucing_otomatis/screens/home/components/cat_benefit.dart';
import 'package:kucing_otomatis/screens/home/components/cat_types.dart';
import 'package:kucing_otomatis/screens/home/components/food_info.dart';
import 'package:kucing_otomatis/screens/home/components/petshop_info.dart';

class CatInfoGrid extends StatelessWidget {
  const CatInfoGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 600, // Adjusted height
      ),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 20.0, // Adjusted spacing
        mainAxisSpacing: 20.0, // Adjusted spacing
        padding: const EdgeInsets.all(16.0), // Added padding
        children: [
          _buildGridItem(
            context,
            'Type of Cat',
            'assets/images/tipekucing.jpg',
            Icons.pets,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CatTypesPage(),
                ),
              );
            },
          ),
          _buildGridItem(
            context,
            'Cat Food Info',
            'assets/images/infocatfood.jpg',
            Icons.fastfood,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CatFoodInfoPage(),
                ),
              );
            },
          ),
          _buildGridItem(
            context,
            'Pet Shop Info',
            'assets/images/petshop.jpg',
            Icons.store,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PetShopList(),
                ),
              );
            },
          ),
          _buildGridItem(
            context,
            'Cat Benefits Info',
            'assets/images/catbenefit.png',
            Icons.health_and_safety,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CatBenefitsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(
    BuildContext context,
    String label,
    String imagePath,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          gradient: const LinearGradient(
            colors: [Colors.pinkAccent, Colors.orangeAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(3, 3),
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 12.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(
                imagePath,
                height: 70.0,
                width: 70.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
