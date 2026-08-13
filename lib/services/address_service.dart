import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/address.dart';

class AddressService {
  static const String baseUrl =
      'https://easy-address-app-15d989ca7c47.herokuapp.com';

  static const String endpoint = '/addresses';

  Future<List<Address>> getAddresses() async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);

      return jsonList.map((json) => Address.fromJson(json)).toList();
    }

    throw Exception('Erro ao carregar endereços');
  }

  Future<Address> getAddressById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint/$id'));

    if (response.statusCode == 200) {
      return Address.fromJson(jsonDecode(response.body));
    }

    throw Exception('Endereço não encontrado');
  }

  Future<Address> createAddress(Address address) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(address.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Address.fromJson(jsonDecode(response.body));
    }

    throw Exception('Erro ao cadastrar endereço');
  }

  Future<Address> updateAddress(int id, Address address) async {
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(address.toJson()),
    );

    if (response.statusCode == 200) {
      return Address.fromJson(jsonDecode(response.body));
    }

    throw Exception('Erro ao atualizar endereço');
  }

  Future<void> deleteAddress(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl$endpoint/$id'));

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Erro ao excluir endereço');
    }
  }

  Future<Address> getAddressByZipCode(String zipCode) async {
    final response = await http.get(Uri.parse('$baseUrl/cep/$zipCode'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      return Address(
        userName: '',
        zipCode: json['cep'] ?? '',
        street: json['logradouro'] ?? '',
        neighborhood: json['bairro'] ?? '',
        city: json['cidade'] ?? '',
        state: json['uf'] ?? '',
        type: '',
      );
    }

    throw Exception('CEP não encontrado');
  }
}