class Order {
  String userId;
  String oID;
  String oStatus;
  String selectedCar;
  String dateFrom;
  String dateTo;
  int advance;
  int total;

  Order(
      {this.oID,
      this.userId,
      this.oStatus,
      this.selectedCar,
      this.dateFrom,
      this.dateTo,
      this.advance,
      this.total});
}
