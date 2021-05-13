import 'package:flutter_connect_db/database/db_helper.dart';
import 'package:flutter_connect_db/model/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{
  final productList = Future.value(<Products>[]).obs;

  @override
  void onInit(){
    fetchProducts();
    super.onInit();
  }

  Future<List<Products>> callDb() async {
    return await DBHelper.db.getAllProducts();
  }

  void fetchProducts() async{
    productList.value = callDb();
  }
}
