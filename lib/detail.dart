import 'dart:convert';
import 'dart:io';

import 'package:demo_flutter/product.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  late Product product;
  String? jsonProduct;
  WindowController? windowController;


  @override
  State<DetailScreen> createState() => _DetailScreenState();

  DetailScreen(this.product);
  DetailScreen.JSON(this.jsonProduct, this.windowController);
}

class _DetailScreenState extends State<DetailScreen> {
  bool isDesktop = false;
  @override
  void initState() {
    super.initState();
    if (widget.jsonProduct != null) {
      Map<String, dynamic> pMap = jsonDecode(widget.jsonProduct!) as Map<String, dynamic>;
      widget.product = Product.fromJson(pMap);
      isDesktop = true;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.amber,
        leading: !isDesktop ? IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ) : null,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 50, right: 16, bottom: 16),
          child: ListView(
            children:[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${widget.product.title}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blueAccent),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          color: Colors.transparent,
                        ),
                      ),
                      Image.network(
                        '${widget.product.img}',
                        width: 140,
                        height: 170,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Price: '),
                  Text('${widget.product.price}\$',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange))
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Quantity: '),
                  Text('${widget.product.rate?.count}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black))
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  '${widget.product.desc}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style:
                  TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Category: '),
                  Text('${widget.product.category}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black))
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Rate: '),
                  Text('${widget.product.rate?.rate}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.purpleAccent))
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: double.infinity, // Stretch the button to its full length
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () async {
                            if (Platform.isIOS || Platform.isAndroid) {
                              Navigator.pop(context);
                            }
                            if (Platform.isMacOS || Platform.isWindows) {
                              widget.windowController!.close();
                            }
                          },
                          child: Text("Buy",
                              style: TextStyle(fontSize: 15, color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                //to set border radius to button
                                  borderRadius: BorderRadius.circular(10)),
                              padding:
                              EdgeInsets.only(left: 20, top: 5, right: 20, bottom: 5) //content padding inside button
                          )),
                    ),
                  ),
                ],
              ),
            ]
          ),
        ),
      ),
    );
  }
}
