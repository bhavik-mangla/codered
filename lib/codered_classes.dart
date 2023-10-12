class User {
  int? id;
  String name;
  String? regno;

  User({this.id, required this.name, required this.regno});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'regno': regno,
    };
  }
}

class Attendance {
  int? id;
  String subject;
  int attendanceCount;

  Attendance({
    this.id,
    required this.subject,
    required this.attendanceCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subject': subject,
      'attendanceCount': attendanceCount,
    };
  }
}

class Update {
  final int notificationId;
  final String title;
  final String message;
  final String timestamp;

  Update({
    required this.notificationId,
    required this.title,
    required this.message,
    required this.timestamp,
  });

  factory Update.fromJson(Map<String, dynamic> json) {
    return Update(
      notificationId: json['notification_id'],
      title: json['title'],
      message: json['message'],
      timestamp: json['timestamp'],
    );
  }
}

class Meme {
  final int memeId;
  final String title;
  final String imageLink;

  Meme({
    required this.memeId,
    required this.title,
    required this.imageLink,
  });

  factory Meme.fromJson(Map<String, dynamic> json) {
    return Meme(
      memeId: json['meme_id'],
      title: json['title'],
      imageLink: json['image_link'],
    );
  }
}
