import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:post/repositories/concrete/Local/hiveBoxesConstants.dart';
import 'package:post/services/abstract/hiveHelper.dart';

class HiveHelperImpl implements HiveHelper {
  @override
  Future initHive() => Hive.initFlutter();

  ///Returns an object of Hive Box if is opened
  ///
  ///but if not it will open it and return the Box.
  @override
  Future<Box<Map>> getNormalBox(String boxName) async {
    Box<Map> box;
    if (Hive.isBoxOpen(boxName))
      box = Hive.box(boxName);
    else {
      box = await Hive.openBox(boxName);
      await box.compact();
    }
    return box;
  }

  ///Returns an object of Hive LazyBox if is opened
  ///
  ///but if not it will open it and return the LazyBox.
  @override
  Future<LazyBox<Map>> getLazyBox(String lazyBoxName) async {
    LazyBox<Map> lazyBox;
    if (Hive.isBoxOpen(lazyBoxName))
      lazyBox = Hive.lazyBox(lazyBoxName);
    else {
      lazyBox = await Hive.openLazyBox(lazyBoxName);
      await lazyBox.compact();
    }
    return lazyBox;
  }

  @override
  Future<void> deleteAllDB() async {
    try {
      await Hive.deleteBoxFromDisk(POSTS_BOX);
      await Hive.deleteBoxFromDisk(USERS_BOX);
    } on Exception catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<bool> closeBox(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      await Hive.lazyBox(boxName).close();
      return true;
    } else
      return false;
  }

  @override
  Future closeHive() => Hive.close();
}
