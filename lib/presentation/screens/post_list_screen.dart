import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/post_model.dart';
import '../../bloc/post_bloc.dart';
import '../widgets/post_item.dart';
import 'post_detail_screen.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({super.key});

  void _openDetail(BuildContext context, PostModel post) {
    // mark read then navigate
    context.read<PostBloc>().add(MarkPostReadEvent(post.id));
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // so blur shows
      builder: (_) => PostDetailScreen(post: post),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              context.read<PostBloc>().add(RefreshPostsEvent());
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PostError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message, textAlign: TextAlign.center),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<PostBloc>().add(LoadPostsEvent()),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else if (state is PostLoaded) {
              final posts = state.posts;
              if (posts.isEmpty) {
                return const Center(child: Text('No posts found.'));
              }
              return ListView.separated(
                itemCount: posts.length,
                separatorBuilder: (_, __) => const Divider(height: 0.5),
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return InkWell(
                    onTap: () => _openDetail(context, post),
                    child: PostItem(post: post),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
