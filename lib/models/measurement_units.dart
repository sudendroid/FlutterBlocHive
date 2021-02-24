import 'package:hive/hive.dart';

part 'measurement_units.g.dart';

@HiveType(typeId: 2)
enum MeasurementUnit {
  @HiveField(0)
  Kilogram,
  @HiveField(1)
  Liter,
  @HiveField(2)
  Item,
}
const measurementUnits = <MeasurementUnit, String>{
  MeasurementUnit.Kilogram: "Kg",
  MeasurementUnit.Liter: "Ltr",
  MeasurementUnit.Item: "Item"
};