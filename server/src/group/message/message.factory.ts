import { Injectable } from '@nestjs/common';
import { randomUUID } from 'crypto';
import { sheason_chat } from 'src/prototypes';

@Injectable()
export class GroupMessageFactory {
  invite(
    conversation: sheason_chat.IPortableConversation,
    operator: sheason_chat.IAccountSnapshot,
    members: sheason_chat.IAccountSnapshot[],
  ): sheason_chat.IPortableMessage {
    return sheason_chat.PortableMessage.create({
      conversation: conversation,
      messageType: sheason_chat.MessageType.MESSAGE_TYPE_NOTIFY,
      content: JSON.stringify({
        type: 'invite',
        payload: {
          operator: operator.index.signPubKey,
          members: members.map((e) => e.index.signPubKey),
        },
      }),
      uuid: randomUUID(),
      createdAt: new Date().getTime(),
    });
  }

  create(
    conversation: sheason_chat.IPortableConversation,
    operator: sheason_chat.IAccountSnapshot,
  ): sheason_chat.IPortableMessage {
    return sheason_chat.PortableMessage.create({
      conversation: conversation,
      messageType: sheason_chat.MessageType.MESSAGE_TYPE_NOTIFY,
      content: JSON.stringify({
        type: 'create',
        payload: operator.index.signPubKey,
      }),
      uuid: randomUUID(),
      createdAt: new Date().getTime(),
    });
  }

  remove(
    conversation: sheason_chat.IPortableConversation,
    operator: sheason_chat.IAccountSnapshot,
    members: sheason_chat.IAccountSnapshot[],
  ): sheason_chat.IPortableMessage {
    return sheason_chat.PortableMessage.create({
      conversation,
      messageType: sheason_chat.MessageType.MESSAGE_TYPE_NOTIFY,
      content: JSON.stringify({
        type: 'remove',
        payload: {
          operator,
          members: members.map((e) => e.index.signPubKey),
        },
      }),
      uuid: randomUUID(),
      createdAt: new Date().getTime(),
    });
  }
}
