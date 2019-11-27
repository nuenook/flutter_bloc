import 'package:equatable/equatable.dart';
import 'package:flutter_infinite_list/data/model/post.dart';

abstract class PostState extends Equatable {
  PostState();

  @override
  List<Object> get props => [];
}

class PostUninitialized extends PostState {}

class PostError extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;
  final bool hasReachedMax;

  PostLoaded({
    this.hasReachedMax,
    this.posts
  });

  PostLoaded copyWith({
    List<Post> posts,
    bool hasReachedMax
  }) => PostLoaded(
    posts: posts ?? this.posts,
    hasReachedMax: hasReachedMax ?? this.hasReachedMax
  );

  @override
  List<Object> get props => [
    posts,
    hasReachedMax
  ];
}
