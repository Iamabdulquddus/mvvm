

import 'package:mvvm/data/response/status.dart';

class ApiResponse<T>{
  Status? status;
  T? data;
  String? message;

  ApiResponse(this.status,this.data,this.message);
  /// super method overriding 
  ApiResponse.loading() : status = Status.LOADING;
  ApiResponse.completed() : status = Status.COMPLETED;
  ApiResponse.error() : status = Status.ERROR;

  String toString(){
    return "Status : $status\nMessage : $message\nData : $data";
  }
}