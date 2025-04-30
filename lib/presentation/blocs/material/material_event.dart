part of 'material_bloc.dart';

abstract class MaterialEvent extends Equatable {
  const MaterialEvent();

  @override
  List<Object> get props => [];
}

class LoadMaterials extends MaterialEvent {
  const LoadMaterials();
} 