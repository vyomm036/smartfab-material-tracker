part of 'material_bloc.dart';

abstract class MaterialState extends Equatable {
  const MaterialState();

  @override
  List<Object> get props => [];
}

class MaterialInitial extends MaterialState {}

class MaterialLoading extends MaterialState {}

class MaterialLoaded extends MaterialState {
  final List<Material> materials;

  const MaterialLoaded({required this.materials});

  @override
  List<Object> get props => [materials];
}

class MaterialError extends MaterialState {
  final String message;

  const MaterialError({required this.message});

  @override
  List<Object> get props => [message];
} 