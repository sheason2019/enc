import 'package:ENC/prototypes/core.pb.dart';

extension PortableSecretBoxExtension on PortableSecretBox {
  AccountIndex findAgent(AccountSecret secret) {
    if (secret.signPubKey == sender.signPubKey) {
      return receiver;
    } else {
      return sender;
    }
  }
}
