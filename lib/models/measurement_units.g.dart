// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement_units.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MeasurementUnitAdapter extends TypeAdapter<MeasurementUnit> {
  @override
  final int typeId = 2;

  @override
  MeasurementUnit read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MeasurementUnit.Kilogram;
      case 1:
        return MeasurementUnit.Liter;
      case 2:
        return MeasurementUnit.Item;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, MeasurementUnit obj) {
    switch (obj) {
      case MeasurementUnit.Kilogram:
        writer.writeByte(0);
        break;
      case MeasurementUnit.Liter:
        writer.writeByte(1);
        break;
      case MeasurementUnit.Item:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeasurementUnitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
