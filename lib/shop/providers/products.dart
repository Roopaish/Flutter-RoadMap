import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  String authToken = '';
  final String userId;

  Products(this.authToken, this.userId, this._items);

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    var url = Uri.https(
        'flutter-roadmap-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/products.json',
        {'auth': authToken});

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      url = Uri.https(
          'flutter-roadmap-default-rtdb.asia-southeast1.firebasedatabase.app',
          '/userFavorites/$userId.json',
          {'auth': authToken});
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);

      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.insert(
            0,
            Product(
              id: prodId,
              title: prodData['title'],
              price: prodData['price'],
              description: prodData['description'],
              imageUrl: prodData['imageUrl'],
              isFavorite: favoriteData == null ? false : favoriteData[prodId] ?? false,
            ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.https(
        'flutter-roadmap-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/products.json',
        {'auth': authToken});
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
        }),
      );
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.https(
          'flutter-roadmap-default-rtdb.asia-southeast1.firebasedatabase.app',
          '/products/$id.json',
          {'auth': authToken});

      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.https(
        'flutter-roadmap-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/products/$id.json',
        {'auth': authToken});

    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();

    try {
      final response = await http.delete(url);
      print(response.statusCode);
    } catch (error) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw error;
    }
  }
}
