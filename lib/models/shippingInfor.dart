class shippingInfor{
  String uid;
  String address;
  String phoneNumber;
  String name;

  shippingInfor(this.uid, this.address, this.phoneNumber, this.name);

  factory shippingInfor.fromJson(Map<String, dynamic> json) => shippingInfor(
    json['uid'],
    json['address'],
    json['phoneNumber'],
   json['name']
  );
}