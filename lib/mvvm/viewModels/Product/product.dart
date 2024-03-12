import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/product/product.dart';

class Product{
  Future<ProductModel> fetchProduct(String productId) async{
    try{
      var data = await FirebaseFirestore.instance.collection('products').where('productId' , isEqualTo: productId ).get();
      return ProductModel.fromMap(data.docs.first.data());
    }
    catch(e){
      print(e);
    }
    return ProductModel(productId: '', name: '', stream: [], set: [], variation: {});
  }
}