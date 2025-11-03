import 'dart:ui';

import 'package:flutter/material.dart';
import '../../data/models/post_model.dart';

class PostDetailScreen extends StatelessWidget {
  final PostModel post;
  const PostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    // Show the body (description) from the post
    return StatefulBuilder(
      builder: (context, setState) {
        return Stack(
          children: [
            // Blur background
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                // color: Colors.black.withOpacity(0.1),
              ),
            ),

            // Bottom Sheet Card
            DraggableScrollableSheet(
              initialChildSize: 0.5,
              maxChildSize: 0.9,
              minChildSize: 0.4,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [

                      // Close Button Row
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.close, size: 24),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),

                      // Title + Body Content
                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.title,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                post.body,
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        'Post id: ${post.id}',
                        style: TextStyle(fontSize: 16, color: Colors.grey, fontFamily: 'Tasa'),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
