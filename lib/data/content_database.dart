import '../models/models.dart';

class ContentDatabase {
  // A complete database of Lessons
  static final List<Lesson> lessons = [
    // === SECTION 1: HINDU DHARMA INTRODUCTION ===
    Lesson(
      id: 'intro_what_is_hindu_dharma',
      title: 'What is Hindu Dharma?',
      category: 'Introduction',
      level: 'Beginner',
      imageUrl: 'OM_SYMBOL',
      imageCaption: 'The sacred Pranava symbol "Om" representing the cosmic vibration of Brahman.',
      titleTranslations: {
        'English': 'What is Hindu Dharma?',
        'Roman English': 'Hindu Dharma kya hai?',
        'Urdu': 'ہندو دھرم کیا ہے؟',
        'Sindhi': 'هندو دھرم ڇا آهي؟'
      },
      contentTranslations: {
        'English': 'Hindu Dharma, known traditionally as Sanatana Dharma, is one of the oldest living spiritual traditions. It is not just a religion with a single founder or strict dogma, but a rich family of philosophies, spiritual paths, values, and practices that guide individuals toward righteousness (Dharma) and ultimate spiritual liberation (Moksha).',
        'Roman English': 'Hindu Dharma ko traditional way mein Sanatana Dharma kaha jata hai. Yeh koi simple religion nahi hai jise kisi single founder ne banaya ho. Yeh ek dynamic family of philosophies, spiritual paths aur dynamic practices hai jo life ko righteousness (Dharma) aur liberation (Moksha) ki taraf guide karti hai.',
        'Urdu': 'ہندو دھرم، جسے روایتی طور پر سناتن دھرم کہا جاتا ہے، دنیا کے قدیم ترین روحانی سلسلوں میں سے ایک ہے۔ اس کا کوئی ایک بانی یا سخت عقیدہ نہیں ہے، بلکہ یہ فلسفے، سچائی اور نیک راستوں کا ایک خوبصورت مجموعہ ہے جو انسان کو نجات (موکش) کی طرف لے جاتا ہے۔',
        'Sindhi': 'هندو دھرم، جنهن کي روايتي طور تي سناتن دھرم چيو ويندو آهي، دنيا جي قديم ترين روحاني روايتن مان هڪ آهي. ان جو ڪو هڪ باني ناهي، پر هي سچائي ۽ نيڪيءَ جو هڪ رستو آهي جيڪو انسان کي نجات (موڪش) ڏانهن وٺي وڃي ٿو.'
      },
      simpleExplanationTranslations: {
        'English': 'Hindu Dharma is a spiritual way of life focusing on cosmic harmony, duty, and spiritual liberation.',
        'Roman English': 'Hindu Dharma ek spiritual lifestyle hai jo duty aur liberation par focus karta hai.',
        'Urdu': 'ہندو دھرم زندگی گزارنے کا ایک روحانی طریقہ ہے جو اچھے کاموں، فرض اور روح کی آزادی پر مرکوز ہے۔',
        'Sindhi': 'هندو دھرم زندگي گذارڻ جو هڪ روحاني طريقو آهي جيڪو نيڪي، فرض ۽ روح جي آزاديءَ تي ٻڌل آهي.'
      },
      exampleTranslations: {
        'English': 'Just like many rivers lead to the same ocean, different paths (Yogas) in Hindu Dharma lead to the same ultimate truth.',
        'Roman English': 'Jaise bohot si nadiyaan ek hi ocean mein milti hain, waise hi alag-alag paths (Yogas) ek hi truth tak pahunchate hain.',
        'Urdu': 'جس طرح بہت سے دریا ایک ہی سمندر میں جا کر ملتے ہیں، اسی طرح مختلف راستے (یوگا) ایک ہی سچائی تک پہنچاتے ہیں۔',
        'Sindhi': 'جيئن گهڻيون نديون هڪ ئي سمنڊ ۾ وڃي ملن ٿيون، تيئن مختلف رستا (يوگا) هڪ ئي سچائيءَ تائين پهچائين ٿا.'
      },
      deeperExplanationTranslations: {
        'English': 'In Hindu Dharma, the universe is seen as governed by cosmic order. Truth is infinite and can be realized through multiple spiritual approaches (such as Bhakti, Jnana, Karma, or Raja Yoga). It emphasizes personal spiritual experience, self-realization, and treating all life forms with respect.',
        'Roman English': 'Isme bataya jata hai ki universe ek cosmic law se chalta hai. Sachaai bohot badi hai aur isse alag tareeqon se paya ja sakta hai. Yeh sabhi living beings ki respect karne par zor deta hai.',
        'Urdu': 'ہندو دھرم میں کائنات کو ایک الہی قانون کے تحت چلتے ہوئے دیکھا جاتا ہے۔ سچائی لامحدود ہے اور اسے مختلف روحانی طریقوں (جیسے بھکتی، گیان یا کرما) سے حاصل کیا جا سکتا ہے۔ یہ تمام جانداروں کا احترام کرنے پر زور دیتا ہے۔',
        'Sindhi': 'هندو دھرم ۾ ڪائنات کي هڪ الاهي قانون جي تحت هلندي ڏٺو وڃي ٿو. سچائي لامحدود آهي ۽ ان کي مختلف روحاني طريقن سان حاصل ڪري سگهجي ٿو. هي تمام ساهوارن جي احترام تي زور ڏئي ٿو.'
      },
      keyPointsTranslations: {
        'English': ['Hindu Dharma has no single historical founder.', 'It is also called Sanatana Dharma (Eternal Way).', 'It offers multiple spiritual paths tailored to diverse human temperaments.'],
        'Roman English': ['Dharma ka koi single founder nahi hai.', 'Isko Sanatana Dharma (timeless path) bhi kehte hain.', 'Yeh sab ke liye unke nature ke hisab se raste batata hai.'],
        'Urdu': ['ہندو دھرم کا کوئی ایک بانی نہیں ہے۔', 'اسے سناتن دھرم (ہمیشہ رہنے والا راستہ) بھی کہتے ہیں۔', 'یہ ہر انسان کے مزاج کے مطابق مختلف روحانی راستے فراہم کرتا ہے۔'],
        'Sindhi': ['هندو دھرم جو ڪو هڪ باني ناهي.', 'ان کي سناتن دھرم (هميشه رهندڙ رستو) به چيو ويندو آهي.', 'هي هر انسان جي مزاج مطابق مختلف روحاني رستا فراهم ڪري ٿو.']
      },
      visualDiagramType: 'Dharma',
      sources: ['Rig Veda 1.164.46 ("Ekam Sat Vipra Bahudha Vadanti")', 'Bhagavad Gita'],
      relatedTopics: ['Sanatana Dharma', 'Dharma', 'Karma'],
      quizQuestions: [
        QuizQuestion(
          id: 'q_what_is_dharma_1',
          category: 'Introduction',
          type: QuizType.multipleChoice,
          questionTranslations: {
            'English': 'What is the traditional Sanskrit name for Hindu Dharma?',
            'Roman English': 'Hindu Dharma ka traditional Sanskrit naam kya hai?',
            'Urdu': 'ہندو دھرم کا روایتی سنسکرت نام کیا ہے؟',
            'Sindhi': 'هندو دھرم جو روايتي سنسڪرت نالو ڇا آهي؟'
          },
          optionsTranslations: {
            'English': ['Sanatana Dharma', 'Bhakti Marg', 'Karma Siddhanta', 'Siddha Yoga'],
            'Roman English': ['Sanatana Dharma', 'Bhakti Marg', 'Karma Siddhanta', 'Siddha Yoga'],
            'Urdu': ['سناتن دھرم', 'بھکتی مارگ', 'کرما سدھانت', 'سدھا یوگا'],
            'Sindhi': ['سناتن دھرم', 'ڀڪتي مارڳ', 'ڪرم سڌانت', 'سڌا يوگا']
          },
          correctAnswerTranslations: {
            'English': 'Sanatana Dharma',
            'Roman English': 'Sanatana Dharma',
            'Urdu': 'سناتن دھرم',
            'Sindhi': 'سناتن دھرم'
          },
          explanationTranslations: {
            'English': '"Sanatana Dharma" translates to the Eternal Way or Eternal Law, highlighting its ancient and timeless nature.',
            'Roman English': '"Sanatana Dharma" ka matlab hai Eternal Way ya timeless law.',
            'Urdu': '"سناتن دھرم" کا ترجمہ ہمیشہ رہنے والا راستہ یا ابدی قانون ہے، جو اس کی قدیم فطرت کو ظاہر کرتا ہے۔',
            'Sindhi': '"سناتن دھرم" جو ترجمو هميشه رهندڙ رستو يا ابدي قانون آهي، جيڪو ان جي قديم هجڻ کي ظاهر ڪري ٿو.'
          },
          difficulty: 'Beginner',
        )
      ],
      flashcards: [
        Flashcard(
          id: 'fc_intro_dharma_1',
          category: 'Introduction',
          imageUrl: 'OM_SYMBOL',
          frontTranslations: {
            'English': 'Sanatana Dharma',
            'Roman English': 'Sanatana Dharma',
            'Urdu': 'سناتن دھرم',
            'Sindhi': 'سناتن دھرم'
          },
          backTranslations: {
            'English': 'The Eternal Order / Eternal Way',
            'Roman English': 'Hamesha rehne wala rasta',
            'Urdu': 'ابدی قانون / ہمیشہ رہنے والا راستہ',
            'Sindhi': 'ابدي قانون / هميشه رهندڙ رستو'
          },
          explanationTranslations: {
            'English': 'The traditional Sanskrit name for Hindu Dharma, representing its timeless principles of cosmic righteousness and spiritual growth.',
            'Roman English': 'Hindu Dharma ka asli sanskrit naam jo hamesha rehne wale sach ko batata hai.',
            'Urdu': 'ہندو دھرم کا روایتی نام، جو کائناتی سچائی اور اخلاقی اصولوں کی نمائندگی کرتا ہے۔',
            'Sindhi': 'هندو دھرم جو روايتي نالو، جيڪو ڪائناتي سچائي ۽ اخلاقي اصولن جي نمائندگي ڪري ٿو.'
          },
          exampleTranslations: {
            'English': 'Living truthfully and in harmony with nature is practicing Sanatana Dharma.',
            'Roman English': 'Sach bolna aur nature ke sath prem se rehna Sanatana Dharma hai.',
            'Urdu': 'سچائی کے ساتھ جینا اور قدرت کے ساتھ ہم آہنگی رکھنا سناتن دھرم کی مشق ہے۔',
            'Sindhi': 'سچائيءَ سان جيئڻ ۽ قدرت سان هم آهنگي رکڻ سناتن دھرم آهي.'
          },
          relatedConcept: 'Dharma',
        )
      ],
    ),
    Lesson(
      id: 'intro_sanatana_dharma',
      title: 'What is Sanatana Dharma?',
      category: 'Introduction',
      level: 'Beginner',
      imageUrl: 'SUN_TEMPLE',
      imageCaption: 'The ancient Sun Temple, symbolizing the eternal light of Truth in Sanatana Dharma.',
      titleTranslations: {
        'English': 'What is Sanatana Dharma?',
        'Roman English': 'Sanatana Dharma kya hai?',
        'Urdu': 'سناتن دھرم کیا ہے؟',
        'Sindhi': 'سناتن دھرم ڇا آهي؟'
      },
      contentTranslations: {
        'English': '"Sanatana" means eternal, timeless, or that which has no beginning or end. "Dharma" comes from the root word "dhri", meaning to uphold, support, or sustain. Together, Sanatana Dharma refers to the eternal cosmic laws and righteous principles that sustain the entire universe and all living beings.',
        'Roman English': '"Sanatana" ka matlab hai eternal ya timeless, jiska koi beginning ya end nahi hota. "Dharma" "dhri" word se bana hai jiska matlab hai sustain karna. Sanatana Dharma wo values hain jo pure universe ko chalati hain.',
        'Urdu': '"سناتن" کا مطلب ہے ابدی یا وہ جس کا کوئی آغاز یا انجام نہ ہو۔ "دھرم" کا مطلب ہے سنبھالنا یا سہارا دینا۔ سناتن دھرم ان ابدی اصولوں کو کہتے ہیں جو پوری کائنات کو توازن میں رکھتے ہیں۔',
        'Sindhi': '"سناتن" جو مطلب آهي ابدي يا اهو جنهن جي ڪا شروعات يا پڄاڻي نه هجي. "دھرم" جو مطلب آهي سنڀالڻ يا سهارو ڏيڻ. سناتن دھرم انهن ابدي اصولن کي چيو ويندو آهي جيڪي سڄي ڪائنات کي توازن ۾ رکن ٿا.'
      },
      simpleExplanationTranslations: {
        'English': 'Sanatana Dharma is the eternal natural law and moral order that sustains creation.',
        'Roman English': 'Sanatana Dharma wo natural rules hain jo creation ko chalate hain.',
        'Urdu': 'سناتن دھرم وہ ابدی قانون ہے جو کائنات کی تخلیق اور اخلاق کو قائم رکھتا ہے۔',
        'Sindhi': 'سناتن دھرم اهو ابدي قانون آهي جيڪو ڪائنات جي تخليق ۽ اخلاق کي قائم رکي ٿو.'
      },
      exampleTranslations: {
        'English': 'Water flowing downwards, fire giving heat, and a human speaking truth are all examples of executing their natural Dharma.',
        'Roman English': 'Pani ka behna, aag ka garmi dena aur insaan ka sach bolna unka natural Dharma hai.',
        'Urdu': 'پانی کا نیچے کی طرف بہنا، آگ کا گرمی دینا، اور انسان کا سچ بولنا ان کے قدرتی دھرم کی مثالیں ہیں۔',
        'Sindhi': 'پاڻيءَ جو هيٺ وهڻ، باهه جو گرمي ڏيڻ، ۽ انسان جو سچ ڳالهائڻ انهن جي قدرتي دھرم جا مثال آهن.'
      },
      deeperExplanationTranslations: {
        'English': 'While historical names like Hinduism came from geographic terms (referring to people living near the Indus/Sindhu River), Sanatana Dharma represents the core universal values (like truth, compassion, non-violence, purity, and self-restraint) which are applicable to everyone, everywhere, at any time.',
        'Roman English': 'Hinduism naam geographic area se aaya, par Sanatana Dharma universal values (sach, compassion, non-violence) ko kehte hain.',
        'Urdu': 'اگرچہ ہندو دھرم کا لفظ جغرافیائی اصطلاح (دریائے سندھ کے پاس رہنے والے) سے آیا، لیکن سناتن دھرم کائناتی اقدار (جیسے سچ، رحم دلی، اور عدم تشدد) کی نمائندگی کرتا ہے جو ہر جگہ لاگو ہوتی ہیں۔',
        'Sindhi': 'جيتوڻيڪ هندو دھرم لفظ جاگرافيائي اصطلاح (سنڌو نديءَ ڪناري رهندڙن) مان آيو، پر سناتن دھرم ڪائناتي قدرن (جهڙوڪ سچ، رحم دلي، ۽ اهنسا) جي نمائندگي ڪري ٿو.'
      },
      keyPointsTranslations: {
        'English': ['Sanatana means timeless or eternal.', 'Dharma represents that which sustains the individual and society.', 'It comprises universal moral values like truthfulness (Satya) and non-injury (Ahimsa).'],
        'Roman English': ['Sanatana ka matlab hamesha rehne wala.', 'Dharma insaan aur society ko jode rakhta hai.', 'Isme Satya (sach) aur Ahimsa (non-violence) shamil hain.'],
        'Urdu': ['سناتن کا مطلب ہے ہمیشہ رہنے والا۔', 'دھرم وہ ہے جو فرد اور معاشرے کو قائم رکھتا ہے۔', 'اس میں سچائی (ستیہ) اور عدم تشدد (اہنسا) جیسے اخلاقی اصول شامل ہیں۔'],
        'Sindhi': ['سناتن جو مطلب آهي هميشه رهندڙ.', 'دھرم اهو آهي جيڪو فرد ۽ سماج کي قائم رکي ٿو.', 'هن ۾ سچائي (ستيا) ۽ اهنسا جهڙا اخلاقي اصول شامل آهن.']
      },
      visualDiagramType: 'Dharma',
      sources: ['Manu Smriti 10.63', 'Mahabharata'],
      relatedTopics: ['What is Hindu Dharma?', 'Dharma', 'Ahimsa'],
      quizQuestions: [
        QuizQuestion(
          id: 'q_sanatana_1',
          category: 'Introduction',
          type: QuizType.multipleChoice,
          questionTranslations: {
            'English': 'What does the Sanskrit root word "dhri" mean?',
            'Roman English': 'Sanskrit root word "dhri" ka matlab kya hai?',
            'Urdu': 'سنسکرت لفظ "دھری" کا کیا مطلب ہے؟',
            'Sindhi': 'سنسڪرت لفظ "ڌري" جو ڇا مطلب آهي؟'
          },
          optionsTranslations: {
            'English': ['To destroy', 'To run', 'To uphold, support, or sustain', 'To sleep'],
            'Roman English': ['Nisht karna', 'Bhagna', 'Uphold aur sustain karna', 'Sona'],
            'Urdu': ['تباہ کرنا', 'بھاگنا', 'قائم رکھنا، سہارا دینا یا سنبھالنا', 'سونا'],
            'Sindhi': ['تباهه ڪرڻ', 'بڄڻ', 'قائم رکڻ، سهارو ڏيڻ يا سنڀالڻ', 'سمهڻ']
          },
          correctAnswerTranslations: {
            'English': 'To uphold, support, or sustain',
            'Roman English': 'Uphold aur sustain karna',
            'Urdu': 'قائم رکھنا، سہارا دینا یا سنبھالنا',
            'Sindhi': 'قائم رکڻ، سهارو ڏيڻ يا سنڀالڻ'
          },
          explanationTranslations: {
            'English': '"Dharma" is derived from the root "dhri", which means to uphold, sustain, or keep in balance.',
            'Roman English': 'Dharma "dhri" se bana hai jiska matlab balance banana hai.',
            'Urdu': '"دھرم" کا لفظ "دھری" سے نکلا ہے، جس کا مطلب ہے قائم رکھنا یا توازن میں رکھنا۔',
            'Sindhi': '"دھرم" لفظ "ڌري" مان نڪتل آهي، جنهن جو مطلب آهي قائم رکڻ يا توازن ۾ رکڻ.'
          },
          difficulty: 'Beginner',
        )
      ],
      flashcards: [
        Flashcard(
          id: 'fc_sanatana_1',
          category: 'Introduction',
          imageUrl: 'SUN_TEMPLE',
          frontTranslations: {
            'English': 'Dhri (Sanskrit Root)',
            'Roman English': 'Dhri',
            'Urdu': 'دھری (سنسکرت لفظ)',
            'Sindhi': 'ڌري (سنسڪرت اکر)'
          },
          backTranslations: {
            'English': 'To sustain, support, or uphold.',
            'Roman English': 'Support aur sustain karna',
            'Urdu': 'سنبھالنا، سہارا دینا یا قائم رکھنا',
            'Sindhi': 'سنڀالڻ، سهارو ڏيڻ يا قائم رکڻ'
          },
          explanationTranslations: {
            'English': 'The linguistic foundation of the word "Dharma". It indicates that which keeps things in cosmic and ethical balance.',
            'Roman English': 'Dharma word ka main root jo balance ko dikhata hai.',
            'Urdu': 'لفظ "دھرم" کی بنیاد۔ یہ اس بات کی نشاندہی کرتا ہے جو چیزوں کو اخلاقی توازن میں رکھتی ہے۔',
            'Sindhi': 'لفظ "دھرم" جو بنياد. هي ان ڳالهه کي ظاهر ڪري ٿو جيڪا شين کي توازن ۾ رکي ٿي.'
          },
          exampleTranslations: {
            'English': 'Just like gravitational force holds planets in orbits, Dharma holds society in peace.',
            'Roman English': 'Jaise gravity planets ko jode rakhti hai, waise hi Dharma society ko jode rakhta hai.',
            'Urdu': 'جس طرح کشش ثقل سیاروں کو مدار میں رکھتی ہے، اسی طرح دھرم معاشرے کو امن میں رکھتا ہے۔',
            'Sindhi': 'جيئن ڪشش ثقل سيارن کي مدار ۾ رکي ٿي، تيئن دھرم سماج ۾ امن قائم رکي ٿو.'
          },
          relatedConcept: 'Dharma',
        )
      ],
    ),
    // === SECTION 2: CORE CONCEPTS ===
    Lesson(
      id: 'core_karma',
      title: 'Concept of Karma',
      category: 'Core Concepts',
      level: 'Beginner',
      imageUrl: 'BOOMERANG',
      imageCaption: 'The seed and plant cycle, showing how actions yield corresponding consequences.',
      titleTranslations: {
        'English': 'Concept of Karma',
        'Roman English': 'Karma ka Concept',
        'Urdu': 'کرما کا تصور',
        'Sindhi': 'ڪرم جو تصور'
      },
      contentTranslations: {
        'English': 'Karma means action. Every physical, mental, or verbal action has a reaction. Good actions bring good results. Bad actions bring bad results. Karma teaches absolute responsibility for your actions.',
        'Roman English': 'Karma ka matlab action hai. Har physical, mental ya bolne wale action ka ek reaction hota hai. Achhe kaam ka achha result, bure ka bura result hota hai.',
        'Urdu': 'کرما کا مطلب عمل ہے۔ ہر جسمانی، ذہنی یا زبانی عمل کا ایک ردعمل ہوتا ہے۔ اچھے اعمال سے اچھے نتائج ملتے ہیں۔ برے اعمال سے برے نتائج ملتے ہیں۔ کرما ہمیں اپنے اعمال کی مکمل ذمہ داری سکھاتا ہے۔',
        'Sindhi': 'ڪرم جو مطلب عمل آهي. هر جسماني، ذهني يا زباني عمل جو هڪ ردعمل ٿئي ٿو. چڱن عملن مان چڱا نتيجا ۽ برن عملن مان برا نتيجا ملن ٿا. ڪرم اسان کي پنهنجي عملن جي مڪمل ذميواري سيکاري ٿو.'
      },
      simpleExplanationTranslations: {
        'English': 'Karma is the universal law of cause and effect. You are responsible for your own life choices.',
        'Roman English': 'Karma ka matlab cause and effect law hai. Aap apne choices ke khud zimmedar hain.',
        'Urdu': 'کرما کائنات کا وہ قانون ہے جس کے تحت ہر عمل کا بدلہ ملتا ہے۔ آپ اپنی زندگی کے فیصلوں کے خود ذمہ دار ہیں۔',
        'Sindhi': 'ڪرم ڪائنات جو اهو قانون آهي جنهن جي تحت هر عمل جو بدلو ملي ٿو. توهان پنهنجي زندگيءَ جي فيصلن جا پاڻ ذميوار آهيو.'
      },
      exampleTranslations: {
        'English': 'If you plant sweet mango seeds, you will harvest sweet mangoes, not bitter weeds. Similarly, kind acts generate happiness.',
        'Roman English': 'Agar aap aam ka beej boyenge toh aam hi milega, kadwi jhaadiyan nahi. Waise hi acche kamo se khushi milti hai.',
        'Urdu': 'اگر آپ آم کا بیج بوئیں گے تو آپ کو میٹھے آم ملیں گے، کڑوی جھاڑیاں نہیں۔ اسی طرح، ہمدردی کے کام خوشی لاتے ہیں۔',
        'Sindhi': 'جيڪڏهن توهان انب جو ٻج پوکيندا ته توهان کي مٺا انب ملندا، ڪڙيون ٻاجهريون نه. اهڙيءَ طرح همدرديءَ جا ڪم خوشي آڻين ٿا.'
      },
      deeperExplanationTranslations: {
        'English': 'Karma operates across past, present, and future lifetimes. Sanchita is the total accumulated karma, Prarabdha is the karma active now shaping your current life, and Agami is the karma you are creating now by your current choices.',
        'Roman English': 'Karma past, present aur future lives mein kaam karta hai. Sanchita purana jama karma hai, Prarabdha jo abhi chal raha hai, aur Agami jo aap abhi naye choices se bana rahe hain.',
        'Urdu': 'کرما ماضی، حال اور مستقبل کی زندگیوں پر اثر انداز ہوتا ہے۔ سنچیت مجموعی کرما ہے، پرارب دھ وہ کرما ہے جو ابھی اثر دکھا رہا ہے، اور آگامی وہ کرما ہے جو آپ اپنے موجودہ فیصلوں سے بنا رہے ہیں۔',
        'Sindhi': 'ڪرم ماضي، حال ۽ مستقبل جي زندگين تي اثر انداز ٿئي ٿو. سنچيت گڏ ٿيل ڪرم آهي، پراربڌ اهو ڪرم آهي جيڪو هاڻي اثر ڏيکاري ٿو، ۽ آگامي اهو ڪرم آهي جيڪو توهان هاڻي ٺاهي رهيا آهيو.'
      },
      keyPointsTranslations: {
        'English': ['Karma means every action has a corresponding reaction.', 'You have the free will to choose your current actions.', 'Noble deeds purify the mind and lead to peace.'],
        'Roman English': ['Karma ka matlab har action ka reaction hota hai.', 'Aapke paas naye actions chunne ki azadi hai.', 'Acche kamo se mind saaf hota hai aur peace milti hai.'],
        'Urdu': ['کرما کا مطلب ہے کہ ہر عمل کا ایک مساوی ردعمل ہوتا ہے۔', 'آپ کو اپنے موجودہ اعمال چننے کی مکمل آزادی حاصل ہے۔', 'نیک اعمال ذہن کو پاک کرتے ہیں اور امن لاتے ہیں۔'],
        'Sindhi': ['ڪرم جو مطلب آهي ته هر عمل جو هڪ جهڙو ردعمل ٿئي ٿو.', 'توهان کي پنهنجي هاڻوڪن عملن چونڊڻ جي مڪمل آزادي آهي.', 'نيڪ عمل ذهن کي پاڪ ڪن ٿا ۽ امن آڻين ٿا.']
      },
      visualDiagramType: 'Karma',
      sources: ['Yajur Veda 40.2', 'Bhagavad Gita 2.47'],
      relatedTopics: ['Dharma', 'Samsara', 'Moksha'],
      quizQuestions: [
        QuizQuestion(
          id: 'q_karma_core_1',
          category: 'Core Concepts',
          type: QuizType.multipleChoice,
          questionTranslations: {
            'English': 'What does the word "Karma" literally mean?',
            'Roman English': 'Karma word ka literal matlab kya hai?',
            'Urdu': 'لفظ "کرما" کا لفظی مطلب کیا ہے؟',
            'Sindhi': 'لفظ "ڪرم" جو لفظي مطلب ڇا آهي؟'
          },
          optionsTranslations: {
            'English': ['Action', 'Dream', 'Sleep', 'Forgetfulness'],
            'Roman English': ['Action / Kaam', 'Sapna', 'Neend', 'Bhoolna'],
            'Urdu': ['عمل (کام)', 'خواب', 'نیند', 'بھول جانا'],
            'Sindhi': ['عمل (ڪم)', 'خواب', 'ننڊ', 'وسارڻ']
          },
          correctAnswerTranslations: {
            'English': 'Action',
            'Roman English': 'Action / Kaam',
            'Urdu': 'عمل (کام)',
            'Sindhi': 'عمل (ڪم)'
          },
          explanationTranslations: {
            'English': 'The word "Karma" literally translates to action or deed in Sanskrit.',
            'Roman English': 'Sanskrit mein Karma ka matlab action hota hai.',
            'Urdu': 'سنسکرت میں لفظ "کرما" کا لفظی ترجمہ عمل یا کام ہے۔',
            'Sindhi': 'سنسڪرت ۾ "ڪرم" لفظ جو لفظي ترجمو عمل يا ڪم آهي.'
          },
          difficulty: 'Beginner',
        )
      ],
      flashcards: [
        Flashcard(
          id: 'fc_core_karma_1',
          category: 'Core Concepts',
          imageUrl: 'BOOMERANG',
          frontTranslations: {
            'English': 'Karma',
            'Roman English': 'Karma',
            'Urdu': 'کرما',
            'Sindhi': 'ڪرم'
          },
          backTranslations: {
            'English': 'Action and reaction law',
            'Roman English': 'Action-reaction ka niyam',
            'Urdu': 'عمل اور ردعمل کا قانون',
            'Sindhi': 'عمل ۽ ردعمل جو قانون'
          },
          explanationTranslations: {
            'English': 'The universal moral law that every choice you make brings a corresponding result.',
            'Roman English': 'Universal moral law jo batata hai ki har choice ka ek result milta hai.',
            'Urdu': 'وہ کائناتی اخلاقی قانون جس کے مطابق ہر اچھا یا برا کام اپنا اثر لاتا ہے۔',
            'Sindhi': 'اهو ڪائناتي اخلاقي قانون جنهن مطابق هر سٺو يا بڇڙو ڪم پنهنجو اثر ڏيکاري ٿو.'
          },
          exampleTranslations: {
            'English': 'Helping a friend in need brings happiness back to you.',
            'Roman English': 'Kisi dost ki help karne se aapko khud khushi milti hai.',
            'Urdu': 'کسی ضرورت مند دوست کی مدد کرنا آپ کی طرف خوشی واپس لاتا ہے۔',
            'Sindhi': 'ڪنهن ضرورت مند دوست جي مدد ڪرڻ توهان ڏانهن خوشي واپس آڻي ٿو.'
          },
          relatedConcept: 'Karma',
        )
      ],
    )
  ];

  // A complete list of Scriptures
  static final List<Scripture> scriptures = [
    Scripture(
      id: 'text_vedas',
      title: 'The Four Vedas',
      type: 'Vedas',
      imageUrl: 'VEDAS_MANUSCRIPT',
      titleTranslations: {
        'English': 'The Four Vedas',
        'Roman English': 'Chaar Ved',
        'Urdu': 'چار وید',
        'Sindhi': 'چار ويد'
      },
      descriptionTranslations: {
        'English': 'The Vedas are the foundational and most sacred scriptures of Hindu Dharma. Regarded as revealed wisdom, they contain prayers, cosmology, and spiritual philosophy.',
        'Roman English': 'Vedas Hindu Dharma ke sabse purane aur sacred scriptures hain, jisme prayers aur spiritual gyan shamil hai.',
        'Urdu': 'وید ہندو دھرم کے بنیادی اور سب سے مقدس صحیفے ہیں۔ یہ الہی حکمت مانے جاتے ہیں اور ان میں دعائیں، فلسفہ اور سچائیاں شامل ہیں۔',
        'Sindhi': 'ويد هندو دھرم جا بنيادي ۽ سڀ کان مقدس ڪتاب آهن. اهي الاهي حڪمت مڃيا وڃن ٿا ۽ انهن ۾ دعائون ۽ روحاني سچايون شامل آهن.'
      },
      themes: ['Mantras & Prayers', 'Cosmology', 'Spiritual Philosophy'],
      importanceTranslations: {
        'English': 'They form the ultimate authority of knowledge (Shruti) behind almost all later Hindu philosophy.',
        'Roman English': 'Vedas pure Hindu philosophy ka main source hain.',
        'Urdu': 'یہ ہندو فلسفے اور علم (شروتی) کا سب سے بڑا اور مستند ذریعہ ہیں۔',
        'Sindhi': 'اهي هندو فلسفي ۽ علم (شروتي) جو سڀ کان وڏو ۽ مستند ذريعو آهن.'
      },
      sources: ['Rig Veda', 'Yajur Veda', 'Sama Veda', 'Atharva Veda'],
    )
  ];

  // Bhagavad Gita 18 Chapters Content mapped to translated structures
  static final List<Map<String, dynamic>> gitaChapters = [
    {
      'number': 1,
      'sanskritName': 'Arjuna Vishada Yoga',
      'englishTitle': 'The Yoga of Arjuna\'s Grief',
      'imageUrl': 'GITA_CHAPTER_1',
      'imageCaption': 'Arjuna puts down his bow Gandiva in deep grief on the battlefield of Kurukshetra.',
      'titleTranslations': {
        'English': 'Arjuna Vishada Yoga',
        'Roman English': 'Arjuna ka Dukh',
        'Urdu': 'ارجن کا دکھ',
        'Sindhi': 'ارجن جو ڏک'
      },
      'englishExplanation': 'Arjuna is overwhelmed by sorrow and confusion on the battlefield. He refuses to fight his own family and surrenders to Krishna for guidance.',
      'romanEnglishExplanation': 'Battlefield par apno ko samne dekh kar Arjuna dukh mein chala jata hai aur Krishna se rasta dikhane ki guzarish karta hai.',
      'urduExplanation': 'ارجن جنگ کے میدان میں اپنے ہی لوگوں کو سامنے دیکھ کر دکھ اور الجھن کا شکار ہو جاتا ہے۔ وہ ہتھیار ڈال کر بھگوان کرشنا سے رہنمائی مانگتا ہے۔',
      'sindhiExplanation': 'ارجن جنگ جي ميدان ۾ پنهنجن ئي ماڻهن کي سامهون ڏسي ڏک ۽ منجهڻ جو شڪار ٿي پوي ٿو. هو هٿيار رکي ڀڳوان ڪرشنا کان رهنمائي گهري ٿو.',
      'mainThemes': ['Moral Dilemma', 'Sorrow', 'Surrender'],
      'context': 'Standing at Kurukshetra, Arjuna puts down his bow Gandiva.',
      'teachings': 'Grief and confusion can be starting points for deep spiritual inquiry.',
      'example': 'Feeling completely stressed before a big life choice and asking a wise mentor for help.',
      'source': 'Bhagavad Gita Chapter 1',
    }
  ];

  static final List<Map<String, String>> ramayanaTimeline = [
    {
      'title': 'Rama\'s Birth',
      'description': 'Born in Ayodhya, Rama represents the ideal righteous human (Maryada Purushottama).'
    },
    {
      'title': 'Sita\'s Abduction',
      'description': 'The demon king Ravana abducts Sita, leading to Rama\'s search.'
    },
    {
      'title': 'Lanka War & Return',
      'description': 'Rama defeats Ravana, saves Sita, and returns to Ayodhya, celebrated as Diwali.'
    }
  ];

  static final List<Map<String, String>> mahabharataTimeline = [
    {
      'title': 'Kuru Family',
      'description': 'Split between Pandavas (righteous) and Kauravas (covetous).'
    },
    {
      'title': 'Kurukshetra War',
      'description': 'The great war of Dharma fought on the plains of Kurukshetra.'
    }
  ];

  static final List<Map<String, dynamic>> deities = [
    {
      'id': 'deity_vishnu',
      'name': 'Lord Vishnu',
      'category': 'Vaishnavism',
      'whoIs': 'The Preserver and Sustainer of the universe.',
      'symbols': 'Conch, Discus, Mace, Lotus.',
      'stories': 'Incarnates to restore Dharma whenever negativity peaks.',
      'festivals': 'Janmashtami, Ram Navami.',
      'associatedTraditions': 'Vaishnavism.',
      'keyPoints': 'Stands for mercy and protection.'
    }
  ];

  static final List<Map<String, dynamic>> avatars = [
    {'number': 1, 'name': 'Matsya', 'form': 'Giant Fish', 'story': 'Saved the seeds of life from a great flood.'},
    {'number': 2, 'name': 'Rama', 'form': 'Ideal Prince', 'story': 'Defeated Ravana and established Ramrajya.'},
    {'number': 3, 'name': 'Krishna', 'form': 'Divine Teacher', 'story': 'Revealed the Gita to Arjuna.'}
  ];

  static final List<Map<String, dynamic>> philosophies = [
    {
      'name': 'Yoga',
      'founder': 'Sage Patanjali',
      'ideas': 'Practical path of mind control and meditation to achieve spiritual union.'
    }
  ];

  static final List<Map<String, String>> vedantaComparison = [
    {
      'school': 'Advaita (Non-dualism)',
      'thinker': 'Adi Shankaracharya',
      'viewOfBrahman': 'One without a second. Soul and Brahman are completely identical.',
      'relationship': 'The feeling of separation is an illusion (Maya).',
      'path': 'Knowledge (Jnana).'
    }
  ];

  static final List<DictionaryEntry> dictionary = [
    DictionaryEntry(
      term: 'Dharma',
      definitionTranslations: {
        'English': 'Righteous duty and ethical living.',
        'Roman English': 'Sahi duty aur sacchai ka rasta.',
        'Urdu': 'سچائی، اخلاقی فرض اور نیک بخت زندگی۔',
        'Sindhi': 'سچائي، اخلاقي فرض ۽ نيڪ بخت زندگي.'
      },
      detailedExplanationTranslations: {
        'English': 'Dharma sustains society and keeps human life in cosmic balance.',
        'Roman English': 'Dharma insaan aur pure brahmand ko balance mein rakhta hai.',
        'Urdu': 'دھرم معاشرے کو قائم رکھتا ہے اور انسانی زندگی کو کائناتی توازن میں رکھتا ہے۔',
        'Sindhi': 'دھرم سماج کي قائم رکي ٿو ۽ انساني زندگيءَ کي توازن ۾ رکي ٿو.'
      },
      relatedConcepts: 'Karma, Svadharma',
      relatedScripture: 'Bhagavad Gita',
      relatedLessonId: 'intro_sanatana_dharma',
    )
  ];
}
