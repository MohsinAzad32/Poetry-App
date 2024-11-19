// import 'package:poetry_app/model/poetry.dart';

class Category {
  final String titleenglish;
  final String titleurdu;
  final String imageurl;

  Category({
    required this.imageurl,
    required this.titleurdu,
    required this.titleenglish,
  });

  static final categories = [
    Category(
      imageurl: 'assets/life.jpeg',
      titleurdu: 'زندگی',
      titleenglish: 'Zindagi',
    ),
    Category(
      imageurl: 'assets/ansu.jpeg',
      titleurdu: 'آنسو',
      titleenglish: 'Aansu',
    ),
    Category(
      imageurl: 'assets/dard.jpeg',
      titleurdu: 'درد',
      titleenglish: 'Dard',
    ),
    Category(
      imageurl: 'assets/dua.jpeg',
      titleurdu: 'دعا',
      titleenglish: 'Dua',
    ),
    Category(
      imageurl: 'assets/dosti.jpeg',
      titleurdu: 'دوستی',
      titleenglish: 'Dosti',
    ),
    Category(
      imageurl: 'assets/eid.jpeg',
      titleurdu: 'عید',
      titleenglish: 'Eid',
    ),
    Category(
      imageurl: 'assets/eyes.jpeg',
      titleurdu: 'آنکھیں',
      titleenglish: 'Ankhein',
    ),
    Category(
      imageurl: 'assets/dil.jpeg',
      titleurdu: 'دل',
      titleenglish: 'Dil',
    ),
    Category(
      imageurl: 'assets/bewafa.jpeg',
      titleurdu: 'بے وفا',
      titleenglish: 'Bewafa',
    ),
    Category(
      imageurl: 'assets/funny.jpeg',
      titleurdu: 'مزاحیہ',
      titleenglish: 'Mazahiya',
    ),
    Category(
      imageurl: 'assets/barish.jpeg',
      titleurdu: 'بارش',
      titleenglish: 'Baarish',
    ),
    Category(
      imageurl: 'assets/gham.jpeg',
      titleurdu: 'غم',
      titleenglish: 'Gham',
    ),
    Category(
      imageurl: 'assets/luck.jpeg',
      titleurdu: 'قسمت',
      titleenglish: 'Qismat',
    ),
    Category(
      imageurl: 'assets/mosam.jpeg',
      titleurdu: 'موسم ',
      titleenglish: 'Mosam',
    ),
    Category(
      imageurl: 'assets/mekhana.jpeg',
      titleurdu: 'مے خانہ',
      titleenglish: 'Mekhana',
    ),
    Category(
      imageurl: 'assets/romantic.jpeg',
      titleurdu: 'رومانوی',
      titleenglish: 'Romantic',
    ),
    Category(
      imageurl: 'assets/tanhai.jpeg',
      titleurdu: 'تنہائی',
      titleenglish: 'Tanhai',
    ),
    Category(
      imageurl: 'assets/wait.jpeg',
      titleurdu: 'انتظار',
      titleenglish: 'Intizar',
    ),
    Category(
      imageurl: 'assets/wish.jpeg',
      titleurdu: 'خواہش',
      titleenglish: 'Khawahish',
    ),
  ];
}
