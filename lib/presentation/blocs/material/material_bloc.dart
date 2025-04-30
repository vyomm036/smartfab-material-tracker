import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/material.dart';
import '../../../domain/usecases/get_all_materials.dart';

part 'material_event.dart';
part 'material_state.dart';

class MaterialBloc extends Bloc<MaterialEvent, MaterialState> {
  final GetAllMaterials getAllMaterials;

  MaterialBloc({required this.getAllMaterials}) : super(MaterialInitial()) {
    on<LoadMaterials>(_onLoadMaterials);
  }

  Future<void> _onLoadMaterials(
    LoadMaterials event,
    Emitter<MaterialState> emit,
  ) async {
    emit(MaterialLoading());
    final result = await getAllMaterials();
    result.fold(
      (failure) => emit(MaterialError(message: failure.message)),
      (materials) => emit(MaterialLoaded(materials: materials)),
    );
  }
} 