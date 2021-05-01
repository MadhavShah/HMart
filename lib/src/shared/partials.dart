import 'package:flutter/material.dart';
import '../shared/Product.dart';
import '../shared/colors.dart';
import '../shared/styles.dart';

Widget Item(Product item,
    {double imgWidth, onLike, onTapped, bool isProductPage = false}) {

  return Container(
    width: 250,
    height: 180,
    // color: Colors.red,
    margin: EdgeInsets.only(left: 20),
    child: Stack(
      children: <Widget>[
        Container(
            width: 180,
            height: 180,
            child: RaisedButton(
                color: white,
                elevation: (isProductPage) ? 20 : 12,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: onTapped,
                child: Hero(
                    transitionOnUserGestures: true,
                    tag: item.name,
                    child: Image.asset(item.image,
                        width: (imgWidth != null) ? imgWidth : 100)))),
        Positioned(
          bottom: (isProductPage) ? 10 : 70,
          right: 0,
          child: FlatButton(
            padding: EdgeInsets.all(20),
            shape: CircleBorder(),
            onPressed: onLike,
            child: Icon(
              (item.userLiked) ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
              color: (item.userLiked) ? primaryColor : darkText,
              size: 30,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: (!isProductPage)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(item.name, style: itemNameText),
                    Text(item.price, style: priceText),
                  ],
                )
              : Text(' '),
        ),
        Positioned(
            top: 10,
            left: 10,
            child: (item.discount != null)
                ? Container(
                    padding:
                        EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
                    decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(50)),
                    child: Text('-' + item.discount.toString() + '%',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700)),
                  )
                : SizedBox(width: 0))
      ],
    ),
  );
}
