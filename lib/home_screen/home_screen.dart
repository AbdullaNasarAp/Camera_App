import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../db/functions/dbfunction.dart';
import '../db/functions/model/db_model.dart';
import '../widget/display_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getAllStudents();
    super.initState();
  }

  late String _imageData;
  late int length;
  @override
  Widget build(BuildContext context) {
    // clearAllStudents();
    return Scaffold(
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          shape: const CircleBorder(),
        ),
        onPressed: () {
          pickMedia();
        },
        child: const Padding(
          padding: EdgeInsets.all(
            15,
          ),
          child: Icon(
            Icons.camera_alt_rounded,
            size: 37,
          ),
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: const Color.fromARGB(255, 6, 6, 6),
        elevation: 10,
        title: const Text(
          'Gallery',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
        child: ValueListenableBuilder(
          valueListenable: galleryImageNotifier,
          builder: (
            BuildContext context,
            List<GalleryModel> studentList,
            Widget? child,
          ) {
            length = studentList.length;
            return (length == 0)
                ? const Center(
                    child: Text(
                      'No photos available',
                    ),
                  )
                : GridView.builder(
                    itemBuilder: (
                      BuildContext context,
                      int index,
                    ) {
                      final data = studentList[index];
                      return ImageCard(
                        path: data.image,
                      );
                    },
                    itemCount: studentList.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 20,
                    ),
                  );
          },
        ),
      ),
    );
  }

  Future<void> pickMedia() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (image == null) {
      return;
    }
    _imageData = image.path;
    final picture = GalleryModel(
      image: _imageData,
    );
    addStudent(picture);
  }
}
