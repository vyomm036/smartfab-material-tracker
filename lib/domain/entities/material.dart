import 'package:equatable/equatable.dart';

class Material extends Equatable {
  final String id;
  final String name;
  final String description;
  final String unit;
  final double quantity;
  final double unitPrice;
  final String category;
  final DateTime lastUpdated;
  final String? supplier;
  final String? location;
  final bool isActive;

  const Material({
    required this.id,
    required this.name,
    required this.description,
    required this.unit,
    required this.quantity,
    required this.unitPrice,
    required this.category,
    required this.lastUpdated,
    this.supplier,
    this.location,
    this.isActive = true,
  });

  double get totalValue => quantity * unitPrice;

  Material copyWith({
    String? id,
    String? name,
    String? description,
    String? unit,
    double? quantity,
    double? unitPrice,
    String? category,
    DateTime? lastUpdated,
    String? supplier,
    String? location,
    bool? isActive,
  }) {
    return Material(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      unit: unit ?? this.unit,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      category: category ?? this.category,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      supplier: supplier ?? this.supplier,
      location: location ?? this.location,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        unit,
        quantity,
        unitPrice,
        category,
        lastUpdated,
        supplier,
        location,
        isActive,
      ];
} 