part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<PostModel> posts;
  final bool isFresh; // indicates if data is freshly fetched
  PostLoaded({required this.posts, this.isFresh = false});

  @override
  List<Object?> get props => [posts, isFresh];
}

class PostError extends PostState {
  final String message;
  PostError(this.message);

  @override
  List<Object?> get props => [message];
}
