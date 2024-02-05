import 'package:compan/Pricespage.dart';
import 'package:flutter/material.dart';

class homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيقك',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: ListView(
            children: [
              Container(
                padding: EdgeInsets.only(top: 2, left: 2, right: 2, bottom: 2),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(-23, 36, 130, 111),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PopupMenuButton<String>(
                          onSelected: (value) {
                            // تنفيذ الإجراء المناسب عند تحديد عنصر من القائمة الفرعية
                            if (value == 'Task 1') {
                              // إجراء 1
                            } else if (value == 'Task 2') {
                              // إجراء 2
                            } else if (value == 'Task 3') {
                              // إجراء 3
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem<String>(
                                value: 'Task 1',
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.shopping_cart,
                                      color: const Color.fromARGB(
                                          -23, 36, 130, 111),
                                    ), // أيقونة العنصر
                                    SizedBox(
                                        width: 10), // مسافة بين الأيقونة والنص
                                    Text('طلباتي الأخيرة'), // النص
                                  ],
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: 'Task 2',
                                child: Row(
                                  children: [
                                    Icon(
                                      //fromARGB(-23, 36, 130, 111)
                                      Icons.inbox,
                                      color: Color.fromARGB(-23, 36, 130, 111),
                                    ), // أيقونة العنصر
                                    SizedBox(
                                        width: 10), // مسافة بين الأيقونة والنص
                                    Text('شحناتي الأخيرة'), // النص
                                  ],
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: 'Task 3',
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.exit_to_app,
                                      color: Colors.red,
                                    ), // أيقونة العنصر
                                    SizedBox(
                                        width: 10), // مسافة بين الأيقونة والنص
                                    Text('تسجيل خروج'), // النص
                                  ],
                                ),
                              ),
                            ];
                          },
                          child: Icon(
                            Icons.menu,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.notifications,
                          size: 30,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(left: 3, bottom: 15),
                      child: Text(
                        "Hi username",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          wordSpacing: 2,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    buildMenuItem(Icons.local_shipping, 'شحناتي', context,
                        size: 30, fontSize: 14),
                    buildMenuItem(Icons.shopping_cart, 'طلباتي', context,
                        size: 30, fontSize: 14),
                    buildMenuItem(Icons.home, 'الرئيسية', context,
                        size: 30, fontSize: 14),
                    buildMenuItem(Icons.attach_money, 'الأسعار', context,
                        size: 30, fontSize: 14),
                    buildMenuItem(Icons.location_on, 'عناويني', context,
                        size: 30, fontSize: 14),
                    buildMenuItem(Icons.settings, 'الإعدادات', context,
                        size: 30, fontSize: 14),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(
    IconData icon,
    String title,
    BuildContext context, {
    double size = 40,
    double fontSize = 16,
  }) {
    return InkWell(
      onTap: () {
        if (title == 'الأسعار') {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => pricepagee(),
              ));
        }
      }, //?
      child: Container(
        width: 120,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: size,
              color: Color.fromARGB(-23, 36, 130, 111),
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
                color: Color.fromARGB(-23, 36, 130, 111),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCurrencyItem(String currency, String rate) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(-23, 36, 130, 111),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            currency,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            rate,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
