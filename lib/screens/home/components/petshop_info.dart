import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

class PetShopList extends StatefulWidget {
  @override
  _PetShopListState createState() => _PetShopListState();
}

class _PetShopListState extends State<PetShopList> {
  List<PetShop> _petShops = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocationAndFetchPetShops();
  }

  Future<void> _getCurrentLocationAndFetchPetShops() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    await fetchPetShops(position.latitude, position.longitude);
  }

  Future<void> fetchPetShops(double latitude, double longitude) async {
    const String apiKey = 'fsq3Rzf7CM4plGH/8E3Xko4pXNcBKbN1siNnqs28ArVY4uQ=';

    final url = Uri.parse(
      'https://api.foursquare.com/v3/places/search?ll=${latitude.toStringAsFixed(6)},${longitude.toStringAsFixed(6)}&query=Pet Supplies Store&limit=50',
    );

    final response = await http.get(
      url,
      headers: {
        'Authorization': apiKey,
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['results'];
      List<PetShop> petShops =
          data.map((json) => PetShop.fromJson(json)).toList();

      setState(() {
        _petShops = petShops;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load pet shops');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Pet Shops'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _petShops.length,
              itemBuilder: (context, index) {
                final petShop = _petShops[index];
                return _petShopListItem(petShop);
              },
            ),
    );
  }

  Widget _petShopListItem(PetShop petShop) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(3.0, 3.0),
            blurRadius: 1.0,
            spreadRadius: 1.0,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: () {
          // Add your onPressed logic here
        },
        child: Row(
          children: [
            Column(
              children: [
                SvgPicture.asset(
                  'assets/icons/PetShopMarker.svg', // Replace with your icon path
                  width: 40,
                  height: 40,
                ),
                const SizedBox(height: 5),
                Text(
                  '${(petShop.distance / 1000).toStringAsFixed(2)} km',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    petShop.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    petShop.address,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
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

class PetShop {
  final String name;
  final String address;
  final double distance;

  PetShop({
    required this.name,
    required this.address,
    required this.distance,
  });

  factory PetShop.fromJson(Map<String, dynamic> json) {
    return PetShop(
      name: json['name'],
      address: json['location']['formatted_address'] ?? 'No address available',
      distance: json['distance']?.toDouble() ?? 0.0,
    );
  }
}
