import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import '../shared/fryo_icons.dart';
import './ProductPage.dart';
import '../shared/Product.dart';
import '../shared/partials.dart';

class Dashboard extends StatefulWidget {
  final String pageTitle;
  Dashboard({Key key, this.pageTitle}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _tabs = [
      storeTab(context),
      Text('Tab2'),
      Text('Tab3'),
    ];

    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            iconSize: 21,
            icon: Icon(Fryo.funnel),
          ),
          backgroundColor: primaryColor,
          title:
              Text('H-Mart', style: logoWhiteStyle, textAlign: TextAlign.center),
          actions: <Widget>[
            IconButton(
              padding: EdgeInsets.all(0),
              onPressed: () {},
              iconSize: 21,
              icon: Icon(Fryo.magnifier),
            ),
          ],
        ),
        body: _tabs[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Fryo.shop),
                title: Text(
                  'Store',
                  style: tabLinkStyle,
                )),
            BottomNavigationBarItem(
                icon: Icon(Fryo.cart),
                title: Text(
                  'My Cart',
                  style: tabLinkStyle,
                )),
            BottomNavigationBarItem(
                icon: Icon(Fryo.user_1),
                title: Text(
                  'Profile',
                  style: tabLinkStyle,
                )),
          ],
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.green[600],
          onTap: _onItemTapped,
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}


Widget storeTab(BuildContext context) {


  List<Product> items = [
    Product(
        name: "Coca-Cola",
        image: "images/6.png",
        price: "\$45.12",
        userLiked: true,
        discount: 2),
    Product(
        name: "Lemonade",
        image: "images/5.png",
        price: "\$28.00",
        userLiked: false,
        discount: 5.2),
    Product(
        name: "item 3",
        image: "images/6.png",
        price: "\$78.99",
        userLiked: false),
    Product(
        name: "item 5",
        image: "images/6.png",
        price: "\$168.99",
        userLiked: true,
        discount: 3.4)
  ];

  return ListView(
children: <Widget>[
    Container(
      // height: 500.0,
      child: Expanded(
        child: GridView.count(
          crossAxisCount: 1,
           //       childAspectRatio: (itemWidth / itemHeight),
          controller: ScrollController(keepScrollOffset: false),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(4.0),
          children: items.map((Product pr) {
            return Card(
           //   shape: shape,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // photo and title
                  SizedBox(
                    height: 150.0,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Image.asset(
                            pr.image,
                            // package: destination.assetPackage,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          // padding: EdgeInsets.all(5.0),
                          child: IconButton(
                              icon: const Icon(Icons.favorite_border),
                              onPressed: () {}),
                        ),
                      ],
                    ),
                  ),
                  // description and share/explore buttons
                  Divider(),
                  Expanded(
                    child: Container(
                      padding:
                      const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // three line description
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              pr.name,
                         //     style: descriptionStyle.copyWith(
                         //         color: Colors.black87),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              pr.price,
                         //     style: descriptionStyle.copyWith(
                         //         color: Colors.black54),
                            ),
                          ),
                          // Text(destination.description[1]),
                          // Text(destination.description[2]),
                        ],
                      ),
                    ),
                  ),
                  // share, explore buttons
                  Container(
                    alignment: Alignment.center,
                    child: OutlineButton(
                        borderSide: BorderSide(color: Colors.amber.shade500),
                        child: const Text('Add'),
                        textColor: Colors.amber.shade500,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductPage()));
                        },
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        )),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    ),
  ]);
}

Widget sectionHeader(String headerTitle, {onViewMore}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 15, top: 10),
          child: Text(headerTitle, style: h4),
        ),
      ],
    ),
  );
}


Widget headerCategoryItem(String name, IconData icon, {onPressed}) {
  return Container(
    margin: EdgeInsets.only(left: 15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(bottom: 10),
            width: 86,
            height: 86,
            child: FloatingActionButton(
              shape: CircleBorder(),
              heroTag: name,
              onPressed: onPressed,
              backgroundColor: white,
              child: Icon(icon, size: 35, color: Colors.black87),
            )),
        Text(name + ' ›', style: categoryText)
      ],
    ),
  );
}

Widget deals(String dealTitle, {onViewMore, List<Widget> items}) {
  return Container(
    margin: EdgeInsets.only(top: 5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        sectionHeader(dealTitle, onViewMore: onViewMore),
        SizedBox(
          height: 440,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: (items != null)
                ? items
                : <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text('No items available at this moment.',
                          style: taglineText),
                    )
                  ],
          ),
        )
      ],
    ),
  );
}
