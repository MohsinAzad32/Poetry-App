class Poet {
  final String poetname;
  final String imageurl;
  final String urdu;

  Poet({required this.imageurl, required this.poetname, required this.urdu});

  static final poets = [
    Poet(
      imageurl: 'assets/faraz.jpeg',
      poetname: 'Ahmad Faraz',
      urdu: 'احمد فراز',
    ),
    Poet(
      imageurl: 'assets/parveen.png',
      poetname: 'Parveen Shaakir',
      urdu: 'پروین شاکر',
    ),
    Poet(
      imageurl: 'assets/john.jpeg',
      poetname: 'John Elia',
      urdu: 'جون ایلیا',
    ),
    Poet(
      imageurl: 'assets/hafi.jpeg',
      poetname: 'Tehzeeb Haafi',
      urdu: 'تہذیب حافی',
    ),
    Poet(
      imageurl: 'assets/Ali.jpeg',
      poetname: 'Ali Zaryoun',
      urdu: ' علی زریون',
    ),
    Poet(
      imageurl: 'assets/wasi.jpeg',
      poetname: 'Wasi Shah',
      urdu: 'وصی شاہ',
    ),
  ];
}
