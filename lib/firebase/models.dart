import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mark_soc/constant/constants.dart';
CollectionReference usersCollection =
    FirebaseFirestore.instance.collection(collectionUsers);
    
class User {
  final String id;
  String? lastName;
  String? firstName;
  String? email;
  String? phoneNumber;
  final UserRole? role;
  final String? level;
  String? imageProfilePath;
  int? campaignCounter;
  int? gradeValue;

  User({required this.id, 
  required this.lastName, required this.firstName, 
  this.phoneNumber, required this.email, this.role,
  this.level, this.imageProfilePath, this.campaignCounter, this.gradeValue});

  User copyWith({
    String? lastName,
    String? firstName,
    String? email,
    String? phoneNumber,
    UserRole? role,
    String? level,
    int? score,
    String? imageProfilePath,
    int? campaignCounter,
    int? gradeValue
  }) {
    return User(
      id: id,
      lastName: lastName ?? this.lastName,
      firstName: firstName ?? this.firstName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      level: level ?? this.level,
      imageProfilePath: imageProfilePath ?? this.imageProfilePath,
      campaignCounter: campaignCounter ?? this.campaignCounter,
      gradeValue: gradeValue ?? this.gradeValue,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      lastName: json['lastName'],
      firstName: json['firstName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      role: UserRole.valueOf(json['role']),
      level: json['level'],
      imageProfilePath: json['imageProfilePath'],
      campaignCounter: json['campaignCounter'],
      gradeValue: json['gradeValue'],
    );
  }

  static User fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return User(
      id: doc.data()?['id']?? '',
      lastName: doc.data()?['lastName']?? '',
      firstName: doc.data()?['firstName']?? '',
      email: doc.data()?['email']?? '',
      phoneNumber: doc.data()?['phoneNumber']?? '',
      role: UserRole.valueOf(doc.data()?['role']),
      level: doc.data()?['level']?? '',
      imageProfilePath: doc.data()?['imageProfilePath']?? '',
      campaignCounter: doc.data()?['campaignCounter']?? 0,
      gradeValue: doc.data()?['gradeValue']?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lastName': lastName,
      'firstName': firstName,
      'phoneNumber': phoneNumber,
      'email': email,
      'role': (role ?? UserRole.getDefault()).toString(),
      'level': level,
      'imageProfilePath': imageProfilePath,
      'campaignCounter': campaignCounter,
      'gradeValue': gradeValue,
    };
  }
  

  void updateUserImageProfilePath(String userId, String imagePath) async {
    imageProfilePath = imagePath;
    await usersCollection.doc(userId).update({
      'imageProfilePath': imagePath,
    });
  }
  void updateUserPhoneNumber(String userId, String thePhoneNumber) async {
    phoneNumber = thePhoneNumber;
    await usersCollection.doc(userId).update({
      'phoneNumber': thePhoneNumber,
    });
  }
  void updateUserFirstName(String userId, String theFirstName) async {
    firstName = theFirstName;
    await usersCollection.doc(userId).update({
      'firstName': theFirstName,
    });
  }
  void updateUserLastName(String userId, String theLastName) async {
    lastName = theLastName;
    await usersCollection.doc(userId).update({
      'lastName': theLastName,
    });
  }
  void updateUserEmail(String userId, String theEmail) async {
    email = theEmail;
    await usersCollection.doc(userId).update({
      'email': theEmail,
    });
  }
  void updateUsergradeValue(String userId, int coin) async {
    int theGradeValue = gradeValue! + coin;
    gradeValue = theGradeValue;
    await usersCollection.doc(userId).update({
      'gradeValue': theGradeValue,
    });
  }
}

class Campaign {
  String? id;
  String title;
  String description;
  Category? category;
  DateTime? time;
  String authorId;
  String? vote;
  String? imageUrl;
  bool? isValidate;
  List<String>? likedList;

  Campaign({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    this.time,
    required this.authorId,
    this.vote,
    required this.imageUrl,
    this.isValidate,
    this.likedList,
  });

  factory Campaign.fromJson(Map<String, dynamic> json, String id) {
    return Campaign(
      id: id,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: Category.valueOf(json['category']),
      time: (json['time'] as Timestamp).toDate(),
      authorId: json['authorId'] ?? '',
      vote: json['vote'] ?? "0/0",
      imageUrl: json['imageUrl'] ??'',
      isValidate: json['isValidate'],
      likedList: json['likedList']??[],
    );
  }

    Campaign.fromMap(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.data()?["id"]??'',
        title = doc.data()?['title'] ?? '',
        description = doc.data()?['description'] ?? '',
        category = Category.valueOf(doc.data()?['category']),
        time = (doc.data()?['time'] as Timestamp).toDate(),
        authorId = doc.data()?['authorId'] ?? '',
        vote = doc.data()?['vote'] ?? "0/0",
        imageUrl = doc.data()?['imageUrl'] ??'',
        isValidate = doc.data()?['isValidate'],
        likedList = List<String>.from(doc.data()?['likedList'] ?? []);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': (category ?? Category.getDefault()).toString(),
      'time': Timestamp.fromDate(DateTime.now()),
      'authorId': authorId,
      'vote': vote ?? "0/0",
      'imageUrl': imageUrl,
      'isValidate' : isValidate,
      'likedList': likedList
    };
  }
}


class Comment {
  String? id;
  String authorId;
  String text;
  String? vote;
  DateTime? time;
  List<String>? likedList;

  Comment({
    this.id,
    required this.authorId,
    required this.text,
    this.vote,
    this.time,
    this.likedList,
  });

  factory Comment.fromJson(Map<String, dynamic> json, String id) {
    return Comment(
      id: id,
      authorId: json['authorId'] ?? '',
      text: json['text'] ?? '',
      vote: json['vote'] ?? "0/0",
      time: (json['time'] as Timestamp).toDate(),
      likedList: json['likedList']??[],
    );
  }

    Comment.fromMap(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.data()?["id"]??'',
        authorId = doc.data()?['authorId'] ?? '',
        text = doc.data()?['text'] ?? '',
        vote = doc.data()?['vote'] ?? "0/0",
        time = (doc.data()?['time'] as Timestamp).toDate(),
        likedList = List<String>.from(doc.data()?['likedList'] ?? []);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'authorId': authorId,
      'text': text,
      'time': Timestamp.fromDate(DateTime.now()),
      'vote': vote ?? "0/0",
      'likedList': likedList
    };
  }
}


// Roles
enum UserRole { 
  admin, moderator, user;

  static UserRole getDefault(){
    return user;
  }

  static UserRole valueOf(String? name){
    if(name != null && name.isNotEmpty){
      switch(name){
        case 'UserRole.moderator':
          return moderator;
        case 'UserRole.admin':
          return admin;
        case 'UserRole.user':
          return user;
      }
    }
    return getDefault();
  }
}


enum Category { 
  health,
  education,
  environment,
  law,
  community,
  social,
  roadSafety,
  psychology,
  other,
  none;

  static Category getDefault(){
    return none;
  }

  static Category valueOf(String? name){
    if(name != null && name.isNotEmpty){
      switch(name){
        case 'Category.health':
          return health;
        case 'Category.education':
          return education;
        case 'Category.environment':
          return environment;
        case 'Category.law':
          return law;
        case 'Category.community':
          return community;
        case 'Category.social':
          return social;
        case 'Category.roadSafety':
          return roadSafety;
        case 'Category.psychology':
          return psychology;
        case 'Category.other':
          return other;
        case 'Category.none':
          return none;
      }
    }
    return getDefault();
  }
}

extension CategoryExtension on Category {
  String get name {
    switch (this) {
      case Category.health:
        return 'Santé';
      case Category.education:
        return 'Education';
      case Category.environment:
        return 'Environnement';
      case Category.law:
        return 'Droit/Justice';
      case Category.community:
        return 'Communauté';
      case Category.social:
        return 'Société';
      case Category.roadSafety:
        return 'Sécurité Routière';
      case Category.psychology:
        return 'Psychologie';
      case Category.other:
        return 'Autre';
      case Category.none:
        return ' ';
    }
  }

  static List<Category> get allValues => Category.values;
  
}