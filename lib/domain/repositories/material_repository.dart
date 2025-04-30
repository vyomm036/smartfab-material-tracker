import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/material.dart';

abstract class MaterialRepository {
  Future<Either<Failure, List<Material>>> getAllMaterials();
  Future<Either<Failure, Material>> getMaterialById(String id);
  Future<Either<Failure, Material>> createMaterial(Material material);
  Future<Either<Failure, Material>> updateMaterial(Material material);
  Future<Either<Failure, void>> deleteMaterial(String id);
  Future<Either<Failure, List<Material>>> searchMaterials(String query);
  Future<Either<Failure, List<Material>>> getMaterialsByCategory(String category);
  Future<Either<Failure, void>> updateMaterialQuantity(
    String id,
    double newQuantity,
  );
  Future<Either<Failure, void>> updateMaterialPrice(
    String id,
    double newPrice,
  );
} 