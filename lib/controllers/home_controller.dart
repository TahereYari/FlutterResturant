import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';
import 'package:online_ostore/controllers/basket_screen_controller.dart';
import 'package:online_ostore/controllers/bast_restaurant_controller.dart';
import 'package:online_ostore/models/basket.dart';
import 'package:online_ostore/models/product.dart';
import 'package:online_ostore/models/restaurant.dart';
import 'package:online_ostore/models/category.dart';
import 'package:online_ostore/screens/basket_screen.dart';
import 'package:online_ostore/screens/profile_screen.dart';
import 'package:online_ostore/services/app_routs.dart';
import 'package:online_ostore/static_methods.dart';
import 'package:online_ostore/widget/slider_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/home_page.dart';

class HomeController extends GetConnect {
  RxInt currentIndex = 0.obs;

  RxInt currentSlide = 0.obs;
  final Rx<CarouselController> carouselController = CarouselController().obs;
  final Rx<PageController> smoothController = PageController().obs;

  RxList<Reastaurant> restaurantImageList = <Reastaurant>[].obs;
  RxList<Widget> imageSliders = <Widget>[].obs;

  Rx<Reastaurant> restaurant = Reastaurant().obs;
  RxList<Category> categories = <Category>[].obs;
  RxList<Product> products = <Product>[].obs;
  RxList<Basket> baskets = <Basket>[].obs;

  RxInt basketCount = 0.obs;
  late SharedPreferences pref;
  String token = '-1';

  List<Widget> homeWidget = [
    const HomePage(),
    const BasketScreen(),
    const ProfileScreen(),
  ];

  // void changePage(int index) {
  //   currentIndex.value = index;
  // }

  @override
  onInit() {
    super.onInit();
    getSliderRestuarant();
    getToken();
  }

  // loadPref() async {
  //   pref = await SharedPreferences.getInstance();
  // }

  getToken() async {
    token = await StaticMethodes.getToken();
  }

  changeIndex(index) {
    currentIndex.value = index;
    if (index == 1) {
      Get.find<BasketScreenController>().getUserBasket();
    }
  }

  getSliderRestuarant() async {
    Response response = await get('http://10.0.2.2:8000/api/front');
    if (response.body['sliderResturant'] != null) {
      for (var item in response.body['sliderResturant']) {
        restaurantImageList.add(Reastaurant.fromJson(item));
      }

      imageSliders.value = restaurantImageList
          .map(
            (item) => SliderWidget(restaurant: item),
          )
          .toList();
    }
  }

  void onChangeSlide(int index, CarouselPageChangedReason reason) {
    currentSlide.value = index;
  }

  onDotClick(int index) {
    currentSlide.value = index;
    carouselController.value.animateToPage(index);
  }

  Future getRestaurant(int id) async {
    products.clear();
    baskets.clear();
    basketCount.value = 0;
    categories.value = [Category(id: 0, name: 'همه')];
    Response response = await get(
      'http://10.0.2.2:8000/api/front/resturant/$id',
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );

    if (response.statusCode! < 300) {
      restaurant.value = Reastaurant.fromJson(response.body['resturant']);

      for (var item in response.body['products']) {
        products.add(Product.fromJson(item));
      }

      for (var item in response.body['categories']) {
        categories.add(Category.fromJson(item));
      }

      for (var item in response.body['basket']) {
        baskets.add(Basket.fromJson(item));
      }
      for (var item in baskets) {
        basketCount.value += item.count!;
      }




      Get.toNamed(AppRoutes.frontRestaurantScreen);
    }
  }


  currentCategory(int restaurantId, int categoryId) async {
    products.clear();
    Response response = await get(
        'http://10.0.2.2:8000/api/front/resturant/$restaurantId?category=$categoryId');
    if (response.statusCode! < 300) {
      for (var item in response.body['products']) {
        products.add(Product.fromJson(item));
      }
    }
  }

  sendAddToCard(int productId, int restaurantId) async {
    pref.setInt('restaurantId', restaurantId);
    await get(
      'http://10.0.2.2:8000/api/basket/add/$productId/$restaurantId',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    Response response = await get(
      'http://10.0.2.2:8000/api/front/resturant/$restaurantId',
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );
    baskets.clear();
    basketCount.value = 0;

    for (var item in response.body['basket']) {
      baskets.add(Basket.fromJson(item));
    }
    for (var item in baskets) {
      basketCount.value += item.count!;
    }
  }

  addToCart(int productId, int restaurantId) async {
    if (token == '-1') {
      StaticMethodes.errorSnackBar(
          'خطا', 'شما دسترسی به این عملیات را ندارید.');
      return;
    } else {
      pref = await SharedPreferences.getInstance();
      int restId = pref.getInt('restaurantId') ?? -1;

      if (restId == -1) {
        //add
        sendAddToCard(productId, restaurantId);
      } else {
        if (restId == restaurantId) {
          //add
          sendAddToCard(productId, restaurantId);
        } else {
          //error
          Reastaurant rest = Get.find<BeatRestaurantController>()
              .bestList
              .where((p0) => p0.id == restId)
              .first;
          StaticMethodes.errorDialogRestaurant(
              restaurant: rest,
              onChangeRestaurant: () {
                Get.back();
                deleteBasket(rest);
                sendAddToCard(productId, restaurantId);
              });
        }
      }
    }
  }

  minFromCart(int productId, int restaurantId) async {
    getToken();
    if (token == '-1') {
      StaticMethodes.errorSnackBar(
          'خطا', 'شما دسترسی به این عملیات را ندارید.');
      return;
    } else {
      Response response = await get(
        'http://10.0.2.2:8000/api/front/resturant/$restaurantId',
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      List<Basket> list = [];
      for (var item in response.body['basket']) {
        list.add(Basket.fromJson(item));
      }

      for (var item in list) {
        if (item.productId == productId) {
          if (item.count == 1) {
            await get(
              'http://10.0.2.2:8000/api/basket/delete/${item.id}',
              headers: {
                HttpHeaders.authorizationHeader: 'Bearer $token',
              },
            );
          } else {
            await get(
              'http://10.0.2.2:8000/api/basket/min/$productId/$restaurantId',
              headers: {
                HttpHeaders.authorizationHeader: 'Bearer $token',
              },
            );
          }

          await get(
            'http://10.0.2.2:8000/api/front/resturant/$restaurantId',
            headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
          );
          baskets.clear();
          basketCount.value = 0;

          for (var item in response.body['basket']) {
            baskets.add(Basket.fromJson(item));
          }
          for (var item in baskets) {
            basketCount.value += item.count!;
          }
          if(baskets.isEmpty){
            await pref.remove('restaurantId');
          }
        }
      }
    }
  }

  deleteBasket(Reastaurant restaurant) async {
    await pref.remove('restaurantId');
    Response response = await get(
      'http://10.0.2.2:8000/api/front/resturant/${restaurant.id}',
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );
    List<Basket> list = [];
    for (var item in response.body['basket']) {
      list.add(Basket.fromJson(item));
    }

    for (var item in list) {
      await get(
        'http://10.0.2.2:8000/api/basket/delete/${item.id}',
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );
    }
  }

  bool showMinusIcon(Product product) {
    for (var item in baskets) {
      if (item.productId == product.id) {
        if (item.count! > 0) {
          return true;
        }
      }
    }
    return false;
  }
}
