import 'package:get/get.dart';

class FeatureArtistItem {
  final String id;
  final String name;
  final String role; // e.g., Artist
  final String followersText; // e.g., 1k Followers
  final String image; // local asset path or network url

  FeatureArtistItem({
    required this.id,
    required this.name,
    required this.role,
    required this.followersText,
    required this.image,
  });
}

class CreateNewExhibitionFeatureArtistController extends GetxController {
  // Master list (could be loaded from API in future)
  final List<FeatureArtistItem> _allArtists = [
    FeatureArtistItem(
      id: '1',
      name: 'Jack Morison',
      role: 'ARTIST',
      followersText: '1k Followers',
      image: 'assets/images/artist_profile.png',
    ),
    FeatureArtistItem(
      id: '2',
      name: 'Jack Morison',
      role: 'ARTIST',
      followersText: '1k Followers',
      image: 'assets/images/artist.png',
    ),
    FeatureArtistItem(
      id: '3',
      name: 'Jack Morison',
      role: 'ARTIST',
      followersText: '1k Followers',
      image: 'assets/images/man.png',
    ),
    FeatureArtistItem(
      id: '4',
      name: 'Jack Morison',
      role: 'ARTIST',
      followersText: '1k Followers',
      image: 'assets/images/general.png',
    ),
  ];

  // Visible list (after search filter)
  List<FeatureArtistItem> visibleArtists = [];

  // Selected artists
  final List<FeatureArtistItem> selected = [];

  String _query = '';

  @override
  void onInit() {
    super.onInit();
    visibleArtists = List.from(_allArtists);
  }

  void onSearchChanged(String value) {
    _query = value.trim().toLowerCase();
    if (_query.isEmpty) {
      visibleArtists = List.from(_allArtists);
    } else {
      visibleArtists = _allArtists
          .where((a) => a.name.toLowerCase().contains(_query))
          .toList();
    }
    update();
  }

  bool isSelected(FeatureArtistItem item) {
    return selected.any((e) => e.id == item.id);
  }

  void toggleSelection(FeatureArtistItem item) {
    final existingIndex = selected.indexWhere((e) => e.id == item.id);
    if (existingIndex >= 0) {
      selected.removeAt(existingIndex);
    } else {
      selected.add(item);
    }
    update();
  }

  void removeSelection(FeatureArtistItem item) {
    selected.removeWhere((e) => e.id == item.id);
    update();
  }
}
