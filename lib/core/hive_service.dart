import 'package:hive/hive.dart';
import '../data/models/post_model.dart';

class HiveService {
  final Box postsBox = Hive.box('postsBox');
  final Box readBox = Hive.box('readBox');

  static const String _postsKey = 'posts';
  static const String _readKey = 'readIds';

  Future<List<PostModel>> getPosts() async {
    final raw = postsBox.get(_postsKey) as List<dynamic>?;
    if (raw == null) return [];
    return raw.map((e) => PostModel.fromJson(Map<String, dynamic>.from(e as Map))).toList();
  }

  Future<void> savePosts(List<PostModel> posts) async {
    final mapped = posts.map((p) => p.toJson()).toList();
    await postsBox.put(_postsKey, mapped);
  }

  // read status is stored as list of ints
  Set<int> getReadIds() {
    final list = readBox.get(_readKey) as List<dynamic>?;
    if (list == null) return <int>{};
    return list.map((e) => e as int).toSet();
  }

  Future<void> markAsRead(int id) async {
    final s = getReadIds();
    s.add(id);
    await readBox.put(_readKey, s.toList());
    // Also update stored posts' isRead flag if present
    final current = await getPosts();
    final updated = current.map((p) {
      if (p.id == id) return p.copyWith(isRead: true);
      return p;
    }).toList();
    await savePosts(updated);
  }
}
