import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pikngrocers_client/constants.dart';
import 'package:pikngrocers_client/utils/database.dart';

class CategoryProductList extends StatelessWidget {
  final String uid;
  final String catType;
  CategoryProductList({this.uid, this.catType});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kCategoryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Database().showProductData(catType: catType, uid: uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error Occur'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                value: 5,
                valueColor: AlwaysStoppedAnimation<Color>(kCategoryColor),
              ),
            );
          }
          return Container(
            child: snapshot.data.docs.length == 0
                ? Center(
                    child: Text('No product to show'),
                  )
                : ProductListViewBuilderHelp(
                    snapshot: snapshot,
                  ),
          );
        },
      ),
    );
  }
}

class ProductListViewBuilderHelp extends StatefulWidget {
  final AsyncSnapshot<QuerySnapshot> snapshot;
  const ProductListViewBuilderHelp({
    this.snapshot,
  });

  @override
  _ProductListViewBuilderHelpState createState() => _ProductListViewBuilderHelpState();
}

class _ProductListViewBuilderHelpState extends State<ProductListViewBuilderHelp> {
  @override
  Widget build(BuildContext context) {
    var doc = widget.snapshot.data.docs;
    return ListView.builder(
        itemCount: doc.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            elevation: 3,
            child: ListTile(
              leading: Image.asset('assets/images/basket.png'),
              subtitle : Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    doc[index].data()['Offer_price'] == null
                        ? Text(
                            'Price : ₹${doc[index].data()['Price'].toString()}',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          )
                        : Row(
                            children: [
                              Text(
                                'Price : ₹${doc[index].data()['Price'].toString()}',
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Offer Price : ₹${doc[index].data()['Offer_price'].toString()}',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      doc[index].data()['Product_Name'],
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                              '${doc[index].data()['Product_Quantity']}'),
                        ),
                        FlatButton(
                          onPressed: () {

                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text('Add to Cart'),
                          color: Colors.green,
                          textColor: Colors.white,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
