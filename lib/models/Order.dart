class Order {
  String oStatus;
  String oID;
  String selectedCar;
  String dateFrom;
  String dateTo;
  int total;

  Order(
      {this.oID,
      this.oStatus,
      this.selectedCar,
      this.dateFrom,
      this.dateTo,
      this.total});
}
