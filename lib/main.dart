//nomor1
import 'package:flutter/material.dart';
import 'package:latihanconsumeapi/moviecategoryselector.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MovieCategorySelector(),
    );
  }
}


//nomor2
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Product App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const ProductList(),
//     );
//   }
// }

// class ProductList extends StatefulWidget {
//   const ProductList({super.key});

//   @override
//   _ProductListState createState() => _ProductListState();
// }

// class _ProductListState extends State<ProductList> {
//   List<dynamic> _products = [];
//   bool _isLoading = true;
//   String _errorMessage = '';

//   @override
//   void initState() {
//     super.initState();
//     _fetchProducts();
//   }

//   Future<void> _fetchProducts() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = '';
//     });

//     try {
//       List<dynamic> products = await ProductApi().getProducts();

//       setState(() {
//         _products = products;
//         _isLoading = false;
//       });
//     } catch (error) {
//       setState(() {
//         _errorMessage = 'Failed to load products: $error';
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Product List'),
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//               ? Center(child: Text(_errorMessage))
//               : ListView.builder(
//                   itemCount: _products.length,
//                   itemBuilder: (context, index) {
//                     var product = _products[index];
//                     return Card(
//                       child: ListTile(
//                         title: Text(product['title']),
//                         subtitle: Text("\$${product['price']}"),
//                       ),
//                     );
//                   },
//                 ),
//     );
//   }
// }

// class ProductApi {
//   final String baseUrl = 'https://api.escuelajs.co/api/v1/products';

//   Future<List<dynamic>> getProducts() async {
//     final response = await http.get(Uri.parse(baseUrl));

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to load products');
//     }
//   }
// }
