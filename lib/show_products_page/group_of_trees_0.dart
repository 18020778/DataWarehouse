import 'package:first_app/models/plant.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/show_products_page/show_items_page_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListGroupOfTrees extends StatelessWidget {
  User user;
  List<Plants> listPlants = new List();
  ListGroupOfTrees(this.listPlants, this.user);

  @override
  Widget build(BuildContext context) {
    var glength = this.listPlants.length;
    List<Widget> banners = new List<Widget>();
    for (int i = 0; i < this.listPlants.length; i++) {
      var bannerView = Container(
        child: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ShowItemPage(this.listPlants[i], this.user)));
          },
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
                child: Image.network(this.listPlants[i].getImageUrl().toString(), width: 70, height: 69,),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                this.listPlants[i].getPlantName(),
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
              )
            ],
          ),
        ),
      );
      banners.add(bannerView);
    }

    return Container(
      height: (glength % 4 == 0)
          ? (glength / 4) * 110
          : (glength / 4 + 1) * 110,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(4291751385)],
          )),
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 15.0,
        crossAxisSpacing: 4.0,
        children: banners.toList(),
      ),
    );
  }
}
