// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewTripModelAdapter extends TypeAdapter<NewTripModel> {
  @override
  final int typeId = 6;

  @override
  NewTripModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewTripModel(
      tripName: fields[0] as String,
      tripType: fields[1] as String,
      distance: fields[2] as double,
      date: fields[3] as String,
      notes: fields[4] as String?,
      mileage: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, NewTripModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.tripName)
      ..writeByte(1)
      ..write(obj.tripType)
      ..writeByte(2)
      ..write(obj.distance)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.notes)
      ..writeByte(5)
      ..write(obj.mileage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewTripModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
