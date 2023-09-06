import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../model/product_model.dart';
import '../res/app_url.dart';

class HomeRepository{
   BaseApiServices _apiServices =  NetworkApiServices();

   Future<dynamic> notesPostApi(dynamic data) async{
     try{
       dynamic response = await _apiServices.getPostApiResponse(AppUrl.notesAddEndPoint, data);
       return response;

     }catch(e){
       throw e;
     }
   }

  Future<ProductModel> fetchProductList() async{
    try{
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.productEndPoint);
      return response = ProductModel.fromJson(response) ;

    }catch(e){ 
      throw e;
    }
  }
}