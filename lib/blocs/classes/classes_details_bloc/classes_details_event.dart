part of 'classes_details_bloc.dart';

abstract class ClassesDetailsEvent extends Equatable {
  const ClassesDetailsEvent();
}

class GetClassDetails extends ClassesDetailsEvent {
  final int id;

  GetClassDetails({required this.id});

  @override
  List<Object?> get props => [];
}