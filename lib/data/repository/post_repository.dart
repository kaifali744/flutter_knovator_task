import '../models/post_model.dart';
import '../../core/api_client.dart';
import '../../core/hive_service.dart';

class PostRepository {
  final ApiClient apiClient;
  final HiveService hiveService;

  PostRepository({required this.apiClient, required this.hiveService});

  /// Return cached posts (if any). Caller may then trigger fetchAndCache.
  Future<List<PostModel>> getCachedPosts() async {
    final cached = await hiveService.getPosts();
    final readIds = hiveService.getReadIds();
    return cached.map((p) => p.copyWith(isRead: readIds.contains(p.id))).toList();
  }

  /// Fetch fresh posts from API and cache them. Returns fresh list.
  Future<List<PostModel>> fetchAndCachePosts() async {
    final remote = await apiClient.fetchPosts();
    // apply read flags (if any)
    final readIds = hiveService.getReadIds();
    final withRead = remote.map((p) => p.copyWith(isRead: readIds.contains(p.id))).toList();
    await hiveService.savePosts(withRead);
    return withRead;
  }

  Future<PostModel> fetchPostById(int id) async {
    // try to find in cache first
    final cached = await getCachedPosts();
    final found = cached.where((p) => p.id == id);
    if (found.isNotEmpty) return found.first;
    // else fetch remote
    final remote = await apiClient.fetchPostById(id);
    // don't override read flags here, but add to cache
    await hiveService.savePosts([remote]);
    return remote;
  }

  Future<void> markPostRead(int id) async {
    await hiveService.markAsRead(id);
  }
}
