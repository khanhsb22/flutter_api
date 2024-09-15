import 'dart:developer';

import 'package:demo_flutter/api_request.dart';
import 'package:demo_flutter/product.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var result = <Product>[].obs;

  Future<void> getProducts() async {
    await ApiRequest(url: "https://fakestoreapi.com/products", data: null).get(
        onSuccess: (res) {
          // log("Get response: $res");
          for (var item in res) {
            result.add(Product.fromMap(item));
          }
        },
        onError: (err) => log("GET error: $err"));
    log("Product size: ${result.length.toString()}");
  }
}
