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

        /** AccountSnapshot serviceMap */
        serviceMap?: ({ [k: string]: sheason_chat.IPortableService }|null);

        /** AccountSnapshot version */
        version?: (number|null);
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

        /** AccountSnapshot serviceMap. */
        public serviceMap: { [k: string]: sheason_chat.IPortableService };

        /** AccountSnapshot version. */
        public version: number;

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

    /** Properties of a PortableService. */
    interface IPortableService {
    }

    /** Represents a PortableService. */
    class PortableService implements IPortableService {

        /**
         * Constructs a new PortableService.
         * @param [properties] Properties to set
         */
        constructor(properties?: sheason_chat.IPortableService);

        /**
         * Creates a new PortableService instance using the specified properties.
         * @param [properties] Properties to set
         * @returns PortableService instance
         */
        public static create(properties?: sheason_chat.IPortableService): sheason_chat.PortableService;

        /**
         * Encodes the specified PortableService message. Does not implicitly {@link sheason_chat.PortableService.verify|verify} messages.
         * @param message PortableService message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encode(message: sheason_chat.IPortableService, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Encodes the specified PortableService message, length delimited. Does not implicitly {@link sheason_chat.PortableService.verify|verify} messages.
         * @param message PortableService message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encodeDelimited(message: sheason_chat.IPortableService, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Decodes a PortableService message from the specified reader or buffer.
         * @param reader Reader or buffer to decode from
         * @param [length] Message length if known beforehand
         * @returns PortableService
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): sheason_chat.PortableService;

        /**
         * Decodes a PortableService message from the specified reader or buffer, length delimited.
         * @param reader Reader or buffer to decode from
         * @returns PortableService
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): sheason_chat.PortableService;

        /**
         * Verifies a PortableService message.
         * @param message Plain object to verify
         * @returns `null` if valid, otherwise the reason why it is not
         */
        public static verify(message: { [k: string]: any }): (string|null);

        /**
         * Creates a PortableService message from a plain object. Also converts values to their respective internal types.
         * @param object Plain object
         * @returns PortableService
         */
        public static fromObject(object: { [k: string]: any }): sheason_chat.PortableService;

        /**
         * Creates a plain object from a PortableService message. Also converts values to other types if specified.
         * @param message PortableService
         * @param [options] Conversion options
         * @returns Plain object
         */
        public static toObject(message: sheason_chat.PortableService, options?: $protobuf.IConversionOptions): { [k: string]: any };

        /**
         * Converts this PortableService to JSON.
         * @returns JSON object
         */
        public toJSON(): { [k: string]: any };

        /**
         * Gets the default type url for PortableService
         * @param [typeUrlPrefix] your custom typeUrlPrefix(default "type.googleapis.com")
         * @returns The default type url
         */
        public static getTypeUrl(typeUrlPrefix?: string): string;
    }

    /** EncryptType enum. */
    enum EncryptType {
        ENCRYPT_TYPE_NONE = 0,
        ENCRYPT_TYPE_SHARED_SECRET = 1,
        ENCRYPT_TYPE_DECLARED_SECRET = 2
    }

    /** Properties of a PortableSecretBox. */
    interface IPortableSecretBox {

        /** PortableSecretBox cipherData */
        cipherData?: (Uint8Array|null);

        /** PortableSecretBox nonce */
        nonce?: (Uint8Array|null);

        /** PortableSecretBox mac */
        mac?: (Uint8Array|null);

        /** PortableSecretBox sender */
        sender?: (sheason_chat.IAccountIndex|null);

        /** PortableSecretBox receiver */
        receiver?: (sheason_chat.IAccountIndex|null);

        /** PortableSecretBox encryptType */
        encryptType?: (sheason_chat.EncryptType|null);

        /** PortableSecretBox declaredKey */
        declaredKey?: (number|null);
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

        /** PortableSecretBox sender. */
        public sender?: (sheason_chat.IAccountIndex|null);

        /** PortableSecretBox receiver. */
        public receiver?: (sheason_chat.IAccountIndex|null);

        /** PortableSecretBox encryptType. */
        public encryptType: sheason_chat.EncryptType;

        /** PortableSecretBox declaredKey. */
        public declaredKey: number;

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

    /** OperationType enum. */
    enum OperationType {
        UNKNOWN_OPEARTION = 0,
        PUT_USERNAME = 1,
        PUT_SERVICE = 2,
        PUT_CONTACT = 3,
        PUT_CONVERSATION = 4,
        PUT_CONVERSATION_ANCHOR = 5,
        PUT_MESSAGE = 6,
        PUT_AVATAR = 7,
        DELETE_SERVICE = 101
    }

    /** Properties of a PortableOperation. */
    interface IPortableOperation {

        /** PortableOperation clientId */
        clientId?: (string|null);

        /** PortableOperation clock */
        clock?: (number|null);

        /** PortableOperation type */
        type?: (sheason_chat.OperationType|null);

        /** PortableOperation content */
        content?: (string|null);
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

        /** PortableOperation type. */
        public type: sheason_chat.OperationType;

        /** PortableOperation content. */
        public content: string;

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
        members?: (sheason_chat.IAccountSnapshot[]|null);

        /** PortableConversation owner */
        owner?: (sheason_chat.IAccountSnapshot|null);

        /** PortableConversation remoteUrl */
        remoteUrl?: (string|null);

        /** PortableConversation declaredSecrets */
        declaredSecrets?: (Uint8Array[]|null);

        /** PortableConversation agent */
        agent?: (sheason_chat.IAccountIndex|null);

        /** PortableConversation version */
        version?: (number|null);

        /** PortableConversation name */
        name?: (string|null);

        /** PortableConversation avatarUrl */
        avatarUrl?: (string|null);
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
        public members: sheason_chat.IAccountSnapshot[];

        /** PortableConversation owner. */
        public owner?: (sheason_chat.IAccountSnapshot|null);

        /** PortableConversation remoteUrl. */
        public remoteUrl: string;

        /** PortableConversation declaredSecrets. */
        public declaredSecrets: Uint8Array[];

        /** PortableConversation agent. */
        public agent?: (sheason_chat.IAccountIndex|null);

        /** PortableConversation version. */
        public version: number;

        /** PortableConversation name. */
        public name: string;

        /** PortableConversation avatarUrl. */
        public avatarUrl: string;

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
        MESSAGE_TYPE_FILE = 5,
        MESSAGE_TYPE_RTC = 6,
        MESSAGE_TYPE_STATE_ONLY = 101,
        MESSAGE_TYPE_NOTIFY = 102,
        MESSAGE_TYPE_CONVERSATION_UPGRADE = 103
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
        sender?: (sheason_chat.IAccountSnapshot|null);

        /** PortableMessage conversation */
        conversation?: (sheason_chat.IPortableConversation|null);

        /** PortableMessage messageStates */
        messageStates?: (sheason_chat.IPortableMessageState[]|null);

        /** PortableMessage createdAt */
        createdAt?: (number|Long|null);
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
        public sender?: (sheason_chat.IAccountSnapshot|null);

        /** PortableMessage conversation. */
        public conversation?: (sheason_chat.IPortableConversation|null);

        /** PortableMessage messageStates. */
        public messageStates: sheason_chat.IPortableMessageState[];

        /** PortableMessage createdAt. */
        public createdAt: (number|Long);

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

        /** PortableMessageState accountIndex */
        accountIndex?: (sheason_chat.IAccountIndex|null);

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

        /** PortableMessageState accountIndex. */
        public accountIndex?: (sheason_chat.IAccountIndex|null);

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

    /** ContentType enum. */
    enum ContentType {
        CONTENT_BUFFER = 0,
        CONTENT_MESSAGE = 1,
        CONTENT_OPERATION = 2,
        CONTENT_CONVERSATION = 3
    }

    /** Properties of a SignWrapper. */
    interface ISignWrapper {

        /** SignWrapper signer */
        signer?: (sheason_chat.IAccountIndex|null);

        /** SignWrapper buffer */
        buffer?: (Uint8Array|null);

        /** SignWrapper sign */
        sign?: (Uint8Array|null);

        /** SignWrapper encrypt */
        encrypt?: (boolean|null);

        /** SignWrapper contentType */
        contentType?: (sheason_chat.ContentType|null);

        /** SignWrapper createdAt */
        createdAt?: (number|Long|null);
    }

    /** Represents a SignWrapper. */
    class SignWrapper implements ISignWrapper {

        /**
         * Constructs a new SignWrapper.
         * @param [properties] Properties to set
         */
        constructor(properties?: sheason_chat.ISignWrapper);

        /** SignWrapper signer. */
        public signer?: (sheason_chat.IAccountIndex|null);

        /** SignWrapper buffer. */
        public buffer: Uint8Array;

        /** SignWrapper sign. */
        public sign: Uint8Array;

        /** SignWrapper encrypt. */
        public encrypt: boolean;

        /** SignWrapper contentType. */
        public contentType: sheason_chat.ContentType;

        /** SignWrapper createdAt. */
        public createdAt: (number|Long);

        /**
         * Creates a new SignWrapper instance using the specified properties.
         * @param [properties] Properties to set
         * @returns SignWrapper instance
         */
        public static create(properties?: sheason_chat.ISignWrapper): sheason_chat.SignWrapper;

        /**
         * Encodes the specified SignWrapper message. Does not implicitly {@link sheason_chat.SignWrapper.verify|verify} messages.
         * @param message SignWrapper message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encode(message: sheason_chat.ISignWrapper, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Encodes the specified SignWrapper message, length delimited. Does not implicitly {@link sheason_chat.SignWrapper.verify|verify} messages.
         * @param message SignWrapper message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encodeDelimited(message: sheason_chat.ISignWrapper, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Decodes a SignWrapper message from the specified reader or buffer.
         * @param reader Reader or buffer to decode from
         * @param [length] Message length if known beforehand
         * @returns SignWrapper
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): sheason_chat.SignWrapper;

        /**
         * Decodes a SignWrapper message from the specified reader or buffer, length delimited.
         * @param reader Reader or buffer to decode from
         * @returns SignWrapper
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): sheason_chat.SignWrapper;

        /**
         * Verifies a SignWrapper message.
         * @param message Plain object to verify
         * @returns `null` if valid, otherwise the reason why it is not
         */
        public static verify(message: { [k: string]: any }): (string|null);

        /**
         * Creates a SignWrapper message from a plain object. Also converts values to their respective internal types.
         * @param object Plain object
         * @returns SignWrapper
         */
        public static fromObject(object: { [k: string]: any }): sheason_chat.SignWrapper;

        /**
         * Creates a plain object from a SignWrapper message. Also converts values to other types if specified.
         * @param message SignWrapper
         * @param [options] Conversion options
         * @returns Plain object
         */
        public static toObject(message: sheason_chat.SignWrapper, options?: $protobuf.IConversionOptions): { [k: string]: any };

        /**
         * Converts this SignWrapper to JSON.
         * @returns JSON object
         */
        public toJSON(): { [k: string]: any };

        /**
         * Gets the default type url for SignWrapper
         * @param [typeUrlPrefix] your custom typeUrlPrefix(default "type.googleapis.com")
         * @returns The default type url
         */
        public static getTypeUrl(typeUrlPrefix?: string): string;
    }
}
