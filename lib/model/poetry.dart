class Poetry {
  final String urdu;
  final String english;
  final String category;

  Poetry({required this.urdu, required this.category, required this.english});

  static final poetry = [
    Poetry(
        urdu: '''
میرے ہوتے ہوئے گر تجھ کو نہیں فکر مری
میرے نا ہونے سے کیا فرق پڑے گا تجھ کو
''',
        category: 'Sad',
        english: '''
Mere Hote Hue gar Tujhko Nahi fikr meri
Mere na Hone se kia farq prega tujhko
'''),
    Poetry(
      urdu: '''تو نے چھوڑا تو پلٹ کر بھی نہ دیکھا
جیسے کوئی قیدی جیل سے رہا ہو کر جاۓ
''',
      category: 'Judai',
      english: '''
Tu ne chora tu palat kr bhi na dekha
jese koi qaidi jail se riha ho jaey
''',
    ),
    Poetry(
        urdu: '''
مجھے ڈھونڈنے کی کوشش اب نہ کیا کر
تو نے راستہ بدلا تو میں نے منزل بدل لی
''',
        category: 'Tanhai',
        english: '''
Mujhey Dhondne ki koshish ab na kia kr
Tu ne Rasta Badla tu mein ne manzil badal li
'''),
    Poetry(
        urdu: '''
اگر بے عیب چاھو تو فرشتوں سے نبھا کر لو
میں آدم کی نشانی ھوں خطا میری وراثت ہے
''',
        category: 'Humanity',
        english: '''
Agr be aib Chaho tu Farishton se nibah krlo
Mein Adam ki nishani hn Khata meri Virasat he
'''),
    Poetry(
        urdu: '''
جو باتیں پی گیا تھا میں
وہ باتیں کھا گئ مجھ کو
''',
        category: 'Dukh',
        english: '''
Jo Baatein Pii gya tha Mein
Vo Baatein khaa gai mujhko
'''),
    Poetry(
        urdu: '''
بے وفاہی کی سب کتابوں میں
تیرے جیسی کوئی مثال نہیں

''',
        category: 'BeWafai',
        english: '''
Bewafai ki sb kitabon mein 
Tere jese ki koi misal nhi
'''),
    Poetry(
        urdu: '''
دیکھ لو میں کیا کمال کر گیا
زندہ بھی ہو اور انتقال کر گیا
''',
        category: 'HeartBroken',
        english: '''
Dekh lo Mein kia Kamal kr gya hn
Zinda bhi hn ur intiqal kr gya hn 
'''),
    Poetry(
        urdu: '''
صدموں سے لوگ مر نہیں جاتے
تمہارے سامنے ہے مثال میری
''',
        category: 'Dukh',
        english: '''
Sadmon se log mar ni jatey
Tumharey samne misal he meri
'''),
    Poetry(
        urdu: '''
اب تو خوشی کا غم ہے نہ غم کی خوشی مجھے
بے حس بنا چکی ہے بہت زندگی مجھے
''',
        category: 'Zindagi',
        english: '''
Ab tu khushi ka gham he  na k gham ki khushi
Be his bna chuki he boht zindagi mujhey
'''),
  ];
}
