import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/dummy_data/gallery.dart';
import 'package:logaluxe_users/model/gallery.dart';

class GalleryNotifier extends StateNotifier<List<GalleryModel>> {
  GalleryNotifier() : super(allGalary);
}

var galleryProvider = StateNotifierProvider<GalleryNotifier, List<GalleryModel>>((ref) {
  return GalleryNotifier();
});
