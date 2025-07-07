// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuel_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FuelModelAdapter extends TypeAdapter<FuelModel> {
  @override
  final int typeId = 0;

  @override
  FuelModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FuelModel(
      fuelType: fields[0] as String,
      liters: fields[1] as double,
      pricePerLiter: fields[2] as double,
      totalCost: fields[3] as double,
      odometer: fields[4] as double,
      date: fields[5] as String,
      vehicleName: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FuelModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.fuelType)
      ..writeByte(1)
      ..write(obj.liters)
      ..writeByte(2)
      ..write(obj.pricePerLiter)
      ..writeByte(3)
      ..write(obj.totalCost)
      ..writeByte(4)
      ..write(obj.odometer)
      ..writeByte(5)
      ..write(obj.date)
      ..writeByte(6)
      ..write(obj.vehicleName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FuelModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
