import 'package:flutter/material.dart';

import '../models/address.dart';
import '../services/address_service.dart';

class AddressFormScreen extends StatefulWidget {
  final Address? address;

  const AddressFormScreen({super.key, this.address});

  @override
  State<AddressFormScreen> createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends State<AddressFormScreen> {
  final AddressService service = AddressService();

  final userNameController = TextEditingController();
  final streetController = TextEditingController();
  final neighborhoodController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipCodeController = TextEditingController();
  final typeController = TextEditingController();

  bool loading = false;

  @override
  void initState() {
    super.initState();

    final address = widget.address;

    if (address != null) {
      userNameController.text = address.userName;
      streetController.text = address.street;
      neighborhoodController.text = address.neighborhood;
      cityController.text = address.city;
      stateController.text = address.state;
      zipCodeController.text = address.zipCode;
      typeController.text = address.type;
    }
  }

  Future<void> save() async {
    setState(() {
      loading = true;
    });

    final address = Address(
      userName: userNameController.text,
      zipCode: zipCodeController.text,
      street: streetController.text,
      neighborhood: neighborhoodController.text,
      city: cityController.text,
      state: stateController.text,
      type: typeController.text,
    );

    try {
      if (widget.address == null) {
        await service.createAddress(address);
      } else {
        await service.updateAddress(widget.address!.id!, address);
      }

      if (!mounted) return;

      Navigator.pop(context, true);
    } catch (error) {
      if (!mounted) return;

      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro: $error')));
    }
  }

  Future<void> searchZipCode() async {
    final zipCode = zipCodeController.text.trim();

    if (zipCode.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Informe um CEP')));

      return;
    }

    try {
      final address = await service.getAddressByZipCode(zipCode);

      streetController.text = address.street;
      neighborhoodController.text = address.neighborhood;
      cityController.text = address.city;
      stateController.text = address.state;
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao buscar CEP: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.address != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(editing ? 'Editar endereço' : 'Novo endereço'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: userNameController,
              decoration: const InputDecoration(labelText: 'Nome do usuário'),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: zipCodeController,
              decoration: InputDecoration(
                labelText: 'CEP',
                hintText: '01001-000',
                suffixIcon: IconButton(
                  onPressed: searchZipCode,
                  icon: const Icon(Icons.search),
                ),
              ),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 12),

            TextField(
              controller: streetController,
              decoration: const InputDecoration(labelText: 'Logradouro'),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: neighborhoodController,
              decoration: const InputDecoration(labelText: 'Bairro'),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: cityController,
              decoration: const InputDecoration(labelText: 'Cidade'),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: stateController,
              decoration: const InputDecoration(labelText: 'UF'),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: typeController,
              decoration: const InputDecoration(
                labelText: 'Tipo',
                hintText: 'Ex.: residencial',
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: loading ? null : save,
                child: loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Salvar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    userNameController.dispose();
    streetController.dispose();
    neighborhoodController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipCodeController.dispose();
    typeController.dispose();

    super.dispose();
  }
}