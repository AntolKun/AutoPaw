import 'package:http/http.dart' as http;
import 'dart:convert';

// Fungsi untuk mengambil data petshop terdekat menggunakan Nominatim API
Future<List<PetShop>> fetchNearbyPetShops(
    double latitude, double longitude) async {
  final response = await http.get(
    Uri.parse(
        'https://nominatim.openstreetmap.org/search?format=json&q=petshop&limit=10&lat=$latitude&lon=$longitude'),
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => PetShop.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load pet shops');
  }
}

class PetShop {
  final String name;
  final double latitude;
  final double longitude;

  PetShop(
      {required this.name, required this.latitude, required this.longitude});

  factory PetShop.fromJson(Map<String, dynamic> json) {
    return PetShop(
      name: json['display_name'],
      latitude: double.parse(json['lat']),
      longitude: double.parse(json['lon']),
    );
  }
}
