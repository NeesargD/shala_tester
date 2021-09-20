part of 'post_filter_bloc.dart';

abstract class PostFilterEvent extends Equatable {
  const PostFilterEvent();
}

class PostAllFilter extends PostFilterEvent{

  final int startDuration;
  final int endDuration;
  final List<String> language;
  final List<String> level;
  final List<String> style;
  final List<String> focus;
  final List<String> instructor;

  PostAllFilter({required this.startDuration, required this.endDuration, required this.language, required this.level, required this.style, required this.focus, required this.instructor});
  List<Object?> get props => [];
}