
import 'package:bukizz_delivery/mvvm/models/product/variation/set_model.dart';
import 'package:bukizz_delivery/mvvm/models/product/variation/stream_model.dart';
import 'package:bukizz_delivery/mvvm/models/product/variation/variation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String productId;
  String name;
  List<StreamData> stream;
  List<SetData> set;
  Map<String , dynamic> variation;


  ProductModel({
    required this.productId,
    required this.name,
    required this.stream,
    required this.set,
    required this.variation,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'stream': stream.map((x) => x.toMap()).toList(),
      'set': set.map((x) => x.toMap()).toList(),
      'variation': variation,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    var variationMap = map['variation'] ?? {};
    Map<String, Map<String, Variation>> convertedVariationMap = {};

    variationMap.forEach((set, setData) {
      convertedVariationMap[set] = {};
      setData.forEach((stream, streamData) {
        convertedVariationMap[set]![stream] = Variation.fromMap(streamData);
      });
    });

    return ProductModel(
      productId: map['productId'] ?? '',
      name: map['name'] ?? '',
      stream: List<StreamData>.from(map['stream']?.map((x) => StreamData.fromMap(x)) ?? []),
      set: List<SetData>.from(map['set']?.map((x) => SetData.fromMap(x)) ?? []),
      variation: convertedVariationMap,
    );
  }

  factory ProductModel.fromGeneralMap(Map<String, dynamic> map) {
    var variationMap = map['variation'] ?? {};
    Map<String, Map<String, Variation>> convertedVariationMap = {};
    int p = 0;

    variationMap.forEach((set) {
      convertedVariationMap[(p).toString()] = {};
      convertedVariationMap[p.toString()]![0.toString()] = Variation.fromMap(set);
      p++;
    });

    return ProductModel(
      productId: map['productId'] ?? '',
      name: map['name'] ?? '',
      set: List<SetData>.from(map['variation']?.map((x) => SetData.fromMap(x)) ?? []),
      stream: [],
      variation: convertedVariationMap,
    );
  }

  //fromJson
  factory ProductModel.fromJson(dynamic json) {
    return ProductModel(
      productId: json['productId'] ?? 0,
      name: json['name'] ?? '',
      stream: List<StreamData>.from(json['stream']?.map((x) => StreamData.fromMap(x))),
      set: List<SetData>.from(json['set']?.map((x) => SetData.fromMap(x))),
      variation:  Map<String , Map<String , Variation>>.from(json['variation'] ?? {}),
    );
  }

  factory ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    Map<String, Map<String, Variation>> variationMap = mapVariation(data['variation']);
    return ProductModel(
      productId: data['productId'] ?? '',
      name: data['name'] ?? '',
      stream: List<StreamData>.from(data['stream'].map((x) => StreamData.fromJson(x))) ?? [],
      set: List<SetData>.from(data['set'].map((x) => SetData.fromJson(x))) ?? [],
      variation: variationMap ?? {},
    );
  }

  static Map<String, Map<String, Variation>> mapVariation(Map<String, dynamic> data) {
    Map<String, Map<String, Variation>> result = {};
    data.forEach((key, value) {
      Map<String, dynamic> variationMap = value as Map<String, dynamic>;
      Map<String, Variation> variation = {};
      variationMap.forEach((variationKey, variationValue) {
        variation[variationKey] = Variation.fromJson(variationValue);
      });
      result[key] = variation;
    });

    return result;
  }

  //fromFirestore
  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    var variationMap = Map<String, Map<String, Variation>>.from(data['variation']);

    return ProductModel(
      productId: data['productId'],
      name: data['name'],
      stream: List<StreamData>.from(data['stream'].map((x) => StreamData.fromMap(x))),
      set: List<SetData>.from(data['set'].map((x) => SetData.fromMap(x))),
      variation: variationMap,
    );
  }

}