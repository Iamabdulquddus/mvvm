
import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:mvvm/res/app_url.dart';

import '../data/network/NetworkApiServices.dart';

class  AuthRepository{

  BaseApiServices _apiServices =  NetworkApiServices();

  Future<dynamic> loginApi(dynamic data) async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.loginEndPoint, data);
      return response;

    }catch(e){
      throw e;
    }
  }
  Future<dynamic> signupApi(dynamic data) async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.loginEndPoint, data);
      return response;

    }catch(e){
      throw e;
    }
  }
}