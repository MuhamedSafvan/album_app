import 'dart:io';

import 'package:album_app/models/user_model.dart';
import 'package:album_app/providers/app_provider.dart';
import 'package:album_app/services/dio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFetching = false;
  final ImagePicker imagePicker = ImagePicker();
  List<File> imageFileList = [];
  File? _file;

  void fetchData() async {
    await DioService().getUserData(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future selectImage(ImageSource source) async {
    Navigator.pop(context);
    final selectedImage = await imagePicker.pickImage(source: source);
    if (selectedImage != null) {
      // imageFileList!.addAll(selectedImages);
      _file = File(selectedImage.path);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, model, _) {
      final user = model.userModel;
      return user == null
          ? const Center(
              child: Text('Loading Data ...'),
            )
          : SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: _file != null
                              ? FileImage(_file!)
                              : const AssetImage(
                                      'assets/images/placeholder_person.jpg')
                                  as ImageProvider,
                          radius: 100,
                        ),
                        Positioned(
                            right: 10,
                            bottom: 0,
                            child: IconButton(
                                onPressed: () => showDialog(
                                      builder: (context) => AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListTile(
                                              onTap: () =>
                                                  selectImage(ImageSource.camera),
                                              leading: const Icon(Icons.camera_alt),
                                              title: const Text('Take a selfie'),
                                            ),
                                            ListTile(
                                              onTap: () => selectImage(
                                                  ImageSource.gallery),
                                              leading: const Icon(Icons
                                                  .add_photo_alternate_outlined),
                                              title: const Text('Choose a photo'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      context: context,
                                    ),
                                icon: const Icon(Icons.add_photo_alternate)))
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Name: ${user.name ?? ''}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text('Username: ${user.username ?? ''}'),
                    const SizedBox(height: 10),
                    Text('Email: ${user.email ?? ''}'),
                    const SizedBox(height: 10),
                    Text('Phone: ${user.phone ?? ''}'),
                    const SizedBox(height: 10),
                    Text('Website: ${user.website ?? ''}'),
                    const SizedBox(height: 20),
                    const Text(
                      'Address:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text('Street: ${user.address?.street ?? ''}'),
                    Text('Suite: ${user.address?.suite ?? ''}'),
                    Text('City: ${user.address?.city ?? ''}'),
                    Text('Zipcode: ${user.address?.zipcode ?? ''}'),
                    const SizedBox(height: 20),
                    const Text(
                      'Company:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text('Name: ${user.company?.name ?? ''}'),
                    Text('Catch Phrase: ${user.company?.catchPhrase ?? ''}'),
                    Text('BS: ${user.company?.bs ?? ''}'),
                  ],
                ),
              ),
          );
    });
  }
}
