// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScanModelAdapter extends TypeAdapter<ScanModel> {
  @override
  final int typeId = 0;

  @override
  ScanModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScanModel(
      id: fields[0] as int,
      objectName: fields[1] as String,
      description: fields[2] as String,
      originalImagePath: fields[3] as String,
      wikiImageUrl: fields[4] as String,
      date: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ScanModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.objectName)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.originalImagePath)
      ..writeByte(4)
      ..write(obj.wikiImageUrl)
      ..writeByte(5)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScanModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
