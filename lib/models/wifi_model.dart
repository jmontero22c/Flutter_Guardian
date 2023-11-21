class Wifi {
  static final Wifi _instance = Wifi._internal();
  factory Wifi() => _instance;
  Wifi._internal();

  String _nameSSID = '';
  bool _status = false;
  String _ip = '';
  
  //Getters
  String get nameSSID => _nameSSID;
  String get ip => _ip;
  bool get status => _status;

  //Setters
  void setNameSSID(String value){
    _nameSSID = value;
  }
  void setIP(String value){
    _ip = value;
  }
  void setStatus(bool value){
    _status = value;
  }
}
