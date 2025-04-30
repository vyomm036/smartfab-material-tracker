import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/material.dart';
import '../repositories/material_repository.dart';

class GetAllMaterials {
  final MaterialRepository repository;

  GetAllMaterials(this.repository);

  Future<Either<Failure, List<Material>>> call() async {
    try {
      return await repository.getAllMaterials();
    } catch (e) {
      return const Left(UnknownFailure(
        message: 'An unexpected error occurred while fetching materials',
      ));
    }
  }
} 