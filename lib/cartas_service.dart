//Criar um serviço que vai ao endpoint https://deckofcardsapi.com/api/deck/new/draw/?count=10 e retorna uma classe Cartas
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'cartas.dart';

class CartasService {
  Future<Cartas> getCartas() async {
    final response = await http.get(
        Uri.parse('https://deckofcardsapi.com/api/deck/new/draw/?count=10'));

    if (response.statusCode == 200) {
      return Cartas.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load cartas');
    }
  }
}
