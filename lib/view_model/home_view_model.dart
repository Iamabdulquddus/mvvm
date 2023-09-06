import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mvvm/model/product_model.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../data/response/api_response.dart';
import '../model/notes_model.dart';
import '../model/user_model.dart';
import '../repository/home_repository.dart';
import '../utils/utils.dart';

class HomeViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();

  ApiResponse<ProductModel> productList = ApiResponse.loading();
  ApiResponse<NotesModel> notesList = ApiResponse.loading();


  Future<UserModel> getUserData() => UserViewModel().getUser();

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

  Future<void> notesApi(dynamic data, BuildContext context) async {

    _myRepo.notesPostApi(data).then((value) {

      getUserData().then((value) async {
        if (kDebugMode) {
          print(value.token);
        }



      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print(error.toString());
        }
      });


    }).onError((error, stackTrace) {

      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }




}
