// ignore_for_file: non_constant_identifier_names

class GuardianAtt {
  static final GuardianAtt _instance = GuardianAtt._internal();

  factory GuardianAtt() {
    return _instance;
  }

  GuardianAtt._internal();

  // Implementa tu lógica de estado aquí
  int _VERSION_GUARDIAN = 0;

  int get VERSION_GUARDIAN => _VERSION_GUARDIAN;

  void setVersionGuardian(String value){
    _VERSION_GUARDIAN = int.parse(value);
  }

}
