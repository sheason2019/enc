import * as $protobuf from "protobufjs";
import Long = require("long");
/** Namespace sheason_chat. */
export namespace sheason_chat {

    /** Properties of an AccountSecret. */
    interface IAccountSecret {

        /** AccountSecret ecdhPubKey */
        ecdhPubKey?: (string|null);

        /** AccountSecret ecdhPrivKey */
        ecdhPrivKey?: (string|null);

        /** AccountSecret signPubKey */
        signPubKey?: (string|null);

        /** AccountSecret signPrivKey */
        signPrivKey?: (string|null);
    }

    /** Represents an AccountSecret. */
    class AccountSecret implements IAccountSecret {

        /**
         * Constructs a new AccountSecret.
         * @param [properties] Properties to set
         */
        constructor(properties?: sheason_chat.IAccountSecret);

        /** AccountSecret ecdhPubKey. */
        public ecdhPubKey: string;

        /** AccountSecret ecdhPrivKey. */
        public ecdhPrivKey: string;

        /** AccountSecret signPubKey. */
        public signPubKey: string;

        /** AccountSecret signPrivKey. */
        public signPrivKey: string;

        /**
         * Creates a new AccountSecret instance using the specified properties.
         * @param [properties] Properties to set
         * @returns AccountSecret instance
         */
        public static create(properties?: sheason_chat.IAccountSecret): sheason_chat.AccountSecret;

        /**
         * Encodes the specified AccountSecret message. Does not implicitly {@link sheason_chat.AccountSecret.verify|verify} messages.
         * @param message AccountSecret message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encode(message: sheason_chat.IAccountSecret, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Encodes the specified AccountSecret message, length delimited. Does not implicitly {@link sheason_chat.AccountSecret.verify|verify} messages.
         * @param message AccountSecret message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encodeDelimited(message: sheason_chat.IAccountSecret, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Decodes an AccountSecret message from the specified reader or buffer.
         * @param reader Reader or buffer to decode from
         * @param [length] Message length if known beforehand
         * @returns AccountSecret
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): sheason_chat.AccountSecret;

        /**
         * Decodes an AccountSecret message from the specified reader or buffer, length delimited.
         * @param reader Reader or buffer to decode from
         * @returns AccountSecret
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): sheason_chat.AccountSecret;

        /**
         * Verifies an AccountSecret message.
         * @param message Plain object to verify
         * @returns `null` if valid, otherwise the reason why it is not
         */
        public static verify(message: { [k: string]: any }): (string|null);

        /**
         * Creates an AccountSecret message from a plain object. Also converts values to their respective internal types.
         * @param object Plain object
         * @returns AccountSecret
         */
        public static fromObject(object: { [k: string]: any }): sheason_chat.AccountSecret;

        /**
         * Creates a plain object from an AccountSecret message. Also converts values to other types if specified.
         * @param message AccountSecret
         * @param [options] Conversion options
         * @returns Plain object
         */
        public static toObject(message: sheason_chat.AccountSecret, options?: $protobuf.IConversionOptions): { [k: string]: any };

        /**
         * Converts this AccountSecret to JSON.
         * @returns JSON object
         */
        public toJSON(): { [k: string]: any };

        /**
         * Gets the default type url for AccountSecret
         * @param [typeUrlPrefix] your custom typeUrlPrefix(default "type.googleapis.com")
         * @returns The default type url
         */
        public static getTypeUrl(typeUrlPrefix?: string): string;
    }

    /** Properties of an AccountIndex. */
    interface IAccountIndex {

        /** AccountIndex ecdhPubKey */
        ecdhPubKey?: (string|null);

        /** AccountIndex signPubKey */
        signPubKey?: (string|null);
    }

    /** Represents an AccountIndex. */
    class AccountIndex implements IAccountIndex {

        /**
         * Constructs a new AccountIndex.
         * @param [properties] Properties to set
         */
        constructor(properties?: sheason_chat.IAccountIndex);

        /** AccountIndex ecdhPubKey. */
        public ecdhPubKey: string;

        /** AccountIndex signPubKey. */
        public signPubKey: string;

        /**
         * Creates a new AccountIndex instance using the specified properties.
         * @param [properties] Properties to set
         * @returns AccountIndex instance
         */
        public static create(properties?: sheason_chat.IAccountIndex): sheason_chat.AccountIndex;

        /**
         * Encodes the specified AccountIndex message. Does not implicitly {@link sheason_chat.AccountIndex.verify|verify} messages.
         * @param message AccountIndex message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encode(message: sheason_chat.IAccountIndex, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Encodes the specified AccountIndex message, length delimited. Does not implicitly {@link sheason_chat.AccountIndex.verify|verify} messages.
         * @param message AccountIndex message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encodeDelimited(message: sheason_chat.IAccountIndex, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Decodes an AccountIndex message from the specified reader or buffer.
         * @param reader Reader or buffer to decode from
         * @param [length] Message length if known beforehand
         * @returns AccountIndex
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): sheason_chat.AccountIndex;

        /**
         * Decodes an AccountIndex message from the specified reader or buffer, length delimited.
         * @param reader Reader or buffer to decode from
         * @returns AccountIndex
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): sheason_chat.AccountIndex;

        /**
         * Verifies an AccountIndex message.
         * @param message Plain object to verify
         * @returns `null` if valid, otherwise the reason why it is not
         */
        public static verify(message: { [k: string]: any }): (string|null);

        /**
         * Creates an AccountIndex message from a plain object. Also converts values to their respective internal types.
         * @param object Plain object
         * @returns AccountIndex
         */
        public static fromObject(object: { [k: string]: any }): sheason_chat.AccountIndex;

        /**
         * Creates a plain object from an AccountIndex message. Also converts values to other types if specified.
         * @param message AccountIndex
         * @param [options] Conversion options
         * @returns Plain object
         */
        public static toObject(message: sheason_chat.AccountIndex, options?: $protobuf.IConversionOptions): { [k: string]: any };

        /**
         * Converts this AccountIndex to JSON.
         * @returns JSON object
         */
        public toJSON(): { [k: string]: any };

        /**
         * Gets the default type url for AccountIndex
         * @param [typeUrlPrefix] your custom typeUrlPrefix(default "type.googleapis.com")
         * @returns The default type url
         */
        public static getTypeUrl(typeUrlPrefix?: string): string;
    }

    /** Properties of an AccountSnapshot. */
    interface IAccountSnapshot {

        /** AccountSnapshot index */
        index?: (sheason_chat.IAccountIndex|null);

        /** AccountSnapshot username */
        username?: (string|null);

        /** AccountSnapshot avatarUrl */
        avatarUrl?: (string|null);

        /** AccountSnapshot services */
        services?: (string[]|null);

        /** AccountSnapshot createdAt */
        createdAt?: (number|Long|null);
    }

    /** Represents an AccountSnapshot. */
    class AccountSnapshot implements IAccountSnapshot {

        /**
         * Constructs a new AccountSnapshot.
         * @param [properties] Properties to set
         */
        constructor(properties?: sheason_chat.IAccountSnapshot);

        /** AccountSnapshot index. */
        public index?: (sheason_chat.IAccountIndex|null);

        /** AccountSnapshot username. */
        public username: string;

        /** AccountSnapshot avatarUrl. */
        public avatarUrl: string;

        /** AccountSnapshot services. */
        public services: string[];

        /** AccountSnapshot createdAt. */
        public createdAt: (number|Long);

        /**
         * Creates a new AccountSnapshot instance using the specified properties.
         * @param [properties] Properties to set
         * @returns AccountSnapshot instance
         */
        public static create(properties?: sheason_chat.IAccountSnapshot): sheason_chat.AccountSnapshot;

        /**
         * Encodes the specified AccountSnapshot message. Does not implicitly {@link sheason_chat.AccountSnapshot.verify|verify} messages.
         * @param message AccountSnapshot message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encode(message: sheason_chat.IAccountSnapshot, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Encodes the specified AccountSnapshot message, length delimited. Does not implicitly {@link sheason_chat.AccountSnapshot.verify|verify} messages.
         * @param message AccountSnapshot message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encodeDelimited(message: sheason_chat.IAccountSnapshot, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Decodes an AccountSnapshot message from the specified reader or buffer.
         * @param reader Reader or buffer to decode from
         * @param [length] Message length if known beforehand
         * @returns AccountSnapshot
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): sheason_chat.AccountSnapshot;

        /**
         * Decodes an AccountSnapshot message from the specified reader or buffer, length delimited.
         * @param reader Reader or buffer to decode from
         * @returns AccountSnapshot
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): sheason_chat.AccountSnapshot;

        /**
         * Verifies an AccountSnapshot message.
         * @param message Plain object to verify
         * @returns `null` if valid, otherwise the reason why it is not
         */
        public static verify(message: { [k: string]: any }): (string|null);

        /**
         * Creates an AccountSnapshot message from a plain object. Also converts values to their respective internal types.
         * @param object Plain object
         * @returns AccountSnapshot
         */
        public static fromObject(object: { [k: string]: any }): sheason_chat.AccountSnapshot;

        /**
         * Creates a plain object from an AccountSnapshot message. Also converts values to other types if specified.
         * @param message AccountSnapshot
         * @param [options] Conversion options
         * @returns Plain object
         */
        public static toObject(message: sheason_chat.AccountSnapshot, options?: $protobuf.IConversionOptions): { [k: string]: any };

        /**
         * Converts this AccountSnapshot to JSON.
         * @returns JSON object
         */
        public toJSON(): { [k: string]: any };

        /**
         * Gets the default type url for AccountSnapshot
         * @param [typeUrlPrefix] your custom typeUrlPrefix(default "type.googleapis.com")
         * @returns The default type url
         */
        public static getTypeUrl(typeUrlPrefix?: string): string;
    }

    /** Properties of a PortableSecretBox. */
    interface IPortableSecretBox {

        /** PortableSecretBox cipherData */
        cipherData?: (Uint8Array|null);

        /** PortableSecretBox nonce */
        nonce?: (Uint8Array|null);

        /** PortableSecretBox mac */
        mac?: (Uint8Array|null);
    }

    /** Represents a PortableSecretBox. */
    class PortableSecretBox implements IPortableSecretBox {

        /**
         * Constructs a new PortableSecretBox.
         * @param [properties] Properties to set
         */
        constructor(properties?: sheason_chat.IPortableSecretBox);

        /** PortableSecretBox cipherData. */
        public cipherData: Uint8Array;

        /** PortableSecretBox nonce. */
        public nonce: Uint8Array;

        /** PortableSecretBox mac. */
        public mac: Uint8Array;

        /**
         * Creates a new PortableSecretBox instance using the specified properties.
         * @param [properties] Properties to set
         * @returns PortableSecretBox instance
         */
        public static create(properties?: sheason_chat.IPortableSecretBox): sheason_chat.PortableSecretBox;

        /**
         * Encodes the specified PortableSecretBox message. Does not implicitly {@link sheason_chat.PortableSecretBox.verify|verify} messages.
         * @param message PortableSecretBox message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encode(message: sheason_chat.IPortableSecretBox, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Encodes the specified PortableSecretBox message, length delimited. Does not implicitly {@link sheason_chat.PortableSecretBox.verify|verify} messages.
         * @param message PortableSecretBox message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encodeDelimited(message: sheason_chat.IPortableSecretBox, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Decodes a PortableSecretBox message from the specified reader or buffer.
         * @param reader Reader or buffer to decode from
         * @param [length] Message length if known beforehand
         * @returns PortableSecretBox
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): sheason_chat.PortableSecretBox;

        /**
         * Decodes a PortableSecretBox message from the specified reader or buffer, length delimited.
         * @param reader Reader or buffer to decode from
         * @returns PortableSecretBox
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): sheason_chat.PortableSecretBox;

        /**
         * Verifies a PortableSecretBox message.
         * @param message Plain object to verify
         * @returns `null` if valid, otherwise the reason why it is not
         */
        public static verify(message: { [k: string]: any }): (string|null);

        /**
         * Creates a PortableSecretBox message from a plain object. Also converts values to their respective internal types.
         * @param object Plain object
         * @returns PortableSecretBox
         */
        public static fromObject(object: { [k: string]: any }): sheason_chat.PortableSecretBox;

        /**
         * Creates a plain object from a PortableSecretBox message. Also converts values to other types if specified.
         * @param message PortableSecretBox
         * @param [options] Conversion options
         * @returns Plain object
         */
        public static toObject(message: sheason_chat.PortableSecretBox, options?: $protobuf.IConversionOptions): { [k: string]: any };

        /**
         * Converts this PortableSecretBox to JSON.
         * @returns JSON object
         */
        public toJSON(): { [k: string]: any };

        /**
         * Gets the default type url for PortableSecretBox
         * @param [typeUrlPrefix] your custom typeUrlPrefix(default "type.googleapis.com")
         * @returns The default type url
         */
        public static getTypeUrl(typeUrlPrefix?: string): string;
    }

    /** Properties of a PortableOperation. */
    interface IPortableOperation {

        /** PortableOperation clientId */
        clientId?: (string|null);

        /** PortableOperation clock */
        clock?: (number|null);

        /** PortableOperation payload */
        payload?: (string|null);

        /** PortableOperation secretBox */
        secretBox?: (sheason_chat.IPortableSecretBox|null);
    }

    /** Represents a PortableOperation. */
    class PortableOperation implements IPortableOperation {

        /**
         * Constructs a new PortableOperation.
         * @param [properties] Properties to set
         */
        constructor(properties?: sheason_chat.IPortableOperation);

        /** PortableOperation clientId. */
        public clientId: string;

        /** PortableOperation clock. */
        public clock: number;

        /** PortableOperation payload. */
        public payload: string;

        /** PortableOperation secretBox. */
        public secretBox?: (sheason_chat.IPortableSecretBox|null);

        /**
         * Creates a new PortableOperation instance using the specified properties.
         * @param [properties] Properties to set
         * @returns PortableOperation instance
         */
        public static create(properties?: sheason_chat.IPortableOperation): sheason_chat.PortableOperation;

        /**
         * Encodes the specified PortableOperation message. Does not implicitly {@link sheason_chat.PortableOperation.verify|verify} messages.
         * @param message PortableOperation message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encode(message: sheason_chat.IPortableOperation, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Encodes the specified PortableOperation message, length delimited. Does not implicitly {@link sheason_chat.PortableOperation.verify|verify} messages.
         * @param message PortableOperation message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encodeDelimited(message: sheason_chat.IPortableOperation, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Decodes a PortableOperation message from the specified reader or buffer.
         * @param reader Reader or buffer to decode from
         * @param [length] Message length if known beforehand
         * @returns PortableOperation
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): sheason_chat.PortableOperation;

        /**
         * Decodes a PortableOperation message from the specified reader or buffer, length delimited.
         * @param reader Reader or buffer to decode from
         * @returns PortableOperation
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): sheason_chat.PortableOperation;

        /**
         * Verifies a PortableOperation message.
         * @param message Plain object to verify
         * @returns `null` if valid, otherwise the reason why it is not
         */
        public static verify(message: { [k: string]: any }): (string|null);

        /**
         * Creates a PortableOperation message from a plain object. Also converts values to their respective internal types.
         * @param object Plain object
         * @returns PortableOperation
         */
        public static fromObject(object: { [k: string]: any }): sheason_chat.PortableOperation;

        /**
         * Creates a plain object from a PortableOperation message. Also converts values to other types if specified.
         * @param message PortableOperation
         * @param [options] Conversion options
         * @returns Plain object
         */
        public static toObject(message: sheason_chat.PortableOperation, options?: $protobuf.IConversionOptions): { [k: string]: any };

        /**
         * Converts this PortableOperation to JSON.
         * @returns JSON object
         */
        public toJSON(): { [k: string]: any };

        /**
         * Gets the default type url for PortableOperation
         * @param [typeUrlPrefix] your custom typeUrlPrefix(default "type.googleapis.com")
         * @returns The default type url
         */
        public static getTypeUrl(typeUrlPrefix?: string): string;
    }

    /** ConversationType enum. */
    enum ConversationType {
        CONVERSATION_UNKNOWN = 0,
        CONVERSATION_PRIVATE = 1,
        CONVERSATION_GROUP = 2
    }

    /** Properties of a PortableConversation. */
    interface IPortableConversation {

        /** PortableConversation type */
        type?: (sheason_chat.ConversationType|null);

        /** PortableConversation members */
        members?: (sheason_chat.IAccountIndex[]|null);

        /** PortableConversation owner */
        owner?: (sheason_chat.IAccountIndex|null);

        /** PortableConversation remoteUrl */
        remoteUrl?: (string|null);

        /** PortableConversation declaredSecrets */
        declaredSecrets?: ({ [k: string]: Uint8Array }|null);
    }

    /** Represents a PortableConversation. */
    class PortableConversation implements IPortableConversation {

        /**
         * Constructs a new PortableConversation.
         * @param [properties] Properties to set
         */
        constructor(properties?: sheason_chat.IPortableConversation);

        /** PortableConversation type. */
        public type: sheason_chat.ConversationType;

        /** PortableConversation members. */
        public members: sheason_chat.IAccountIndex[];

        /** PortableConversation owner. */
        public owner?: (sheason_chat.IAccountIndex|null);

        /** PortableConversation remoteUrl. */
        public remoteUrl: string;

        /** PortableConversation declaredSecrets. */
        public declaredSecrets: { [k: string]: Uint8Array };

        /**
         * Creates a new PortableConversation instance using the specified properties.
         * @param [properties] Properties to set
         * @returns PortableConversation instance
         */
        public static create(properties?: sheason_chat.IPortableConversation): sheason_chat.PortableConversation;

        /**
         * Encodes the specified PortableConversation message. Does not implicitly {@link sheason_chat.PortableConversation.verify|verify} messages.
         * @param message PortableConversation message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encode(message: sheason_chat.IPortableConversation, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Encodes the specified PortableConversation message, length delimited. Does not implicitly {@link sheason_chat.PortableConversation.verify|verify} messages.
         * @param message PortableConversation message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encodeDelimited(message: sheason_chat.IPortableConversation, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Decodes a PortableConversation message from the specified reader or buffer.
         * @param reader Reader or buffer to decode from
         * @param [length] Message length if known beforehand
         * @returns PortableConversation
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): sheason_chat.PortableConversation;

        /**
         * Decodes a PortableConversation message from the specified reader or buffer, length delimited.
         * @param reader Reader or buffer to decode from
         * @returns PortableConversation
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): sheason_chat.PortableConversation;

        /**
         * Verifies a PortableConversation message.
         * @param message Plain object to verify
         * @returns `null` if valid, otherwise the reason why it is not
         */
        public static verify(message: { [k: string]: any }): (string|null);

        /**
         * Creates a PortableConversation message from a plain object. Also converts values to their respective internal types.
         * @param object Plain object
         * @returns PortableConversation
         */
        public static fromObject(object: { [k: string]: any }): sheason_chat.PortableConversation;

        /**
         * Creates a plain object from a PortableConversation message. Also converts values to other types if specified.
         * @param message PortableConversation
         * @param [options] Conversion options
         * @returns Plain object
         */
        public static toObject(message: sheason_chat.PortableConversation, options?: $protobuf.IConversionOptions): { [k: string]: any };

        /**
         * Converts this PortableConversation to JSON.
         * @returns JSON object
         */
        public toJSON(): { [k: string]: any };

        /**
         * Gets the default type url for PortableConversation
         * @param [typeUrlPrefix] your custom typeUrlPrefix(default "type.googleapis.com")
         * @returns The default type url
         */
        public static getTypeUrl(typeUrlPrefix?: string): string;
    }

    /** MessageType enum. */
    enum MessageType {
        MESSAGE_TYPE_UNKNOWN = 0,
        MESSAGE_TYPE_TEXT = 1,
        MESSAGE_TYPE_AUDIO = 2,
        MESSAGE_TYPE_IMAGE = 3,
        MESSAGE_TYPE_VIDEO = 4,
        MESSAGE_TYPE_FILE = 5
    }

    /** Properties of a PortableMessage. */
    interface IPortableMessage {

        /** PortableMessage uuid */
        uuid?: (string|null);

        /** PortableMessage messageType */
        messageType?: (sheason_chat.MessageType|null);

        /** PortableMessage content */
        content?: (string|null);

        /** PortableMessage sender */
        sender?: (sheason_chat.IAccountIndex|null);

        /** PortableMessage conversation */
        conversation?: (sheason_chat.IPortableConversation|null);

        /** PortableMessage messageStates */
        messageStates?: (sheason_chat.IPortableMessageState[]|null);
    }

    /** Represents a PortableMessage. */
    class PortableMessage implements IPortableMessage {

        /**
         * Constructs a new PortableMessage.
         * @param [properties] Properties to set
         */
        constructor(properties?: sheason_chat.IPortableMessage);

        /** PortableMessage uuid. */
        public uuid: string;

        /** PortableMessage messageType. */
        public messageType: sheason_chat.MessageType;

        /** PortableMessage content. */
        public content: string;

        /** PortableMessage sender. */
        public sender?: (sheason_chat.IAccountIndex|null);

        /** PortableMessage conversation. */
        public conversation?: (sheason_chat.IPortableConversation|null);

        /** PortableMessage messageStates. */
        public messageStates: sheason_chat.IPortableMessageState[];

        /**
         * Creates a new PortableMessage instance using the specified properties.
         * @param [properties] Properties to set
         * @returns PortableMessage instance
         */
        public static create(properties?: sheason_chat.IPortableMessage): sheason_chat.PortableMessage;

        /**
         * Encodes the specified PortableMessage message. Does not implicitly {@link sheason_chat.PortableMessage.verify|verify} messages.
         * @param message PortableMessage message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encode(message: sheason_chat.IPortableMessage, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Encodes the specified PortableMessage message, length delimited. Does not implicitly {@link sheason_chat.PortableMessage.verify|verify} messages.
         * @param message PortableMessage message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encodeDelimited(message: sheason_chat.IPortableMessage, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Decodes a PortableMessage message from the specified reader or buffer.
         * @param reader Reader or buffer to decode from
         * @param [length] Message length if known beforehand
         * @returns PortableMessage
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): sheason_chat.PortableMessage;

        /**
         * Decodes a PortableMessage message from the specified reader or buffer, length delimited.
         * @param reader Reader or buffer to decode from
         * @returns PortableMessage
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): sheason_chat.PortableMessage;

        /**
         * Verifies a PortableMessage message.
         * @param message Plain object to verify
         * @returns `null` if valid, otherwise the reason why it is not
         */
        public static verify(message: { [k: string]: any }): (string|null);

        /**
         * Creates a PortableMessage message from a plain object. Also converts values to their respective internal types.
         * @param object Plain object
         * @returns PortableMessage
         */
        public static fromObject(object: { [k: string]: any }): sheason_chat.PortableMessage;

        /**
         * Creates a plain object from a PortableMessage message. Also converts values to other types if specified.
         * @param message PortableMessage
         * @param [options] Conversion options
         * @returns Plain object
         */
        public static toObject(message: sheason_chat.PortableMessage, options?: $protobuf.IConversionOptions): { [k: string]: any };

        /**
         * Converts this PortableMessage to JSON.
         * @returns JSON object
         */
        public toJSON(): { [k: string]: any };

        /**
         * Gets the default type url for PortableMessage
         * @param [typeUrlPrefix] your custom typeUrlPrefix(default "type.googleapis.com")
         * @returns The default type url
         */
        public static getTypeUrl(typeUrlPrefix?: string): string;
    }

    /** Properties of a PortableMessageState. */
    interface IPortableMessageState {

        /** PortableMessageState account */
        account?: (sheason_chat.IAccountIndex|null);

        /** PortableMessageState createdAt */
        createdAt?: (number|Long|null);

        /** PortableMessageState receiveAt */
        receiveAt?: (number|Long|null);

        /** PortableMessageState checkedAt */
        checkedAt?: (number|Long|null);
    }

    /** Represents a PortableMessageState. */
    class PortableMessageState implements IPortableMessageState {

        /**
         * Constructs a new PortableMessageState.
         * @param [properties] Properties to set
         */
        constructor(properties?: sheason_chat.IPortableMessageState);

        /** PortableMessageState account. */
        public account?: (sheason_chat.IAccountIndex|null);

        /** PortableMessageState createdAt. */
        public createdAt: (number|Long);

        /** PortableMessageState receiveAt. */
        public receiveAt: (number|Long);

        /** PortableMessageState checkedAt. */
        public checkedAt: (number|Long);

        /**
         * Creates a new PortableMessageState instance using the specified properties.
         * @param [properties] Properties to set
         * @returns PortableMessageState instance
         */
        public static create(properties?: sheason_chat.IPortableMessageState): sheason_chat.PortableMessageState;

        /**
         * Encodes the specified PortableMessageState message. Does not implicitly {@link sheason_chat.PortableMessageState.verify|verify} messages.
         * @param message PortableMessageState message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encode(message: sheason_chat.IPortableMessageState, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Encodes the specified PortableMessageState message, length delimited. Does not implicitly {@link sheason_chat.PortableMessageState.verify|verify} messages.
         * @param message PortableMessageState message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encodeDelimited(message: sheason_chat.IPortableMessageState, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Decodes a PortableMessageState message from the specified reader or buffer.
         * @param reader Reader or buffer to decode from
         * @param [length] Message length if known beforehand
         * @returns PortableMessageState
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): sheason_chat.PortableMessageState;

        /**
         * Decodes a PortableMessageState message from the specified reader or buffer, length delimited.
         * @param reader Reader or buffer to decode from
         * @returns PortableMessageState
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): sheason_chat.PortableMessageState;

        /**
         * Verifies a PortableMessageState message.
         * @param message Plain object to verify
         * @returns `null` if valid, otherwise the reason why it is not
         */
        public static verify(message: { [k: string]: any }): (string|null);

        /**
         * Creates a PortableMessageState message from a plain object. Also converts values to their respective internal types.
         * @param object Plain object
         * @returns PortableMessageState
         */
        public static fromObject(object: { [k: string]: any }): sheason_chat.PortableMessageState;

        /**
         * Creates a plain object from a PortableMessageState message. Also converts values to other types if specified.
         * @param message PortableMessageState
         * @param [options] Conversion options
         * @returns Plain object
         */
        public static toObject(message: sheason_chat.PortableMessageState, options?: $protobuf.IConversionOptions): { [k: string]: any };

        /**
         * Converts this PortableMessageState to JSON.
         * @returns JSON object
         */
        public toJSON(): { [k: string]: any };

        /**
         * Gets the default type url for PortableMessageState
         * @param [typeUrlPrefix] your custom typeUrlPrefix(default "type.googleapis.com")
         * @returns The default type url
         */
        public static getTypeUrl(typeUrlPrefix?: string): string;
    }

    /** SignedBundleContentType enum. */
    enum SignedBundleContentType {
        BUNDLE_TYPE_UNKNOWN = 0,
        BUNDLE_TYPE_MESSAGE = 1
    }

    /** EcryptType enum. */
    enum EcryptType {
        ENCRYPT_TYPE_NONE = 0,
        ENCRYPT_TYPE_SHARED_SECRET = 1,
        ENCRYPT_TYPE_DECLARED_SECRET = 2
    }

    /** Properties of a SignedBundle. */
    interface ISignedBundle {

        /** SignedBundle encryptType */
        encryptType?: (sheason_chat.EcryptType|null);

        /** SignedBundle secretKey */
        secretKey?: (number|null);

        /** SignedBundle sender */
        sender?: (sheason_chat.IAccountIndex|null);

        /** SignedBundle receiver */
        receiver?: (sheason_chat.IAccountIndex|null);

        /** SignedBundle plainData */
        plainData?: (Uint8Array|null);

        /** SignedBundle secretBox */
        secretBox?: (sheason_chat.IPortableSecretBox|null);

        /** SignedBundle contentType */
        contentType?: (sheason_chat.SignedBundleContentType|null);
    }

    /** Represents a SignedBundle. */
    class SignedBundle implements ISignedBundle {

        /**
         * Constructs a new SignedBundle.
         * @param [properties] Properties to set
         */
        constructor(properties?: sheason_chat.ISignedBundle);

        /** SignedBundle encryptType. */
        public encryptType: sheason_chat.EcryptType;

        /** SignedBundle secretKey. */
        public secretKey: number;

        /** SignedBundle sender. */
        public sender?: (sheason_chat.IAccountIndex|null);

        /** SignedBundle receiver. */
        public receiver?: (sheason_chat.IAccountIndex|null);

        /** SignedBundle plainData. */
        public plainData: Uint8Array;

        /** SignedBundle secretBox. */
        public secretBox?: (sheason_chat.IPortableSecretBox|null);

        /** SignedBundle contentType. */
        public contentType: sheason_chat.SignedBundleContentType;

        /**
         * Creates a new SignedBundle instance using the specified properties.
         * @param [properties] Properties to set
         * @returns SignedBundle instance
         */
        public static create(properties?: sheason_chat.ISignedBundle): sheason_chat.SignedBundle;

        /**
         * Encodes the specified SignedBundle message. Does not implicitly {@link sheason_chat.SignedBundle.verify|verify} messages.
         * @param message SignedBundle message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encode(message: sheason_chat.ISignedBundle, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Encodes the specified SignedBundle message, length delimited. Does not implicitly {@link sheason_chat.SignedBundle.verify|verify} messages.
         * @param message SignedBundle message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encodeDelimited(message: sheason_chat.ISignedBundle, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Decodes a SignedBundle message from the specified reader or buffer.
         * @param reader Reader or buffer to decode from
         * @param [length] Message length if known beforehand
         * @returns SignedBundle
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): sheason_chat.SignedBundle;

        /**
         * Decodes a SignedBundle message from the specified reader or buffer, length delimited.
         * @param reader Reader or buffer to decode from
         * @returns SignedBundle
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): sheason_chat.SignedBundle;

        /**
         * Verifies a SignedBundle message.
         * @param message Plain object to verify
         * @returns `null` if valid, otherwise the reason why it is not
         */
        public static verify(message: { [k: string]: any }): (string|null);

        /**
         * Creates a SignedBundle message from a plain object. Also converts values to their respective internal types.
         * @param object Plain object
         * @returns SignedBundle
         */
        public static fromObject(object: { [k: string]: any }): sheason_chat.SignedBundle;

        /**
         * Creates a plain object from a SignedBundle message. Also converts values to other types if specified.
         * @param message SignedBundle
         * @param [options] Conversion options
         * @returns Plain object
         */
        public static toObject(message: sheason_chat.SignedBundle, options?: $protobuf.IConversionOptions): { [k: string]: any };

        /**
         * Converts this SignedBundle to JSON.
         * @returns JSON object
         */
        public toJSON(): { [k: string]: any };

        /**
         * Gets the default type url for SignedBundle
         * @param [typeUrlPrefix] your custom typeUrlPrefix(default "type.googleapis.com")
         * @returns The default type url
         */
        public static getTypeUrl(typeUrlPrefix?: string): string;
    }
}
