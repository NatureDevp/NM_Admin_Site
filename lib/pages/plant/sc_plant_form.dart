import 'dart:io';
import 'dart:typed_data';
import 'package:admin_new/api/api_plant.dart';
import 'package:admin_new/utils/_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'dart:html' as html;

import 'package:get/get.dart';

import '../../models/md_plant.dart';

class PlantFormPage extends StatefulWidget {
  const PlantFormPage({super.key});

  @override
  State<PlantFormPage> createState() => _PlantFormPageState();
}

class _PlantFormPageState extends State<PlantFormPage> {
  final _formkey = GlobalKey<FormState>();

  final _plantNameController = TextEditingController();

  final _descriptionController = TextEditingController();

  final _scientificNameController = TextEditingController();

  final _symptomsController = TextEditingController();

  String _status = 'Inactive';

  Map<String, html.File>? _cover;
  Uint8List? _coverMemory;
  final List<Map<String, html.File>> _otherImages = [];
  final List<Map<String, Uint8List>> _otherImagesMemory = [];

  final List<String> _symptoms = [];
  void _pickCoverImage() {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((e) async {
      final files = uploadInput.files;
      if (files!.isNotEmpty) {
        var reader = html.FileReader();
        reader.readAsArrayBuffer(files[0]);

        await reader.onLoad.first;
        _coverMemory = reader.result as Uint8List;

        setState(() {
          _cover = {files[0].name: files[0]};
        });
      }
    });
  }

  void _pickMultipleImages() {
    int UploadLimit = 4;
    if (_otherImages.length >= UploadLimit) {
      return;
    }

    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.multiple = true;

    uploadInput.click();

    uploadInput.onChange.listen((e) async {
      final files = uploadInput.files;
      if (files != null && files.isNotEmpty) {
        int i = 0;
        for (var file in files) {
          if (i >= UploadLimit) {
            break;
          }

          var reader = html.FileReader();
          reader.readAsArrayBuffer(file);

          await reader.onLoad.first;
          var memory = reader.result as Uint8List;
          String name = file.name;
          html.File newFile = file;
          setState(() {
            _otherImages.add({name: newFile});
            _otherImagesMemory.add({name: memory});
          });

          i++;
        }
      }
    });
  }

  void _addSymptom() {
    if (_symptomsController.text.isNotEmpty) {
      setState(() {
        _symptoms.add(_symptomsController.text);
        _symptomsController.clear();
      });
    }
  }

  void _statusToggle() {
    setState(() {
      _status = _status == 'Inactive' ? 'Active' : 'Inactive';
    });
  }

  void _submitForm() async {
    if (!_formkey.currentState!.validate() ||
        _cover == null ||
        _otherImages.isEmpty ||
        _symptoms.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: const Text('Please fill in all fields'),
          backgroundColor: CustomColors.error.normal,
        ),
      );
      return;
    }

    var result = await APIPlant.uploadPlants(
      Plants(
        id: 0,
        name: _plantNameController.text,
        scientific_name: _scientificNameController.text,
        description: _descriptionController.text,
        ailment: _symptoms,
        status: _status,
        likes: 0,
        date_created: DateTime.now().toString(),
        last_updated: DateTime.now().toString(),
        cover: '',
      ),
      _cover!,
      _otherImages,
    );

    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(result!['message'].toString()),
        backgroundColor: CustomColors.primary.normal,
      ),
    );

    _formkey.currentState!.reset();
    _cover = null;
    _otherImages.clear();
    _otherImagesMemory.clear();
    _coverMemory = null;
    _symptoms.clear();
    _status = 'Inactive';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Herbal'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              width: 900,
              constraints: const BoxConstraints(maxHeight: 860),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Plant Information',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Divider(
                    color: CustomColors.dark.medium,
                    thickness: 1.5,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              _buildTextField('Plant name:'),
                              const Gap(16),
                              _buildTextField('Scientific name:'),
                              const Gap(16),
                              _buildDescriptionField('Description:'),
                            ],
                          ),
                        ),
                      ),
                      const Gap(20),
                      Expanded(
                        flex: 1,
                        child: _buildImageUploadSection(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  _statusSection(context),
                  const SizedBox(height: 30),
                  _buildOtherImagesSection(),
                  const SizedBox(height: 30),
                  _buildAilmentSection(),
                  const SizedBox(height: 30),
                  const Spacer(),
                  _buildActionButtons(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 200.0),
      child: Divider(
        color: CustomColors.dark.lighter,
      ),
    );
  }

  Widget _statusSection(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Status:'),
        const Gap(10),
        MaterialButton(
          textColor: _status == 'Active'
              ? CustomColors.primary.normal
              : CustomColors.secondary.normal,
          color: _status == 'Active'
              ? CustomColors.primary.lightest
              : CustomColors.secondary.lightest,
          shape: BeveledRectangleBorder(
            side: BorderSide(
              color: _status == 'Active'
                  ? CustomColors.primary.normal
                  : CustomColors.secondary.normal,
            ),
          ),
          onPressed: _statusToggle,
          child: Text(_status),
        ),
      ],
    );
  }

  Widget _buildTextField(String label) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDescriptionField(String label) {
    return TextFormField(
      maxLines: 4,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildImageUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          constraints: const BoxConstraints(minHeight: 210),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: _cover == null
              ? Image.asset(
                  'assets/images/default_image.png',
                )
              : Image.memory(_coverMemory!),
        ),
        const Gap(6),
        MaterialButton(
          textColor: CustomColors.primary.normal,
          color: CustomColors.primary.lightest,
          shape: BeveledRectangleBorder(
            side: BorderSide(color: CustomColors.primary.normal),
          ),
          onPressed: () => _pickCoverImage(),
          child: const Text('Upload Cover'),
        ),
      ],
    );
  }

  Widget _buildOtherImagesSection() {
    return Container(
      padding: const EdgeInsets.all(14),
      color: CustomColors.secondary.lightest,
      width: double.infinity,
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Other Images:',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const Gap(6),
          Row(
            children: [
              IconButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(BeveledRectangleBorder(
                    side: BorderSide(color: CustomColors.primary.normal),
                  )),
                  backgroundColor: WidgetStateProperty.all(
                    CustomColors.primary.lightest,
                  ),
                  foregroundColor: WidgetStateProperty.all(
                    CustomColors.primary.normal,
                  ),
                ),
                onPressed: _pickMultipleImages,
                icon: const Icon(Icons.add),
              ),
              ..._otherImagesMemory.asMap().entries.map((entry) {
                final index = entry.key;
                final key = entry.value.keys.first;
                final image = _otherImagesMemory[index][key]!;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Chip(
                    label: const Text(''),
                    avatar: Image.memory(
                      image,
                      fit: BoxFit.cover,
                    ),
                    deleteIconColor: Colors.red,
                    onDeleted: () {
                      setState(() {
                        _otherImages.removeAt(index);
                        _otherImagesMemory.removeAt(index);
                      });
                    },
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAilmentSection() {
    return Container(
      padding: const EdgeInsets.all(14),
      color: CustomColors.secondary.lightest,
      width: double.infinity,
      height: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Symptoms:'),
          const Gap(6),
          SizedBox(
            width: 400,
            height: 40,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    controller: _symptomsController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter new symptom',
                    ),
                  ),
                ),
                const Gap(20),
                MaterialButton(
                  color: CustomColors.primary.lightest,
                  textColor: CustomColors.primary.normal,
                  shape: BeveledRectangleBorder(
                    side: BorderSide(color: CustomColors.primary.normal),
                  ),
                  onPressed: _addSymptom,
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 8,
            runSpacing: 8,
            children: _symptoms.map((symptom) {
              return Chip(
                label: Text(symptom),
                deleteIconColor: Colors.red,
                onDeleted: () {
                  setState(() {
                    _symptoms.remove(symptom);
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: CustomColors.error.normal,
          textColor: Colors.white,
          child: const Text('Cancel'),
        ),
        MaterialButton(
          onPressed: _submitForm,
          color: CustomColors.primary.normal,
          textColor: Colors.white,
          child: const Text('Upload'),
        ),
      ],
    );
  }
}
