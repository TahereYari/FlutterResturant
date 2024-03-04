import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:online_ostore/screens/admin_product_screen.dart';
import 'package:online_ostore/screens/admin_restaurants_screeen.dart';
import 'package:online_ostore/screens/category_screen.dart';
import 'package:online_ostore/screens/create_category.dart';
import 'package:online_ostore/screens/create_product_screen.dart';
import 'package:online_ostore/screens/create_resturant_screen.dart';
import 'package:online_ostore/screens/front_restaurant_screen.dart';
import 'package:online_ostore/screens/home_screen.dart';
import 'package:online_ostore/screens/intro_screen.dart';
import 'package:online_ostore/screens/login_screen.dart';
import 'package:online_ostore/screens/product_screen.dart';
import 'package:online_ostore/screens/admin_restaurant_screen.dart';
import 'package:online_ostore/screens/signup_screen.dart';
import 'package:online_ostore/screens/splash_screen.dart';

class AppRoutes{
  static const String homeScreen ='/home';
  static const String unKnown ='/unKnown';
  static const String splashScreen ='/splash';
  static const String introScreen ='/intro';
  static const String signUpScreen ='/signUpScreen';
  static const String logInScreen ='/logInScreen';
  static const String createRestaurant ='/createRestaurant';
  static const String adminRestaurant ='/adminRestaurant';
  static const String adminRestaurantScreen ='/restaurantScreen';
  static const String createCategory ='/createCategory';
  static const String createProduct ='/createProduct';
  static const String adminProduct ='/adminProduct';
  static const String productScreen ='/productScreen';
  static const String frontRestaurantScreen ='/frontRestaurantScreen';
  static const String categoryScreen ='/categoryScreen';

  static final  GetPage unKnownPage =  GetPage(name: unKnown, page:()=> const HomeScreen());

  static final List<GetPage> getPage = [

    GetPage(name: splashScreen, page:()=>  SplashScreen()),
    GetPage(name: homeScreen, page:()=> const HomeScreen()),
    GetPage(name: introScreen, page:()=> const IntroScreen()),
    GetPage(name: signUpScreen, page:()=>  SignupScreen()),
    GetPage(name: logInScreen, page:()=>  LogInScreen()),
    GetPage(name: createRestaurant, page:()=> const CreateRestaurantScreen()),
    GetPage(name: adminRestaurant, page:()=> const AdminRestaurantsScreen()),
    GetPage(name: adminRestaurantScreen, page:()=> AdminRestaurantScreen()),
    GetPage(name: createCategory, page:()=> const CreateCategory()),
    GetPage(name: createProduct, page:()=> const CreateProduct()),
    GetPage(name: adminProduct, page:()=> const AdminProductList()),
    GetPage(name: productScreen, page:()=> ProductScreen()),
    GetPage(name: frontRestaurantScreen, page:()=> const FrontRestaurantScreen()),
    GetPage(name: categoryScreen, page:()=>  CategoryScreen()),


  ];
}