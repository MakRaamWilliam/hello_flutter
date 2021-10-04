class SocialMessageData
{
  late  String senderId;
  late  String receiverId;
  late String text;
  late String dateTime;

  SocialMessageData({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.dateTime,
  });

  Map<String,dynamic> getMessageData(){
    return {
      "senderId": senderId,
      "text": text,
      "receiverId": receiverId,
      "dateTime": dateTime,
    };
  }
  // named constructor
  SocialMessageData.fromJson(Map<String, dynamic> json)
  {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    text = json['text'];
    dateTime = json['dateTime'];
  }
}

