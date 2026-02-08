// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emotion_result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmotionResultAdapter extends TypeAdapter<EmotionResult> {
  @override
  final int typeId = 0;

  @override
  EmotionResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmotionResult(
      id: fields[0] as String,
      emotion: fields[1] as String,
      confidence: fields[2] as double,
      timestamp: fields[3] as DateTime,
      imagePath: fields[4] as String?,
      audioPath: fields[5] as String?,
      detectionType: fields[6] as String,
      allProbabilities: (fields[7] as Map).cast<String, double>(),
    );
  }

  @override
  void write(BinaryWriter writer, EmotionResult obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.emotion)
      ..writeByte(2)
      ..write(obj.confidence)
      ..writeByte(3)
      ..write(obj.timestamp)
      ..writeByte(4)
      ..write(obj.imagePath)
      ..writeByte(5)
      ..write(obj.audioPath)
      ..writeByte(6)
      ..write(obj.detectionType)
      ..writeByte(7)
      ..write(obj.allProbabilities);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmotionResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
