// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'model/db_model.dart';

ValueNotifier<List<GalleryModel>> galleryImageNotifier = ValueNotifier([]);
Future<void> addStudent(GalleryModel value) async {
  final galleryDB = await Hive.openBox<GalleryModel>('gallery_db');
  final id = await galleryDB.add(value);
  value.id = id;
  galleryImageNotifier.value.add(value);
  await galleryDB.put(id, value);
  galleryImageNotifier.notifyListeners();
  getAllStudents();
}

Future<void> getAllStudents() async {
  final galleryDB = await Hive.openBox<GalleryModel>('gallery_db');
  galleryImageNotifier.value.clear();
  galleryImageNotifier.value.addAll(galleryDB.values);
  galleryImageNotifier.notifyListeners();
}

Future<void> clearAllStudents() async {
  final galleryDB = await Hive.openBox<GalleryModel>('gallery_db');
  galleryImageNotifier.value.clear();
  galleryDB.clear();
}
