import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/account/EditAddress.dart';
import 'package:first_app/login_reg_pages/loading.dart';
import 'package:first_app/models/plant.dart';
import 'package:first_app/models/product.dart';
import 'package:first_app/models/specifcation.dart';
import 'package:first_app/models/transport.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/sell/specification.dart';
import 'package:first_app/sell/transport.dart';
import 'package:first_app/services/plant_service.dart';
import 'package:first_app/services/productService.dart';
import 'package:first_app/services/uploadFile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  User user;
  @override
  _AddProductState createState() => _AddProductState();

  AddProduct({this.user});

}

class _AddProductState extends State<AddProduct>{
  SpecificationProduct specificationProduct;
  TransportProduct transportProduct;
  String title='';
  String description='' ;
  String plant;
  String height='';
  String amount='';
  String category = '';
  String address;
  DateTime date=DateTime.now();
  bool enableFeature = false;
  final picker = ImagePicker();
  List<File> _image =[];
  CollectionReference imgRef;
  File imageFile;
  String quantityInStock='';
  List<Plants> listPlants = new List();
  bool viewResult = false;
  List<String> listCities = ['An Giang', 'Bà Rịa – Vũng Tàu', 'Bắc Giang', 'Bắc Kạn','Bạc Liêu', 'Bắc Ninh',
  'Bến Tre', 'Bình Định','Bình Dương','Bình Phước','Bình Thuận','Cà Mau','Cần Thơ','Cao Bằng','Đà Nẵng','Đắk Lắk','Đắk Nông','Điện Biên','Đồng Nai','Đồng Tháp','Gia Lai','Hà Giang','Hà Nam','Hà Nội','Hà Tĩnh','Hải Dương','Hải Phòng','Hậu Giang','Hòa Bình','Hưng Yên','Khánh Hòa','Kiên Giang',
  'Kon Tum','Lai Châu','Lâm Đồng','Lạng Sơn','Lào Cai','Long An','Nam Định','Nghệ An','Ninh Bình','Ninh Thuận','Phú Thọ','Phú Yên','Quảng Bình','Quảng Nam','Quảng Ngãi','Quảng Ninh','Quảng Trị','Sóc Trăng','Sơn La','Tây Ninh','Thái Bình','Thái Nguyên','Thanh Hóa','Thừa Thiên Huế','Tiền Giang','TP Hồ Chí Minh','Trà Vinh','Tuyên Quang','Vĩnh Long','Vĩnh Phúc','Yên Bái',
  ];
  whenCompleted(){
    if(this.title!='' && this.description!='' && this.specificationProduct!=null && this.amount!='' && this.height!='' && this.plant!=null && this.transportProduct!=null && this.quantityInStock != '' && this.address!=null){
      return true;
    }
    return false;
  }

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (picture != null) {
        _image.insert(0, File(picture.path));
      }
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      _image.insert(0, File(picture.path));
    });
    Navigator.of(context).pop();
  }


  @override
  void initState() {
    super.initState();
    PlantService().getPlants().then((QuerySnapshot docs){
      if(docs.documents.isNotEmpty){
        setState(() {
          this.viewResult = true;
        });
        docs.documents.forEach((element) {
          this.listPlants.add(Plants.fromJson(element.data));
        });
      }else{
        print("Empty");
      }
    });

  }

  Future<void> _showChoiceDialog(BuildContext context) {

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Thêm hình"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Chọn sẵn có"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        _openCamera(context);
                      })
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build (BuildContext context) {
    return this.viewResult ? Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF407C5A),
        iconTheme: IconThemeData(
          color: Colors.yellow,
        ),
        title: Text(
          'Thêm sản phẩm',
          style: TextStyle(color: Colors.yellow, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Container(
                  padding: EdgeInsets.all(4),
                  child: Expanded(child: SizedBox(
                    height: 150,
                    width: 300,
                    child: new GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                      itemCount: _image.length + 1,
                      itemBuilder: ((context, index){
                        return (index == 0) ? Center(
                          child: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () =>
                                  _showChoiceDialog(context)),
                        ) : Container(
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(_image[index - 1]),
                                fit: BoxFit.cover),
                          ),
                        );
                      }),
                    ),
                  ))
              )
            ]),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    filled: true,
                    hintText: 'Nhập tên sản phẩm',
                    labelText: 'Tên sản phẩm',
                    labelStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.w500),
                    hintStyle: TextStyle(fontSize: 18, color: Colors.green)
                ),
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
              ),
            ),
            Padding(
              padding:const EdgeInsets.all(8.0),
              child: Column(
                  children: [
                    Row(
                      children:[
                        Icon(Icons.add_location),
                        Text(
                          ' Cách chăm sóc ',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Color(0xFF407C5A),
                            ),
                          ),
                          hintText: 'Nhập tại đây ',
                          hintStyle: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.w500) ),
                      style: TextStyle(fontSize: 20),
                      maxLines: 6,
                      onChanged: (text){
                        description=text;
                      },

                    ),
                  ]
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: FlatButton(
                onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Specification()),
                    ).then((value){
                      if(value!=null)
                      setState(() {
                        this.specificationProduct = value;
                      });
                    });

                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.assessment_sharp),
                    Expanded(
                      child:
                      Text(
                        ' Đặc tả cây',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.monetization_on_sharp),
                  Text(
                    ' Giá sản phẩm (đồng) ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  //
                  Expanded(
                    child: new TextField(
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.green,
                          hintText: 'Nhập ',
                          hintStyle: TextStyle(color: Colors.green, decoration: TextDecoration.underline, fontSize: 18) ),
                      textDirection: TextDirection.rtl,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 20),
                      onChanged: (value){
                        this.amount = value;
                      },
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.monetization_on_sharp),
                  Text(
                    ' Chiều cao (cm) ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  //
                  Expanded(
                    child: new TextField(
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.green,
                          hintText: 'Nhập ',
                          hintStyle: TextStyle(color: Colors.green, decoration: TextDecoration.underline, fontSize: 18) ),
                      textDirection: TextDirection.rtl,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 20),
                      onChanged: (value){
                        this.height = value;
                      },
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    Row(
                      children:<Widget>[
                        Icon(Icons.class__outlined),
                        Text(
                          ' Phân loại cây ',
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Colors.black87, )
                        ),
                        contentPadding: EdgeInsets.all(10),
                      ),
                      child: DropdownButtonHideUnderline(

                        child:  DropdownButton(
                          hint: Text('Select'),
                          value: plant,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 20,
                          elevation: 16,
                          isExpanded: true,
                          isDense: true,
                          //underline: ,
                          style: const TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.w500),
                          onChanged: (newValue){
                            setState(() {
                              plant=newValue;
                            });
                          },

                          items: listPlants
                              .map((Plants value) {
                            return DropdownMenuItem<String>(
                              value: value.plantName.toString(),
                              child: Text(value.plantName.toString()),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                )
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: FlatButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Transport()),
                  ).then((value){
                    if(value!=null)
                    setState(() {
                      this.transportProduct = value;
                    });
                  });
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.train_outlined),
                    Expanded(
                      child:
                      Text(
                        ' Phí vận chuyển',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),

              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.account_balance_rounded),
                  Text(
                    ' Số lượng trong kho ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  //
                  Expanded(
                    child: new TextField(
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.green,
                          hintText: 'Nhập ',
                          hintStyle: TextStyle(color: Colors.green, decoration: TextDecoration.underline, fontSize: 18) ),
                      textDirection: TextDirection.rtl,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 20),
                      onChanged: (value){
                        this.quantityInStock = value;
                      },
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 5,),

            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: <Widget>[
                        Icon(Icons.class__outlined),
                        Text(
                          ' Địa chỉ shop ',
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
                        ),
                    SizedBox(height: 10),
                    Expanded(child: new InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Colors.black87, )
                        ),
                        contentPadding: EdgeInsets.all(10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child:  DropdownButton(
                          hint: Text('Select'),
                          value: address,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 20,
                          elevation: 16,
                          isExpanded: true,
                          isDense: true,
                          //underline: ,
                          style: const TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w500),
                          onChanged: (newValue){
                            setState(() {
                              address=newValue;
                            });
                          },

                          items: listCities
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value.toString(),
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        ),
                      ),
                    ),)
                  ],
                )
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children:<Widget> [
                  Icon(Icons.addchart),
                  Text(
                    ' Hàng đặt trước',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
                  ),
                  new Spacer(),
                  Switch(
                      activeColor: Colors.green,
                      value: enableFeature,
                      onChanged: (enabled){
                        setState(() {
                          enableFeature = enabled;
                        });
                      }
                  )
                ],
              ),
            ),
            SizedBox(height: 15,),
            RaisedButton(
              color: Color(0xFF407C5A),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              onPressed: () async {
                if(whenCompleted()==true){
                    listPlants.forEach((element) {
                      if(element.plantName == this.plant){
                        setState(() {
                          this.category =  element.categoryId.toString();
                        });
                      }
                    });
                    Product product = new Product(productName: this.title, takeCareOfTree: this.description, longevity: this.specificationProduct.age, origin: this.specificationProduct.origin, temperature: this.specificationProduct.temperature, theAmountOfWater: this.specificationProduct.theAmountOfWater,price: this.amount, height: this.height, plantID: this.plant, weight: this.transportProduct.weight, fastDelivery: this.transportProduct.fastDelivery, quantityInStock: this.quantityInStock,preOrder: this.enableFeature, address: this.address, accountID:  widget.user.uid, category: this.category);
                    String image = "https://ak.picdn.net/shutterstock/videos/2599205/thumb/1.jpg";
                    ProductService().createProduction(product).then((value){
                      if(_image.length>0){
                        var  index = 0;
                        _image.forEach((element) {
                          uploadFile().uploadImageProduct(value, element, index);
                          index ++;
                        });
                      }
                      Navigator.pop(context);
                    });
                }else {
                  Fluttertoast.showToast(msg: "Vui lòng điền đầy đủ thông tin");
                }
              },
              child: Text(
                'Lưu'.toUpperCase(),
                style: TextStyle(fontSize: 20,color: Colors.yellow,),
              ),
            )
          ],
        ),
      ),
    ) : Loading();
  }

}
