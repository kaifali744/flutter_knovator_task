import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/post_model.dart';
import '../../data/repository/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;

  PostBloc({required this.repository}) : super(PostInitial()) {
    on<LoadPostsEvent>(_onLoad);
    on<RefreshPostsEvent>(_onRefresh);
    on<MarkPostReadEvent>(_onMarkRead);
  }

  Future<void> _onLoad(LoadPostsEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final result = await InternetAddress.lookup("google.com");
      print(result);
    } catch (e) {
      print("NO INTERNET");
    }

    try {
      final cached = await repository.getCachedPosts();
      if (cached.isNotEmpty) {
        // show cached immediately
        emit(PostLoaded(posts: cached, isFresh: false));
        // fetch fresh data in background and emit if different
        try {
          final fresh = await repository.fetchAndCachePosts();
          // if different or fresh, emit
          emit(PostLoaded(posts: fresh, isFresh: true));
        } catch (_) {
          // ignore background sync failure; keep cached
        }
        return;
      }

      // no cache -> fetch from API
      final fresh = await repository.fetchAndCachePosts();
      emit(PostLoaded(posts: fresh, isFresh: true));
    } catch (e) {
      emit(PostError('Failed to load posts: ${e.toString()}'));
    }
  }

  Future<void> _onRefresh(RefreshPostsEvent event, Emitter<PostState> emit) async {
    // always fetch fresh
    emit(PostLoading());
    try {
      final fresh = await repository.fetchAndCachePosts();
      emit(PostLoaded(posts: fresh, isFresh: true));
    } catch (e) {
      emit(PostError('Failed to refresh posts: ${e.toString()}'));
    }
  }

  Future<void> _onMarkRead(MarkPostReadEvent event, Emitter<PostState> emit) async {
    try {
      await repository.markPostRead(event.postId);
      // update local state copy
      if (state is PostLoaded) {
        final current = (state as PostLoaded).posts;
        final updated = current.map((p) {
          if (p.id == event.postId) return p.copyWith(isRead: true);
          return p;
        }).toList();
        emit(PostLoaded(posts: updated, isFresh: (state as PostLoaded).isFresh));
      } else {
        // reload minimal cached
        final cached = await repository.getCachedPosts();
        emit(PostLoaded(posts: cached, isFresh: false));
      }
    } catch (e) {
      // mark error but preserve current state
      if (state is PostLoaded) {
        emit(PostLoaded(posts: (state as PostLoaded).posts, isFresh: (state as PostLoaded).isFresh));
      }
    }
  }
}
