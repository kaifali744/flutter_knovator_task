import 'package:flutter/material.dart';
import '../../data/models/post_model.dart';

class PostItem extends StatelessWidget {
  final PostModel post;
  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final bgColor = post.isRead ? Colors.white : Color(0xFFFFF0C4);
    return Container(
      color: bgColor,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 18, child: Text(post.id.toString())),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  // show a short preview of body
                  post.body.length > 100
                      ? '${post.body.substring(0, 100)}...'
                      : post.body,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(post.isRead ? Icons.mark_email_read : Icons.mark_email_unread),
        ],
      ),
    );
  }
}
