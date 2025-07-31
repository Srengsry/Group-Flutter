enum ProductStatus { available, outOfStock, discontinued }

class Product {
  final int? id;
  final String name;
  final int? categoryId;
  final int? brandId;
  final String model;
  final String? serialNumber;
  final double? purchasePrice;
  final double? sellingPrice;
  final int stockQuantity;
  final ProductStatus status;
  final DateTime? purchaseDate;
  final DateTime? warrantyExpiry;
  final String? description;
  final String? imagePath;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Product({
    this.id,
    required this.name,
    this.categoryId,
    this.brandId,
    required this.model,
    this.serialNumber,
    this.purchasePrice,
    this.sellingPrice,
    required this.stockQuantity,
    required this.status,
    this.purchaseDate,
    this.warrantyExpiry,
    this.description,
    this.imagePath,
    this.createdAt,
    this.updatedAt,
  });
}
