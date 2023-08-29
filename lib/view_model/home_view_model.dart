import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mvvm/model/product_model.dart';

import '../data/response/api_response.dart';
import '../repository/home_repository.dart';

class HomeViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();

  ApiResponse<ProductModel> productList = ApiResponse.loading();

  setProductList(ApiResponse<ProductModel> response) {
    productList = response;
    notifyListeners();
  }

  Future<void> fetchProductListApi() async {

    setProductList(ApiResponse.loading()); 

    _myRepo.fetchProductList().then((value) {
        setProductList(ApiResponse.completed(value)); 

    }).onError((error, stackTrace) {
          setProductList(ApiResponse.error(error.toString())); 

    });
  }
}
