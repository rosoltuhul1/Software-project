import 'package:flutter/material.dart';
import 'package:frontend/generated/l10n.dart';
import 'package:frontend/settingpage/theme/theme_provider.dart';
import 'package:intl/intl.dart';
//import 'package:kommunicate_flutter/kommunicate_flutter.dart';
import 'package:provider/provider.dart';

class Item {
  String headerText;
  String expandedText;
  bool isExpanded;
  Item({
    required this.headerText,
    required this.expandedText,
    this.isExpanded = false,
  });
}

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {print
  final List<Item> _data = List<Item>.generate(
    5,
    (int index) {
      return Item(
        headerText: '$index',
        expandedText: '$index',
      );
    },
  );
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    _data[0] = Item(
      headerText: Intl.getCurrentLocale() == 'ar'
          ? 'ما هو اليوني تريد؟'
          : 'What is Uni-Trade?',
      expandedText: Intl.getCurrentLocale() == 'ar'
          ? 'اليوني تريد هو تطبيق جوال متخصص صمم خصيصًا لطلاب الجامعة. يعمل كمنصة تسهيل عمليات الشراء والبيع بين الطلاب داخل مجتمع الجامعة. يهدف التطبيق إلى تسهيل عملية تبادل العناصر غير المرغوب فيها، وخلق سوق مريح ومخصص حصريًا للطلاب. يوفر اليوني تريد واجهة سهلة الاستخدام للطلاب لإدراج العناصر التي يرغبون في بيعها وتصفح العناصر المتاحة للشراء من زملائهم في الجامعة.'
          : 'Uni-Trade is a specialized mobile application designed explicitly for university students. It functions as a platform facilitating the buying and selling of items among students within the university community. The app aims to streamline the process of exchanging unwanted items, creating a convenient and dedicated marketplace exclusively for students. Uni-Trade provides a user-friendly interface for students to list items they wish to sell and browse items available for purchase from fellow students.',
    );

    _data[1] = Item(
      headerText: Intl.getCurrentLocale() == 'ar'
          ? 'لماذا اليوني تريد؟'
          : 'Why Uni-Trade?',
      expandedText: Intl.getCurrentLocale() == 'ar'
          ? 'يسهل اليوني تريد بيع العناصر غير المرغوب فيها للطلاب، مما يسهل عمليات التبادل داخل مجتمع الجامعة ويقلل من العناء التقليدي. يعزز بيئة متصلة، ويشجع على تحقيق تبادلات فعالة وتفاعلات بين الطلاب. تقديم خدمات إضافية مثل التعاون مع الأعمال المحلية لتوصيل الطعام بناءً على نظام تحديد المواقع يلبي احتياجات محددة. تضمن الألمم والتقدير نظامًا آمنًا وموثوقًا، بهدف تعزيز التواصل وتبسيط حياة الجامعة.'
          : 'Uni-Trade streamlines selling unwanted items for students, facilitating easy transactions within the university community, reducing traditional hassles. It fosters a connected environment, encouraging efficient exchanges and interactions among students. Offering added services like local business collaborations for GPS-based food delivery caters to specific needs. Dedicated profiles and a rating system ensure a secure, reliable platform, aiming to enhance connectivity and simplify university life.',
    );
    _data[2] = Item(
      headerText: Intl.getCurrentLocale() == 'ar'
          ? 'ما هي الفئات في اليوني تريد؟'
          : 'What is the Categories in Uni-Trade?',
      expandedText: Intl.getCurrentLocale() == 'ar'
          ? 'الكتب التي تحتوي على نسخة إلكترونية وورقية منها، الإلكترونيات، الأجهزة الكهربائية، الأثاث، الطهي المنزلي'
          : 'Books which have softcopy and har copy of it, Electronics, Electricals, Furniture, Homemade Cooking',
    );

    _data[3] = Item(
      headerText: Intl.getCurrentLocale() == 'ar'
          ? 'ما هي فوائد عروض اليوني تريد؟'
          : 'What are the benefits of Uni-Trade offers?',
      expandedText: Intl.getCurrentLocale() == 'ar'
          ? 'الكتب التي تحتوي على نسخة إلكترونية وورقية منها، الإلكترونيات، الأجهزة الكهربائية، الأثاث، الطهي المنزلي'
          : 'Books which have softcopy and har copy of it, Electronics, Electricals, Furniture, Homemade Cooking',
    );

    _data[4] = Item(
      headerText: Intl.getCurrentLocale() == 'ar'
          ? 'كيف يمكنني إضافة العناصر التي أرغب في بيعها؟'
          : 'How can I add the items that I want to sell?',
      expandedText: Intl.getCurrentLocale() == 'ar'
          ? 'اختر فئة العنصر الذي ترغب في بيعه، ثم انقر فوق شريط إضافة العنصر في أعلى الصفحة.'
          : 'Choose the category of the item you want to sell, then click on the add item bar at the top of the page.',
    );
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Colors.black87 : Colors.white,
      // appBar: AppBar(
      //   title: Text(
      //     'FAQ',
      //     style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
      //   ),
      //   centerTitle: true,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //   ),
      // ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 16, right: 16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: themeProvider.isDarkMode
                    ? Colors.black45
                    : Colors.grey[300],
              ),
              child: Row(
                children: [
                  Text(
                    S.of(context).asset_you,
                    style: TextStyle(
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      try {
                        // String botId = 'chatgpt-zfaeb';
                        // dynamic conversationObject = {
                        //   'appId': '3751698d9f319acb7be63314811021de4',
                        //   'botIds': [botId],
                        // };
                        // dynamic result =
                        //     await KommunicateFlutterPlugin.buildConversation(
                        //         conversationObject);
                        // print("Conversation builder success : $result");
                      } on Exception catch (e) {
                        print("Conversation builder error occurred : $e");
                      }
                    },
                    child: const Icon(
                      Icons.chat_bubble_rounded,
                      color: Color.fromARGB(255, 109, 109, 109),
                      size: 25,
                    ),
                  )
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 0.0),
            child: ExpansionPanelList.radio(
              dividerColor: Colors.transparent,
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  _data[index].isExpanded = !isExpanded;
                });
              },
              expandedHeaderPadding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              children: _data.map<ExpansionPanelRadio>((Item item) {
                return ExpansionPanelRadio(
                  value: item.headerText,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return Container(
                      // color: isExpanded ? Color.fromARGB(255, 189, 245, 221) : Colors.white,
                      child: ListTile(
                        title: Text(
                          item.headerText,
                          style: TextStyle(
                              color: themeProvider.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    );
                  },
                  body: ListTile(
                    title: Text(
                      item.expandedText,
                      style: TextStyle(
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                  backgroundColor: themeProvider.isDarkMode
                      ? Colors.black45
                      : Colors.grey[300],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
