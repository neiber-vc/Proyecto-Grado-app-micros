import 'package:flutter/material.dart';

class ItemModel {
  bool expanded;
  String headerItem;
  String discription;
  String discription2;
  Color colorsItem;
  String img;

  ItemModel(
      {this.expanded: false,
      this.headerItem,
      this.discription,
      this.discription2,
      this.colorsItem,
      this.img});
}
