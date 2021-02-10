import 'package:get/get.dart';

class MSVpnController extends GetxController {
  RxString isConneString = 'Not Connected'.obs;
  RxBool isConnected = false.obs;
  RxDouble connectLoad = 0.3.obs;

  Future connectVpn() async {
    await Future.delayed(1.seconds);
    connectLoad.value = 0.5;

    await Future.delayed(2.seconds);
    connectLoad.value = 0.7;
    await Future.delayed(1.seconds);
    connectLoad.value = 0.8;
    await Future.delayed(1.seconds);

    await Future.delayed(1.seconds);
    connectLoad.value = 1.0;
    isConneString = isConnected.value ? 'Not Connected'.obs : 'Connected'.obs;
    isConnected.value = isConnected.value ? false : true;
  }
}
