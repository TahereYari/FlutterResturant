import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:online_ostore/services/app_routs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends GetxController {
  final RxString _connectionStatus = '-1'.obs;
  final Rx<Connectivity> _connectivity = Connectivity().obs;
  Rx<ConnectivityResult> result = ConnectivityResult.none.obs;

  // late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        _connectionStatus.value = 'ConnectivityResult.wifi';
        print('ConnectivityResult.wifi');

        break;
      case ConnectivityResult.mobile:
        _connectionStatus.value = 'ConnectivityResult.mobile';
        print('ConnectivityResult.mobile');

        break;
      case ConnectivityResult.none:
        _connectionStatus.value = '-1';

        Get.snackbar('اینترنت  متصل نمی باشد', 'لطفا wifi یا داده موبایل را روشن کنید.',
            snackPosition: SnackPosition.TOP);

        break;
      default:
        _connectionStatus.value = 'Failed to get Connectivity';

        break;
    }

    if (_connectionStatus.value != '-1') {
      Future.delayed(const Duration(seconds: 3), () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString('token')?? '-1';
      if(token == '-1'){
        Get.offNamed(AppRoutes.logInScreen);
      }
      else{
        Get.offNamed(AppRoutes.homeScreen);
      }

      });
    }
  }

  Future<void> initConnectivity() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result.value = await _connectivity.value.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.message);
      return;
    }

    return _updateConnectionStatus(result.value);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initConnectivity();
    ever(result, (_) {
      _connectivity.value.onConnectivityChanged
          .listen((_updateConnectionStatus));
    });

    }
    @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    result.close();
    _connectivity.close();
  }
  }

