import 'package:flutter/material.dart';
import 'package:flutter_connect_db/controller/product_controller.dart';
import 'package:flutter_connect_db/model/product_model.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<ProductController>(
        init: ProductController(),
        builder: (controller) {
          return FutureBuilder<List<Products>>(
              future: controller.productList.value,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                        height: 150,
                        width: double.maxFinite,
                        child: Card(
                          elevation: 2,
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Stack(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Stack(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 5),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 15.0),
                                                  child: Align(
                                                      alignment:
                                                      Alignment.centerLeft,
                                                      child: Text(
                                                          "${snapshot.data[index].name}")),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              });
        },
      ),
    );
  }

}