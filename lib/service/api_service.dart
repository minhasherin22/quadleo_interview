import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quadleo_interview/model/customer_details_model.dart';

class ApiService {
  final Dio dio = Dio();

  Future<CustomerDetailsModel?> getCustomerDetails() async {
    try {
      Response response = await dio.get(
        "https://customer.billerq.com/public/api/mobile/get-customer-details",
      );
      if (response.statusCode == 200) {
        String json = jsonEncode(response.data);

        return customerDetailsModelFromJson(json);
      }
    } on DioException catch (e) {
      log("customer error:$e");
    }
    return null;
  }
}

final getCustomerDetailsProvider =
    FutureProvider<CustomerDetailsModel?>((ref) async {
  return await ApiService().getCustomerDetails();
});
