import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:demo_flutter/detail.dart';
import 'package:demo_flutter/product.dart';
import 'package:demo_flutter/product_controller.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

void main(List<String> args) async {
  if (Platform.isWindows || Platform.isMacOS) {
    if (args.firstOrNull == 'multi_window') {
      // Detail Page
      final argument = args[2].isEmpty
          ? const {}
          : jsonDecode(args[2]) as Map<String, dynamic>;
      if (argument['args1'] == 'Detail') {
        String product = argument['jsonProduct'];
        int windowId = int.parse(args[1]); // windowId = 1
        runApp(MaterialApp(debugShowCheckedModeBanner: false,
            home: DetailScreen.JSON(product, WindowController.fromWindowId(windowId)))
        );
      }
    } else {
      // Home Page
      runApp(const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "DemoApi",
        home: HomeScreen(),
      ));
    }
  } else if (Platform.isAndroid || Platform.isIOS) { // For mobile
    runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "DemoApi",
      home: HomeScreen(),
    ));
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final productController = Get.put(ProductController());
  String result = "";

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  Future<void> getProducts() async {
    await productController.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Demo Api",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Obx(() => productController.result.length > 0
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        itemBuilder: (context, int index) {
                          var product = productController.result[index];
                          return _productItem(product);
                        },
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: productController.result.length,
                      )
                    ],
                  ),
                )
              : CircularProgressIndicator()),
        ),
      ),
    );
  }

  Widget _productItem(Product product) {
    return GestureDetector(
      onTap: () async{
        if (Platform.isMacOS || Platform.isWindows) {
          final window =
          await DesktopMultiWindow.createWindow(jsonEncode({
            'args1': 'Detail',
            'args2': 111,
            'args3': false,
            'business': 'business_test',
            'jsonProduct': jsonEncode(product.toJson()),
          }));
          // Offset is position on window
          window
            ..setFrame(const Offset(470, 200) & const Size(750, 600))
            ..setTitle('Detail screen')
            ..show();
        }
        if (Platform.isAndroid || Platform.isIOS) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DetailScreen(product)));
        }
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                '${product.title}',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent),
              ),
              SizedBox(
                height: 5,
              ),
              Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  Image.network(
                    '${product.img}',
                    width: 120,
                    height: 130,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text('Price: '),
                  Text('${product.price}\$',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.deepOrange))
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text('Quantity: '),
                  Text('${product.rate?.count}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
