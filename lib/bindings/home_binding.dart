import 'package:get/get.dart';
import 'package:smart_farm/modules/overview/controllers/message_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MessageController());
  }
}
