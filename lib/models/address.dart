class Address {
  final int? id;
  final String userName;
  final String zipCode;
  final String street;
  final String neighborhood;
  final String city;
  final String state;
  final String type;

  Address({
    this.id,
    required this.userName,
    required this.zipCode,
    required this.street,
    required this.neighborhood,
    required this.city,
    required this.state,
    required this.type,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      userName: json['nomeUsuario'] ?? '',
      zipCode: json['cep'] ?? '',
      street: json['logradouro'] ?? '',
      neighborhood: json['bairro'] ?? '',
      city: json['cidade'] ?? '',
      state: json['uf'] ?? '',
      type: json['tipo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nomeUsuario': userName,
      'cep': zipCode,
      'logradouro': street,
      'bairro': neighborhood,
      'cidade': city,
      'uf': state,
      'tipo': type,
    };
  }
}