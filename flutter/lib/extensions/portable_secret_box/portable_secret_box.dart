import 'package:sheason_chat/prototypes/core.pb.dart';

extension PortableSecretBoxExtension on PortableSecretBox {
  AccountIndex findAgent(AccountSecret secret) {
    if (secret.signPubKey == sender.signPubKey) {
      return receiver;
    } else {
      return sender;
    }
  }
}
