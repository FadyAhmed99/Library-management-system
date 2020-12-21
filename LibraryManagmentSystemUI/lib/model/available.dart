class Available {
  String id;
  String image;
  bool inLibrary = false;
  String itemLink = '';
  double lateFees = 0;
  int amount = 0;
  String location = '';

  Available(
      {this.id,
      this.image,
      this.inLibrary,
      this.itemLink,
      this.lateFees,
      this.amount,
      this.location});
      
}
