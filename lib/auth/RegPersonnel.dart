// ignore: camel_case_types
//model for database
class register_personnel {
  String uid;
  String perName;
  String email;
  bool display;
  String address;
  register_personnel({
    this.uid = "",
    this.perName = "",
    this.email = "",
    this.address = "",
    this.display = false,
  });
}
