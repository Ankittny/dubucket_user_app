import 'package:get/get.dart';
import 'package:dubucket/features/splash/controllers/splash_controller.dart';
import 'package:dubucket/common/models/module_model.dart';
import 'package:dubucket/common/models/config_model.dart';

class ModuleHelper {

  static ModuleModel? getModule() {
    return Get.find<SplashController>().module;
  }

  static ModuleModel? getCacheModule() {
    return Get.find<SplashController>().cacheModule;
  }

  static Module getModuleConfig(String? moduleType) {
    return Get.find<SplashController>().getModuleConfig(moduleType);
  }

}