import 'package:flutter/material.dart';

import '../models/address.dart';
import '../services/address_service.dart';
import 'address_form_screen.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  State<AddressListScreen> createState() =>
      _AddressListScreenState();
}

class _AddressListScreenState
    extends State<AddressListScreen> {
  final AddressService service = AddressService();

  List<Address> addresses = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();

    loadAddresses();
  }

  Future<void> loadAddresses() async {
    setState(() {
      loading = true;
    });

    try {
      final result = await service.getAddresses();

      setState(() {
        addresses = result;
        loading = false;
      });
    } catch (error) {
      setState(() {
        loading = false;
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Erro: $error',
          ),
        ),
      );
    }
  }

  Future<void> deleteAddress(
    Address address,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Excluir endereço',
          ),
          content: const Text(
            'Deseja realmente excluir este endereço?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },
              child: const Text(
                'Cancelar',
              ),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
              },
              child: const Text(
                'Excluir',
              ),
            ),
          ],
        );
      },
    );

    if (confirmed != true ||
        address.id == null) {
      return;
    }

    try {
      await service.deleteAddress(
        address.id!,
      );

      loadAddresses();
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Erro: $error',
          ),
        ),
      );
    }
  }

  Future<void> editAddress(
    Address address,
  ) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AddressFormScreen(
            address: address,
          );
        },
      ),
    );

    if (result == true) {
      loadAddresses();
    }
  }

  Future<void> createAddress() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const AddressFormScreen();
        },
      ),
    );

    if (result == true) {
      loadAddresses();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Easy Address',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createAddress,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: loadAddresses,
              child: ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  final address = addresses[index];

                  return ListTile(
                    leading: const CircleAvatar(
                      child: Icon(
                        Icons.location_on,
                      ),
                    ),
                    title: Text(
                      address.street,
                    ),
                    subtitle: Text(
                      '${address.city} - ${address.state}\n'
                      '${address.zipCode}',
                    ),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            editAddress(
                              address,
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteAddress(
                              address,
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}