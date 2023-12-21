import { Injectable } from '@nestjs/common';
import { Group } from '@prisma/client';
import axios from 'axios';
import { CryptoService } from 'src/crypto/crypto.service';
import { sheason_chat } from 'src/prototypes';

@Injectable()
export class GroupMessageService {
  constructor(private readonly cryptoService: CryptoService) {}

  encodeMessage(
    group: Group,
    message: sheason_chat.IPortableMessage,
  ): sheason_chat.SignWrapper {
    const agentSecret = sheason_chat.AccountSecret.decode(group.agentSecret);
    const conversation = sheason_chat.PortableConversation.decode(
      group.portableConversation,
    );
    const secrets = conversation.declaredSecrets;
    const declaredKey = secrets.length - 1;
    const key = secrets[declaredKey];
    const secretBox = this.cryptoService.secretEncrypt(
      Buffer.from(key),
      Buffer.from(sheason_chat.PortableMessage.encode(message).finish()),
    );
    secretBox.sender = {
      signPubKey: agentSecret.signPubKey,
      ecdhPubKey: agentSecret.ecdhPubKey,
    };
    secretBox.receiver = secretBox.sender;
    secretBox.declaredKey = declaredKey;
    const buffer = Buffer.from(
      sheason_chat.PortableSecretBox.encode(secretBox).finish(),
    );
    const wrapper = this.cryptoService.createSignature(agentSecret, buffer);
    wrapper.encrypt = true;
    wrapper.contentType = sheason_chat.ContentType.CONTENT_MESSAGE;
    return wrapper;
  }

  async distrobuteMessage(group: Group, wrappers: sheason_chat.SignWrapper[]) {
    const conversation = sheason_chat.PortableConversation.decode(
      group.portableConversation,
    );
    const members = conversation.members;
    const urlSet = new Set<string>();
    for (const member of members) {
      for (const url of Object.keys(member.serviceMap)) {
        urlSet.add(url);
      }
    }

    const formData = new FormData();
    formData.append(
      'data',
      JSON.stringify(
        wrappers
          .map((e) => sheason_chat.SignWrapper.encode(e).finish())
          .map((e) => Buffer.from(e).toString('base64')),
      ),
    );
    formData.append(
      'receivers',
      JSON.stringify(members.map((e) => e.index.signPubKey)),
    );

    for (const url of urlSet) {
      axios
        .postForm(`${url}/message`, formData)
        .catch((e) => console.log('[WARN] distrobute message failed', e));
    }
  }

  // 通知相关用户群组信息已更新
  async emitGroupUpdate(
    group: Group,
    extraMembers?: sheason_chat.IAccountSnapshot[],
  ) {
    const conversation = sheason_chat.PortableConversation.decode(
      group.portableConversation,
    );
    const agentSecret = sheason_chat.AccountSecret.decode(group.agentSecret);
    const members = [...conversation.members, ...(extraMembers ?? [])];

    for (const member of members) {
      const secretBox = this.cryptoService.encrypt(
        agentSecret,
        member.index,
        group.portableConversation,
      );
      const wrapper = this.cryptoService.createSignature(
        agentSecret,
        Buffer.from(sheason_chat.PortableSecretBox.encode(secretBox).finish()),
      );
      wrapper.contentType = sheason_chat.ContentType.CONTENT_CONVERSATION;
      wrapper.encrypt = true;

      const formData = new FormData();
      formData.append(
        'data',
        JSON.stringify([
          Buffer.from(
            sheason_chat.SignWrapper.encode(wrapper).finish(),
          ).toString('base64'),
        ]),
      );
      formData.append('receivers', JSON.stringify([member.index.signPubKey]));

      for (const url of Object.keys(member.serviceMap)) {
        axios.postForm(`${url}/message`, formData);
      }
    }
  }
}
