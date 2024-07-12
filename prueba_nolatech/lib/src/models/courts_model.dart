class Court {
  final String image;
  final String name;
  final String type;

  final double price;
  DateTime? startDate;
  DateTime? endDate;

  Court(
      {required this.image,
      required this.name,
      required this.type,
      required this.price,
      this.startDate,
      this.endDate});
}
