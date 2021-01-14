import 'package:hive/hive.dart';

abstract class HiveHelper {
  Future initHive();
  Future<LazyBox> getLazyBox(String lazyBoxName);
  Future<Box> getNormalBox(String boxName);
  Future<void> deleteAllDB();
  Future<bool> closeBox(String boxName);
  Future closeHive();
}
