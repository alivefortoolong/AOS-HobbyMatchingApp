class Likemodel {
  int idTransmitter;
  int idReceiver;

  Likemodel({required this.idTransmitter, required this.idReceiver});

  Map<String, dynamic> toJson() {
    return {'idT': idTransmitter, 'idR': idReceiver};
  }
}
