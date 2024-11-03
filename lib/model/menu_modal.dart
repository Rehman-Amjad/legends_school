class MenuModel {
  final String icon;
  final String title;
  String? routes;
  final List<MenuModel>? subItems; // Add this field to support sub-items

  MenuModel({
    required this.icon,
    required this.title,
    this.routes,
    this.subItems,
  });
}
