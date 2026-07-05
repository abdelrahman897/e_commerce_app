// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductItemModelAdapter extends TypeAdapter<ProductItemModel> {
  @override
  final typeId = 0;

  @override
  ProductItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductItemModel(
      sold: (fields[0] as num).toInt(),
      imagesUrl: (fields[1] as List).cast<String>(),
      ratingsQuantity: (fields[2] as num).toInt(),
      id: fields[3] as String,
      title: fields[4] as String,
      slug: fields[5] as String,
      description: fields[6] as String,
      quantity: (fields[7] as num).toInt(),
      price: (fields[8] as num).toInt(),
      imageCoverUrl: fields[9] as String,
      category: fields[10] as CategoryModel,
      brand: fields[11] as BrandModel,
      ratingsAverage: (fields[12] as num).toDouble(),
      createdAt: fields[13] as DateTime,
      updatedAt: fields[14] as DateTime,
      priceAfterDiscount: (fields[15] as num?)?.toInt(),
      availableColors: (fields[16] as List?)?.cast<dynamic>(),
      v: (fields[17] as num?)?.toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductItemModel obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.sold)
      ..writeByte(1)
      ..write(obj.imagesUrl)
      ..writeByte(2)
      ..write(obj.ratingsQuantity)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.slug)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.quantity)
      ..writeByte(8)
      ..write(obj.price)
      ..writeByte(9)
      ..write(obj.imageCoverUrl)
      ..writeByte(10)
      ..write(obj.category)
      ..writeByte(11)
      ..write(obj.brand)
      ..writeByte(12)
      ..write(obj.ratingsAverage)
      ..writeByte(13)
      ..write(obj.createdAt)
      ..writeByte(14)
      ..write(obj.updatedAt)
      ..writeByte(15)
      ..write(obj.priceAfterDiscount)
      ..writeByte(16)
      ..write(obj.availableColors)
      ..writeByte(17)
      ..write(obj.v);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
