part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPostsEvent extends PostEvent {}

class RefreshPostsEvent extends PostEvent {}

class MarkPostReadEvent extends PostEvent {
  final int postId;
  MarkPostReadEvent(this.postId);

  @override
  List<Object?> get props => [postId];
}
