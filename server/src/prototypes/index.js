/*eslint-disable block-scoped-var, id-length, no-control-regex, no-magic-numbers, no-prototype-builtins, no-redeclare, no-shadow, no-var, sort-vars*/
(function(global, factory) { /* global define, require, module */

    /* AMD */ if (typeof define === 'function' && define.amd)
        define(["protobufjs/minimal"], factory);

    /* CommonJS */ else if (typeof require === 'function' && typeof module === 'object' && module && module.exports)
        module.exports = factory(require("protobufjs/minimal"));

})(this, function($protobuf) {
    "use strict";

    // Common aliases
    var $Reader = $protobuf.Reader, $Writer = $protobuf.Writer, $util = $protobuf.util;
    
    // Exported root namespace
    var $root = $protobuf.roots["default"] || ($protobuf.roots["default"] = {});
    
    $root.sheason_chat = (function() {
    
        /**
         * Namespace sheason_chat.
         * @exports sheason_chat
         * @namespace
         */
        var sheason_chat = {};
    
        sheason_chat.AccountSecret = (function() {
    
            /**
             * Properties of an AccountSecret.
             * @memberof sheason_chat
             * @interface IAccountSecret
             * @property {string|null} [ecdhPubKey] AccountSecret ecdhPubKey
             * @property {string|null} [ecdhPrivKey] AccountSecret ecdhPrivKey
             * @property {string|null} [signPubKey] AccountSecret signPubKey
             * @property {string|null} [signPrivKey] AccountSecret signPrivKey
             */
    
            /**
             * Constructs a new AccountSecret.
             * @memberof sheason_chat
             * @classdesc Represents an AccountSecret.
             * @implements IAccountSecret
             * @constructor
             * @param {sheason_chat.IAccountSecret=} [properties] Properties to set
             */
            function AccountSecret(properties) {
                if (properties)
                    for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                        if (properties[keys[i]] != null)
                            this[keys[i]] = properties[keys[i]];
            }
    
            /**
             * AccountSecret ecdhPubKey.
             * @member {string} ecdhPubKey
             * @memberof sheason_chat.AccountSecret
             * @instance
             */
            AccountSecret.prototype.ecdhPubKey = "";
    
            /**
             * AccountSecret ecdhPrivKey.
             * @member {string} ecdhPrivKey
             * @memberof sheason_chat.AccountSecret
             * @instance
             */
            AccountSecret.prototype.ecdhPrivKey = "";
    
            /**
             * AccountSecret signPubKey.
             * @member {string} signPubKey
             * @memberof sheason_chat.AccountSecret
             * @instance
             */
            AccountSecret.prototype.signPubKey = "";
    
            /**
             * AccountSecret signPrivKey.
             * @member {string} signPrivKey
             * @memberof sheason_chat.AccountSecret
             * @instance
             */
            AccountSecret.prototype.signPrivKey = "";
    
            /**
             * Creates a new AccountSecret instance using the specified properties.
             * @function create
             * @memberof sheason_chat.AccountSecret
             * @static
             * @param {sheason_chat.IAccountSecret=} [properties] Properties to set
             * @returns {sheason_chat.AccountSecret} AccountSecret instance
             */
            AccountSecret.create = function create(properties) {
                return new AccountSecret(properties);
            };
    
            /**
             * Encodes the specified AccountSecret message. Does not implicitly {@link sheason_chat.AccountSecret.verify|verify} messages.
             * @function encode
             * @memberof sheason_chat.AccountSecret
             * @static
             * @param {sheason_chat.IAccountSecret} message AccountSecret message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            AccountSecret.encode = function encode(message, writer) {
                if (!writer)
                    writer = $Writer.create();
                if (message.ecdhPubKey != null && Object.hasOwnProperty.call(message, "ecdhPubKey"))
                    writer.uint32(/* id 1, wireType 2 =*/10).string(message.ecdhPubKey);
                if (message.ecdhPrivKey != null && Object.hasOwnProperty.call(message, "ecdhPrivKey"))
                    writer.uint32(/* id 2, wireType 2 =*/18).string(message.ecdhPrivKey);
                if (message.signPubKey != null && Object.hasOwnProperty.call(message, "signPubKey"))
                    writer.uint32(/* id 3, wireType 2 =*/26).string(message.signPubKey);
                if (message.signPrivKey != null && Object.hasOwnProperty.call(message, "signPrivKey"))
                    writer.uint32(/* id 4, wireType 2 =*/34).string(message.signPrivKey);
                return writer;
            };
    
            /**
             * Encodes the specified AccountSecret message, length delimited. Does not implicitly {@link sheason_chat.AccountSecret.verify|verify} messages.
             * @function encodeDelimited
             * @memberof sheason_chat.AccountSecret
             * @static
             * @param {sheason_chat.IAccountSecret} message AccountSecret message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            AccountSecret.encodeDelimited = function encodeDelimited(message, writer) {
                return this.encode(message, writer).ldelim();
            };
    
            /**
             * Decodes an AccountSecret message from the specified reader or buffer.
             * @function decode
             * @memberof sheason_chat.AccountSecret
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @param {number} [length] Message length if known beforehand
             * @returns {sheason_chat.AccountSecret} AccountSecret
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            AccountSecret.decode = function decode(reader, length) {
                if (!(reader instanceof $Reader))
                    reader = $Reader.create(reader);
                var end = length === undefined ? reader.len : reader.pos + length, message = new $root.sheason_chat.AccountSecret();
                while (reader.pos < end) {
                    var tag = reader.uint32();
                    switch (tag >>> 3) {
                    case 1: {
                            message.ecdhPubKey = reader.string();
                            break;
                        }
                    case 2: {
                            message.ecdhPrivKey = reader.string();
                            break;
                        }
                    case 3: {
                            message.signPubKey = reader.string();
                            break;
                        }
                    case 4: {
                            message.signPrivKey = reader.string();
                            break;
                        }
                    default:
                        reader.skipType(tag & 7);
                        break;
                    }
                }
                return message;
            };
    
            /**
             * Decodes an AccountSecret message from the specified reader or buffer, length delimited.
             * @function decodeDelimited
             * @memberof sheason_chat.AccountSecret
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @returns {sheason_chat.AccountSecret} AccountSecret
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            AccountSecret.decodeDelimited = function decodeDelimited(reader) {
                if (!(reader instanceof $Reader))
                    reader = new $Reader(reader);
                return this.decode(reader, reader.uint32());
            };
    
            /**
             * Verifies an AccountSecret message.
             * @function verify
             * @memberof sheason_chat.AccountSecret
             * @static
             * @param {Object.<string,*>} message Plain object to verify
             * @returns {string|null} `null` if valid, otherwise the reason why it is not
             */
            AccountSecret.verify = function verify(message) {
                if (typeof message !== "object" || message === null)
                    return "object expected";
                if (message.ecdhPubKey != null && message.hasOwnProperty("ecdhPubKey"))
                    if (!$util.isString(message.ecdhPubKey))
                        return "ecdhPubKey: string expected";
                if (message.ecdhPrivKey != null && message.hasOwnProperty("ecdhPrivKey"))
                    if (!$util.isString(message.ecdhPrivKey))
                        return "ecdhPrivKey: string expected";
                if (message.signPubKey != null && message.hasOwnProperty("signPubKey"))
                    if (!$util.isString(message.signPubKey))
                        return "signPubKey: string expected";
                if (message.signPrivKey != null && message.hasOwnProperty("signPrivKey"))
                    if (!$util.isString(message.signPrivKey))
                        return "signPrivKey: string expected";
                return null;
            };
    
            /**
             * Creates an AccountSecret message from a plain object. Also converts values to their respective internal types.
             * @function fromObject
             * @memberof sheason_chat.AccountSecret
             * @static
             * @param {Object.<string,*>} object Plain object
             * @returns {sheason_chat.AccountSecret} AccountSecret
             */
            AccountSecret.fromObject = function fromObject(object) {
                if (object instanceof $root.sheason_chat.AccountSecret)
                    return object;
                var message = new $root.sheason_chat.AccountSecret();
                if (object.ecdhPubKey != null)
                    message.ecdhPubKey = String(object.ecdhPubKey);
                if (object.ecdhPrivKey != null)
                    message.ecdhPrivKey = String(object.ecdhPrivKey);
                if (object.signPubKey != null)
                    message.signPubKey = String(object.signPubKey);
                if (object.signPrivKey != null)
                    message.signPrivKey = String(object.signPrivKey);
                return message;
            };
    
            /**
             * Creates a plain object from an AccountSecret message. Also converts values to other types if specified.
             * @function toObject
             * @memberof sheason_chat.AccountSecret
             * @static
             * @param {sheason_chat.AccountSecret} message AccountSecret
             * @param {$protobuf.IConversionOptions} [options] Conversion options
             * @returns {Object.<string,*>} Plain object
             */
            AccountSecret.toObject = function toObject(message, options) {
                if (!options)
                    options = {};
                var object = {};
                if (options.defaults) {
                    object.ecdhPubKey = "";
                    object.ecdhPrivKey = "";
                    object.signPubKey = "";
                    object.signPrivKey = "";
                }
                if (message.ecdhPubKey != null && message.hasOwnProperty("ecdhPubKey"))
                    object.ecdhPubKey = message.ecdhPubKey;
                if (message.ecdhPrivKey != null && message.hasOwnProperty("ecdhPrivKey"))
                    object.ecdhPrivKey = message.ecdhPrivKey;
                if (message.signPubKey != null && message.hasOwnProperty("signPubKey"))
                    object.signPubKey = message.signPubKey;
                if (message.signPrivKey != null && message.hasOwnProperty("signPrivKey"))
                    object.signPrivKey = message.signPrivKey;
                return object;
            };
    
            /**
             * Converts this AccountSecret to JSON.
             * @function toJSON
             * @memberof sheason_chat.AccountSecret
             * @instance
             * @returns {Object.<string,*>} JSON object
             */
            AccountSecret.prototype.toJSON = function toJSON() {
                return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
            };
    
            /**
             * Gets the default type url for AccountSecret
             * @function getTypeUrl
             * @memberof sheason_chat.AccountSecret
             * @static
             * @param {string} [typeUrlPrefix] your custom typeUrlPrefix(default "type.googleapis.com")
             * @returns {string} The default type url
             */
            AccountSecret.getTypeUrl = function getTypeUrl(typeUrlPrefix) {
                if (typeUrlPrefix === undefined) {
                    typeUrlPrefix = "type.googleapis.com";
                }
                return typeUrlPrefix + "/sheason_chat.AccountSecret";
            };
    
            return AccountSecret;
        })();
    
        sheason_chat.AccountIndex = (function() {
    
            /**
             * Properties of an AccountIndex.
             * @memberof sheason_chat
             * @interface IAccountIndex
             * @property {string|null} [ecdhPubKey] AccountIndex ecdhPubKey
             * @property {string|null} [signPubKey] AccountIndex signPubKey
             */
    
            /**
             * Constructs a new AccountIndex.
             * @memberof sheason_chat
             * @classdesc Represents an AccountIndex.
             * @implements IAccountIndex
             * @constructor
             * @param {sheason_chat.IAccountIndex=} [properties] Properties to set
             */
            function AccountIndex(properties) {
                if (properties)
                    for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                        if (properties[keys[i]] != null)
                            this[keys[i]] = properties[keys[i]];
            }
    
            /**
             * AccountIndex ecdhPubKey.
             * @member {string} ecdhPubKey
             * @memberof sheason_chat.AccountIndex
             * @instance
             */
            AccountIndex.prototype.ecdhPubKey = "";
    
            /**
             * AccountIndex signPubKey.
             * @member {string} signPubKey
             * @memberof sheason_chat.AccountIndex
             * @instance
             */
            AccountIndex.prototype.signPubKey = "";
    
            /**
             * Creates a new AccountIndex instance using the specified properties.
             * @function create
             * @memberof sheason_chat.AccountIndex
             * @static
             * @param {sheason_chat.IAccountIndex=} [properties] Properties to set
             * @returns {sheason_chat.AccountIndex} AccountIndex instance
             */
            AccountIndex.create = function create(properties) {
                return new AccountIndex(properties);
            };
    
            /**
             * Encodes the specified AccountIndex message. Does not implicitly {@link sheason_chat.AccountIndex.verify|verify} messages.
             * @function encode
             * @memberof sheason_chat.AccountIndex
             * @static
             * @param {sheason_chat.IAccountIndex} message AccountIndex message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            AccountIndex.encode = function encode(message, writer) {
                if (!writer)
                    writer = $Writer.create();
                if (message.ecdhPubKey != null && Object.hasOwnProperty.call(message, "ecdhPubKey"))
                    writer.uint32(/* id 1, wireType 2 =*/10).string(message.ecdhPubKey);
                if (message.signPubKey != null && Object.hasOwnProperty.call(message, "signPubKey"))
                    writer.uint32(/* id 2, wireType 2 =*/18).string(message.signPubKey);
                return writer;
            };
    
            /**
             * Encodes the specified AccountIndex message, length delimited. Does not implicitly {@link sheason_chat.AccountIndex.verify|verify} messages.
             * @function encodeDelimited
             * @memberof sheason_chat.AccountIndex
             * @static
             * @param {sheason_chat.IAccountIndex} message AccountIndex message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            AccountIndex.encodeDelimited = function encodeDelimited(message, writer) {
                return this.encode(message, writer).ldelim();
            };
    
            /**
             * Decodes an AccountIndex message from the specified reader or buffer.
             * @function decode
             * @memberof sheason_chat.AccountIndex
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @param {number} [length] Message length if known beforehand
             * @returns {sheason_chat.AccountIndex} AccountIndex
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            AccountIndex.decode = function decode(reader, length) {
                if (!(reader instanceof $Reader))
                    reader = $Reader.create(reader);
                var end = length === undefined ? reader.len : reader.pos + length, message = new $root.sheason_chat.AccountIndex();
                while (reader.pos < end) {
                    var tag = reader.uint32();
                    switch (tag >>> 3) {
                    case 1: {
                            message.ecdhPubKey = reader.string();
                            break;
                        }
                    case 2: {
                            message.signPubKey = reader.string();
                            break;
                        }
                    default:
                        reader.skipType(tag & 7);
                        break;
                    }
                }
                return message;
            };
    
            /**
             * Decodes an AccountIndex message from the specified reader or buffer, length delimited.
             * @function decodeDelimited
             * @memberof sheason_chat.AccountIndex
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @returns {sheason_chat.AccountIndex} AccountIndex
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            AccountIndex.decodeDelimited = function decodeDelimited(reader) {
                if (!(reader instanceof $Reader))
                    reader = new $Reader(reader);
                return this.decode(reader, reader.uint32());
            };
    
            /**
             * Verifies an AccountIndex message.
             * @function verify
             * @memberof sheason_chat.AccountIndex
             * @static
             * @param {Object.<string,*>} message Plain object to verify
             * @returns {string|null} `null` if valid, otherwise the reason why it is not
             */
            AccountIndex.verify = function verify(message) {
                if (typeof message !== "object" || message === null)
                    return "object expected";
                if (message.ecdhPubKey != null && message.hasOwnProperty("ecdhPubKey"))
                    if (!$util.isString(message.ecdhPubKey))
                        return "ecdhPubKey: string expected";
                if (message.signPubKey != null && message.hasOwnProperty("signPubKey"))
                    if (!$util.isString(message.signPubKey))
                        return "signPubKey: string expected";
                return null;
            };
    
            /**
             * Creates an AccountIndex message from a plain object. Also converts values to their respective internal types.
             * @function fromObject
             * @memberof sheason_chat.AccountIndex
             * @static
             * @param {Object.<string,*>} object Plain object
             * @returns {sheason_chat.AccountIndex} AccountIndex
             */
            AccountIndex.fromObject = function fromObject(object) {
                if (object instanceof $root.sheason_chat.AccountIndex)
                    return object;
                var message = new $root.sheason_chat.AccountIndex();
                if (object.ecdhPubKey != null)
                    message.ecdhPubKey = String(object.ecdhPubKey);
                if (object.signPubKey != null)
                    message.signPubKey = String(object.signPubKey);
                return message;
            };
    
            /**
             * Creates a plain object from an AccountIndex message. Also converts values to other types if specified.
             * @function toObject
             * @memberof sheason_chat.AccountIndex
             * @static
             * @param {sheason_chat.AccountIndex} message AccountIndex
             * @param {$protobuf.IConversionOptions} [options] Conversion options
             * @returns {Object.<string,*>} Plain object
             */
            AccountIndex.toObject = function toObject(message, options) {
                if (!options)
                    options = {};
                var object = {};
                if (options.defaults) {
                    object.ecdhPubKey = "";
                    object.signPubKey = "";
                }
                if (message.ecdhPubKey != null && message.hasOwnProperty("ecdhPubKey"))
                    object.ecdhPubKey = message.ecdhPubKey;
                if (message.signPubKey != null && message.hasOwnProperty("signPubKey"))
                    object.signPubKey = message.signPubKey;
                return object;
            };
    
            /**
             * Converts this AccountIndex to JSON.
             * @function toJSON
             * @memberof sheason_chat.AccountIndex
             * @instance
             * @returns {Object.<string,*>} JSON object
             */
            AccountIndex.prototype.toJSON = function toJSON() {
                return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
            };
    
            /**
             * Gets the default type url for AccountIndex
             * @function getTypeUrl
             * @memberof sheason_chat.AccountIndex
             * @static
             * @param {string} [typeUrlPrefix] your custom typeUrlPrefix(default "type.googleapis.com")
             * @returns {string} The default type url
             */
            AccountIndex.getTypeUrl = function getTypeUrl(typeUrlPrefix) {
                if (typeUrlPrefix === undefined) {
                    typeUrlPrefix = "type.googleapis.com";
                }
                return typeUrlPrefix + "/sheason_chat.AccountIndex";
            };
    
            return AccountIndex;
        })();
    
        sheason_chat.AccountSnapshot = (function() {
    
            /**
             * Properties of an AccountSnapshot.
             * @memberof sheason_chat
             * @interface IAccountSnapshot
             * @property {sheason_chat.IAccountIndex|null} [index] AccountSnapshot index
             * @property {string|null} [username] AccountSnapshot username
             * @property {string|null} [avatarUrl] AccountSnapshot avatarUrl
             * @property {Object.<string,sheason_chat.IPortableService>|null} [serviceMap] AccountSnapshot serviceMap
             * @property {number|null} [version] AccountSnapshot version
             */
    
            /**
             * Constructs a new AccountSnapshot.
             * @memberof sheason_chat
             * @classdesc Represents an AccountSnapshot.
             * @implements IAccountSnapshot
             * @constructor
             * @param {sheason_chat.IAccountSnapshot=} [properties] Properties to set
             */
            function AccountSnapshot(properties) {
                this.serviceMap = {};
                if (properties)
                    for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                        if (properties[keys[i]] != null)
                            this[keys[i]] = properties[keys[i]];
            }
    
            /**
             * AccountSnapshot index.
             * @member {sheason_chat.IAccountIndex|null|undefined} index
             * @memberof sheason_chat.AccountSnapshot
             * @instance
             */
            AccountSnapshot.prototype.index = null;
    
            /**
             * AccountSnapshot username.
             * @member {string} username
             * @memberof sheason_chat.AccountSnapshot
             * @instance
             */
            AccountSnapshot.prototype.username = "";
    
            /**
             * AccountSnapshot avatarUrl.
             * @member {string} avatarUrl
             * @memberof sheason_chat.AccountSnapshot
             * @instance
             */
            AccountSnapshot.prototype.avatarUrl = "";
    
            /**
             * AccountSnapshot serviceMap.
             * @member {Object.<string,sheason_chat.IPortableService>} serviceMap
             * @memberof sheason_chat.AccountSnapshot
             * @instance
             */
            AccountSnapshot.prototype.serviceMap = $util.emptyObject;
    
            /**
             * AccountSnapshot version.
             * @member {number} version
             * @memberof sheason_chat.AccountSnapshot
             * @instance
             */
            AccountSnapshot.prototype.version = 0;
    
            /**
             * Creates a new AccountSnapshot instance using the specified properties.
             * @function create
             * @memberof sheason_chat.AccountSnapshot
             * @static
             * @param {sheason_chat.IAccountSnapshot=} [properties] Properties to set
             * @returns {sheason_chat.AccountSnapshot} AccountSnapshot instance
             */
            AccountSnapshot.create = function create(properties) {
                return new AccountSnapshot(properties);
            };
    
            /**
             * Encodes the specified AccountSnapshot message. Does not implicitly {@link sheason_chat.AccountSnapshot.verify|verify} messages.
             * @function encode
             * @memberof sheason_chat.AccountSnapshot
             * @static
             * @param {sheason_chat.IAccountSnapshot} message AccountSnapshot message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            AccountSnapshot.encode = function encode(message, writer) {
                if (!writer)
                    writer = $Writer.create();
                if (message.index != null && Object.hasOwnProperty.call(message, "index"))
                    $root.sheason_chat.AccountIndex.encode(message.index, writer.uint32(/* id 1, wireType 2 =*/10).fork()).ldelim();
                if (message.username != null && Object.hasOwnProperty.call(message, "username"))
                    writer.uint32(/* id 2, wireType 2 =*/18).string(message.username);
                if (message.avatarUrl != null && Object.hasOwnProperty.call(message, "avatarUrl"))
                    writer.uint32(/* id 3, wireType 2 =*/26).string(message.avatarUrl);
                if (message.serviceMap != null && Object.hasOwnProperty.call(message, "serviceMap"))
                    for (var keys = Object.keys(message.serviceMap), i = 0; i < keys.length; ++i) {
                        writer.uint32(/* id 4, wireType 2 =*/34).fork().uint32(/* id 1, wireType 2 =*/10).string(keys[i]);
                        $root.sheason_chat.PortableService.encode(message.serviceMap[keys[i]], writer.uint32(/* id 2, wireType 2 =*/18).fork()).ldelim().ldelim();
                    }
                if (message.version != null && Object.hasOwnProperty.call(message, "version"))
                    writer.uint32(/* id 5, wireType 0 =*/40).int32(message.version);
                return writer;
            };
    
            /**
             * Encodes the specified AccountSnapshot message, length delimited. Does not implicitly {@link sheason_chat.AccountSnapshot.verify|verify} messages.
             * @function encodeDelimited
             * @memberof sheason_chat.AccountSnapshot
             * @static
             * @param {sheason_chat.IAccountSnapshot} message AccountSnapshot message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            AccountSnapshot.encodeDelimited = function encodeDelimited(message, writer) {
                return this.encode(message, writer).ldelim();
            };
    
            /**
             * Decodes an AccountSnapshot message from the specified reader or buffer.
             * @function decode
             * @memberof sheason_chat.AccountSnapshot
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @param {number} [length] Message length if known beforehand
             * @returns {sheason_chat.AccountSnapshot} AccountSnapshot
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            AccountSnapshot.decode = function decode(reader, length) {
                if (!(reader instanceof $Reader))
                    reader = $Reader.create(reader);
                var end = length === undefined ? reader.len : reader.pos + length, message = new $root.sheason_chat.AccountSnapshot(), key, value;
                while (reader.pos < end) {
                    var tag = reader.uint32();
                    switch (tag >>> 3) {
                    case 1: {
                            message.index = $root.sheason_chat.AccountIndex.decode(reader, reader.uint32());
                            break;
                        }
                    case 2: {
                            message.username = reader.string();
                            break;
                        }
                    case 3: {
                            message.avatarUrl = reader.string();
                            break;
                        }
                    case 4: {
                            if (message.serviceMap === $util.emptyObject)
                                message.serviceMap = {};
                            var end2 = reader.uint32() + reader.pos;
                            key = "";
                            value = null;
                            while (reader.pos < end2) {
                                var tag2 = reader.uint32();
                                switch (tag2 >>> 3) {
                                case 1:
                                    key = reader.string();
                                    break;
                                case 2:
                                    value = $root.sheason_chat.PortableService.decode(reader, reader.uint32());
                                    break;
                                default:
                                    reader.skipType(tag2 & 7);
                                    break;
                                }
                            }
                            message.serviceMap[key] = value;
                            break;
                        }
                    case 5: {
                            message.version = reader.int32();
                            break;
                        }
                    default:
                        reader.skipType(tag & 7);
                        break;
                    }
                }
                return message;
            };
    
            /**
             * Decodes an AccountSnapshot message from the specified reader or buffer, length delimited.
             * @function decodeDelimited
             * @memberof sheason_chat.AccountSnapshot
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @returns {sheason_chat.AccountSnapshot} AccountSnapshot
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            AccountSnapshot.decodeDelimited = function decodeDelimited(reader) {
                if (!(reader instanceof $Reader))
                    reader = new $Reader(reader);
                return this.decode(reader, reader.uint32());
            };
    
            /**
             * Verifies an AccountSnapshot message.
             * @function verify
             * @memberof sheason_chat.AccountSnapshot
             * @static
             * @param {Object.<string,*>} message Plain object to verify
             * @returns {string|null} `null` if valid, otherwise the reason why it is not
             */
            AccountSnapshot.verify = function verify(message) {
                if (typeof message !== "object" || message === null)
                    return "object expected";
                if (message.index != null && message.hasOwnProperty("index")) {
                    var error = $root.sheason_chat.AccountIndex.verify(message.index);
                    if (error)
                        return "index." + error;
                }
                if (message.username != null && message.hasOwnProperty("username"))
                    if (!$util.isString(message.username))
                        return "username: string expected";
                if (message.avatarUrl != null && message.hasOwnProperty("avatarUrl"))
                    if (!$util.isString(message.avatarUrl))
                        return "avatarUrl: string expected";
                if (message.serviceMap != null && message.hasOwnProperty("serviceMap")) {
                    if (!$util.isObject(message.serviceMap))
                        return "serviceMap: object expected";
                    var key = Object.keys(message.serviceMap);
                    for (var i = 0; i < key.length; ++i) {
                        var error = $root.sheason_chat.PortableService.verify(message.serviceMap[key[i]]);
                        if (error)
                            return "serviceMap." + error;
                    }
                }
                if (message.version != null && message.hasOwnProperty("version"))
                    if (!$util.isInteger(message.version))
                        return "version: integer expected";
                return null;
            };
    
            /**
             * Creates an AccountSnapshot message from a plain object. Also converts values to their respective internal types.
             * @function fromObject
             * @memberof sheason_chat.AccountSnapshot
             * @static
             * @param {Object.<string,*>} object Plain object
             * @returns {sheason_chat.AccountSnapshot} AccountSnapshot
             */
            AccountSnapshot.fromObject = function fromObject(object) {
                if (object instanceof $root.sheason_chat.AccountSnapshot)
                    return object;
                var message = new $root.sheason_chat.AccountSnapshot();
                if (object.index != null) {
                    if (typeof object.index !== "object")
                        throw TypeError(".sheason_chat.AccountSnapshot.index: object expected");
                    message.index = $root.sheason_chat.AccountIndex.fromObject(object.index);
                }
                if (object.username != null)
                    message.username = String(object.username);
                if (object.avatarUrl != null)
                    message.avatarUrl = String(object.avatarUrl);
                if (object.serviceMap) {
                    if (typeof object.serviceMap !== "object")
                        throw TypeError(".sheason_chat.AccountSnapshot.serviceMap: object expected");
                    message.serviceMap = {};
                    for (var keys = Object.keys(object.serviceMap), i = 0; i < keys.length; ++i) {
                        if (typeof object.serviceMap[keys[i]] !== "object")
                            throw TypeError(".sheason_chat.AccountSnapshot.serviceMap: object expected");
                        message.serviceMap[keys[i]] = $root.sheason_chat.PortableService.fromObject(object.serviceMap[keys[i]]);
                    }
                }
                if (object.version != null)
                    message.version = object.version | 0;
                return message;
            };
    
            /**
             * Creates a plain object from an AccountSnapshot message. Also converts values to other types if specified.
             * @function toObject
             * @memberof sheason_chat.AccountSnapshot
             * @static
             * @param {sheason_chat.AccountSnapshot} message AccountSnapshot
             * @param {$protobuf.IConversionOptions} [options] Conversion options
             * @returns {Object.<string,*>} Plain object
             */
            AccountSnapshot.toObject = function toObject(message, options) {
                if (!options)
                    options = {};
                var object = {};
                if (options.objects || options.defaults)
                    object.serviceMap = {};
                if (options.defaults) {
                    object.index = null;
                    object.username = "";
                    object.avatarUrl = "";
                    object.version = 0;
                }
                if (message.index != null && message.hasOwnProperty("index"))
                    object.index = $root.sheason_chat.AccountIndex.toObject(message.index, options);
                if (message.username != null && message.hasOwnProperty("username"))
                    object.username = message.username;
                if (message.avatarUrl != null && message.hasOwnProperty("avatarUrl"))
                    object.avatarUrl = message.avatarUrl;
                var keys2;
                if (message.serviceMap && (keys2 = Object.keys(message.serviceMap)).length) {
                    object.serviceMap = {};
                    for (var j = 0; j < keys2.length; ++j)
                        object.serviceMap[keys2[j]] = $root.sheason_chat.PortableService.toObject(message.serviceMap[keys2[j]], options);
                }
                if (message.version != null && message.hasOwnProperty("version"))
                    object.version = message.version;
                return object;
            };
    
            /**
             * Converts this AccountSnapshot to JSON.
             * @function toJSON
             * @memberof sheason_chat.AccountSnapshot
             * @instance
             * @returns {Object.<string,*>} JSON object
             */
            AccountSnapshot.prototype.toJSON = function toJSON() {
                return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
            };
    
            /**
             * Gets the default type url for AccountSnapshot
             * @function getTypeUrl
             * @memberof sheason_chat.AccountSnapshot
             * @static
             * @param {string} [typeUrlPrefix] your custom typeUrlPrefix(default "type.googleapis.com")
             * @returns {string} The default type url
             */
            AccountSnapshot.getTypeUrl = function getTypeUrl(typeUrlPrefix) {
                if (typeUrlPrefix === undefined) {
                    typeUrlPrefix = "type.googleapis.com";
                }
                return typeUrlPrefix + "/sheason_chat.AccountSnapshot";
            };
    
            return AccountSnapshot;
        })();
    
        sheason_chat.PortableService = (function() {
    
            /**
             * Properties of a PortableService.
             * @memberof sheason_chat
             * @interface IPortableService
             */
    
            /**
             * Constructs a new PortableService.
             * @memberof sheason_chat
             * @classdesc Represents a PortableService.
             * @implements IPortableService
             * @constructor
             * @param {sheason_chat.IPortableService=} [properties] Properties to set
             */
            function PortableService(properties) {
                if (properties)
                    for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                        if (properties[keys[i]] != null)
                            this[keys[i]] = properties[keys[i]];
            }
    
            /**
             * Creates a new PortableService instance using the specified properties.
             * @function create
             * @memberof sheason_chat.PortableService
             * @static
             * @param {sheason_chat.IPortableService=} [properties] Properties to set
             * @returns {sheason_chat.PortableService} PortableService instance
             */
            PortableService.create = function create(properties) {
                return new PortableService(properties);
            };
    
            /**
             * Encodes the specified PortableService message. Does not implicitly {@link sheason_chat.PortableService.verify|verify} messages.
             * @function encode
             * @memberof sheason_chat.PortableService
             * @static
             * @param {sheason_chat.IPortableService} message PortableService message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            PortableService.encode = function encode(message, writer) {
                if (!writer)
                    writer = $Writer.create();
                return writer;
            };
    
            /**
             * Encodes the specified PortableService message, length delimited. Does not implicitly {@link sheason_chat.PortableService.verify|verify} messages.
             * @function encodeDelimited
             * @memberof sheason_chat.PortableService
             * @static
             * @param {sheason_chat.IPortableService} message PortableService message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            PortableService.encodeDelimited = function encodeDelimited(message, writer) {
                return this.encode(message, writer).ldelim();
            };
    
            /**
             * Decodes a PortableService message from the specified reader or buffer.
             * @function decode
             * @memberof sheason_chat.PortableService
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @param {number} [length] Message length if known beforehand
             * @returns {sheason_chat.PortableService} PortableService
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            PortableService.decode = function decode(reader, length) {
                if (!(reader instanceof $Reader))
                    reader = $Reader.create(reader);
                var end = length === undefined ? reader.len : reader.pos + length, message = new $root.sheason_chat.PortableService();
                while (reader.pos < end) {
                    var tag = reader.uint32();
                    switch (tag >>> 3) {
                    default:
                        reader.skipType(tag & 7);
                        break;
                    }
                }
                return message;
            };
    
            /**
             * Decodes a PortableService message from the specified reader or buffer, length delimited.
             * @function decodeDelimited
             * @memberof sheason_chat.PortableService
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @returns {sheason_chat.PortableService} PortableService
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            PortableService.decodeDelimited = function decodeDelimited(reader) {
                if (!(reader instanceof $Reader))
                    reader = new $Reader(reader);
                return this.decode(reader, reader.uint32());
            };
    
            /**
             * Verifies a PortableService message.
             * @function verify
             * @memberof sheason_chat.PortableService
             * @static
             * @param {Object.<string,*>} message Plain object to verify
             * @returns {string|null} `null` if valid, otherwise the reason why it is not
             */
            PortableService.verify = function verify(message) {
                if (typeof message !== "object" || message === null)
                    return "object expected";
                return null;
            };
    
            /**
             * Creates a PortableService message from a plain object. Also converts values to their respective internal types.
             * @function fromObject
             * @memberof sheason_chat.PortableService
             * @static
             * @param {Object.<string,*>} object Plain object
             * @returns {sheason_chat.PortableService} PortableService
             */
            PortableService.fromObject = function fromObject(object) {
                if (object instanceof $root.sheason_chat.PortableService)
                    return object;
                return new $root.sheason_chat.PortableService();
            };
    
            /**
             * Creates a plain object from a PortableService message. Also converts values to other types if specified.
             * @function toObject
             * @memberof sheason_chat.PortableService
             * @static
             * @param {sheason_chat.PortableService} message PortableService
             * @param {$protobuf.IConversionOptions} [options] Conversion options
             * @returns {Object.<string,*>} Plain object
             */
            PortableService.toObject = function toObject() {
                return {};
            };
    
            /**
             * Converts this PortableService to JSON.
             * @function toJSON
             * @memberof sheason_chat.PortableService
             * @instance
             * @returns {Object.<string,*>} JSON object
             */
            PortableService.prototype.toJSON = function toJSON() {
                return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
            };
    
            /**
             * Gets the default type url for PortableService
             * @function getTypeUrl
             * @memberof sheason_chat.PortableService
             * @static
             * @param {string} [typeUrlPrefix] your custom typeUrlPrefix(default "type.googleapis.com")
             * @returns {string} The default type url
             */
            PortableService.getTypeUrl = function getTypeUrl(typeUrlPrefix) {
                if (typeUrlPrefix === undefined) {
                    typeUrlPrefix = "type.googleapis.com";
                }
                return typeUrlPrefix + "/sheason_chat.PortableService";
            };
    
            return PortableService;
        })();
    
        /**
         * EcryptType enum.
         * @name sheason_chat.EcryptType
         * @enum {number}
         * @property {number} ENCRYPT_TYPE_NONE=0 ENCRYPT_TYPE_NONE value
         * @property {number} ENCRYPT_TYPE_SHARED_SECRET=1 ENCRYPT_TYPE_SHARED_SECRET value
         * @property {number} ENCRYPT_TYPE_DECLARED_SECRET=2 ENCRYPT_TYPE_DECLARED_SECRET value
         */
        sheason_chat.EcryptType = (function() {
            var valuesById = {}, values = Object.create(valuesById);
            values[valuesById[0] = "ENCRYPT_TYPE_NONE"] = 0;
            values[valuesById[1] = "ENCRYPT_TYPE_SHARED_SECRET"] = 1;
            values[valuesById[2] = "ENCRYPT_TYPE_DECLARED_SECRET"] = 2;
            return values;
        })();
    
        sheason_chat.PortableSecretBox = (function() {
    
            /**
             * Properties of a PortableSecretBox.
             * @memberof sheason_chat
             * @interface IPortableSecretBox
             * @property {Uint8Array|null} [cipherData] PortableSecretBox cipherData
             * @property {Uint8Array|null} [nonce] PortableSecretBox nonce
             * @property {Uint8Array|null} [mac] PortableSecretBox mac
             * @property {sheason_chat.IAccountIndex|null} [sender] PortableSecretBox sender
             * @property {sheason_chat.IAccountIndex|null} [receiver] PortableSecretBox receiver
             * @property {sheason_chat.EcryptType|null} [encryptType] PortableSecretBox encryptType
             */
    
            /**
             * Constructs a new PortableSecretBox.
             * @memberof sheason_chat
             * @classdesc Represents a PortableSecretBox.
             * @implements IPortableSecretBox
             * @constructor
             * @param {sheason_chat.IPortableSecretBox=} [properties] Properties to set
             */
            function PortableSecretBox(properties) {
                if (properties)
                    for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                        if (properties[keys[i]] != null)
                            this[keys[i]] = properties[keys[i]];
            }
    
            /**
             * PortableSecretBox cipherData.
             * @member {Uint8Array} cipherData
             * @memberof sheason_chat.PortableSecretBox
             * @instance
             */
            PortableSecretBox.prototype.cipherData = $util.newBuffer([]);
    
            /**
             * PortableSecretBox nonce.
             * @member {Uint8Array} nonce
             * @memberof sheason_chat.PortableSecretBox
             * @instance
             */
            PortableSecretBox.prototype.nonce = $util.newBuffer([]);
    
            /**
             * PortableSecretBox mac.
             * @member {Uint8Array} mac
             * @memberof sheason_chat.PortableSecretBox
             * @instance
             */
            PortableSecretBox.prototype.mac = $util.newBuffer([]);
    
            /**
             * PortableSecretBox sender.
             * @member {sheason_chat.IAccountIndex|null|undefined} sender
             * @memberof sheason_chat.PortableSecretBox
             * @instance
             */
            PortableSecretBox.prototype.sender = null;
    
            /**
             * PortableSecretBox receiver.
             * @member {sheason_chat.IAccountIndex|null|undefined} receiver
             * @memberof sheason_chat.PortableSecretBox
             * @instance
             */
            PortableSecretBox.prototype.receiver = null;
    
            /**
             * PortableSecretBox encryptType.
             * @member {sheason_chat.EcryptType} encryptType
             * @memberof sheason_chat.PortableSecretBox
             * @instance
             */
            PortableSecretBox.prototype.encryptType = 0;
    
            /**
             * Creates a new PortableSecretBox instance using the specified properties.
             * @function create
             * @memberof sheason_chat.PortableSecretBox
             * @static
             * @param {sheason_chat.IPortableSecretBox=} [properties] Properties to set
             * @returns {sheason_chat.PortableSecretBox} PortableSecretBox instance
             */
            PortableSecretBox.create = function create(properties) {
                return new PortableSecretBox(properties);
            };
    
            /**
             * Encodes the specified PortableSecretBox message. Does not implicitly {@link sheason_chat.PortableSecretBox.verify|verify} messages.
             * @function encode
             * @memberof sheason_chat.PortableSecretBox
             * @static
             * @param {sheason_chat.IPortableSecretBox} message PortableSecretBox message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            PortableSecretBox.encode = function encode(message, writer) {
                if (!writer)
                    writer = $Writer.create();
                if (message.cipherData != null && Object.hasOwnProperty.call(message, "cipherData"))
                    writer.uint32(/* id 1, wireType 2 =*/10).bytes(message.cipherData);
                if (message.nonce != null && Object.hasOwnProperty.call(message, "nonce"))
                    writer.uint32(/* id 2, wireType 2 =*/18).bytes(message.nonce);
                if (message.mac != null && Object.hasOwnProperty.call(message, "mac"))
                    writer.uint32(/* id 3, wireType 2 =*/26).bytes(message.mac);
                if (message.sender != null && Object.hasOwnProperty.call(message, "sender"))
                    $root.sheason_chat.AccountIndex.encode(message.sender, writer.uint32(/* id 4, wireType 2 =*/34).fork()).ldelim();
                if (message.receiver != null && Object.hasOwnProperty.call(message, "receiver"))
                    $root.sheason_chat.AccountIndex.encode(message.receiver, writer.uint32(/* id 5, wireType 2 =*/42).fork()).ldelim();
                if (message.encryptType != null && Object.hasOwnProperty.call(message, "encryptType"))
                    writer.uint32(/* id 6, wireType 0 =*/48).int32(message.encryptType);
                return writer;
            };
    
            /**
             * Encodes the specified PortableSecretBox message, length delimited. Does not implicitly {@link sheason_chat.PortableSecretBox.verify|verify} messages.
             * @function encodeDelimited
             * @memberof sheason_chat.PortableSecretBox
             * @static
             * @param {sheason_chat.IPortableSecretBox} message PortableSecretBox message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            PortableSecretBox.encodeDelimited = function encodeDelimited(message, writer) {
                return this.encode(message, writer).ldelim();
            };
    
            /**
             * Decodes a PortableSecretBox message from the specified reader or buffer.
             * @function decode
             * @memberof sheason_chat.PortableSecretBox
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @param {number} [length] Message length if known beforehand
             * @returns {sheason_chat.PortableSecretBox} PortableSecretBox
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            PortableSecretBox.decode = function decode(reader, length) {
                if (!(reader instanceof $Reader))
                    reader = $Reader.create(reader);
                var end = length === undefined ? reader.len : reader.pos + length, message = new $root.sheason_chat.PortableSecretBox();
                while (reader.pos < end) {
                    var tag = reader.uint32();
                    switch (tag >>> 3) {
                    case 1: {
                            message.cipherData = reader.bytes();
                            break;
                        }
                    case 2: {
                            message.nonce = reader.bytes();
                            break;
                        }
                    case 3: {
                            message.mac = reader.bytes();
                            break;
                        }
                    case 4: {
                            message.sender = $root.sheason_chat.AccountIndex.decode(reader, reader.uint32());
                            break;
                        }
                    case 5: {
                            message.receiver = $root.sheason_chat.AccountIndex.decode(reader, reader.uint32());
                            break;
                        }
                    case 6: {
                            message.encryptType = reader.int32();
                            break;
                        }
                    default:
                        reader.skipType(tag & 7);
                        break;
                    }
                }
                return message;
            };
    
            /**
             * Decodes a PortableSecretBox message from the specified reader or buffer, length delimited.
             * @function decodeDelimited
             * @memberof sheason_chat.PortableSecretBox
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @returns {sheason_chat.PortableSecretBox} PortableSecretBox
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            PortableSecretBox.decodeDelimited = function decodeDelimited(reader) {
                if (!(reader instanceof $Reader))
                    reader = new $Reader(reader);
                return this.decode(reader, reader.uint32());
            };
    
            /**
             * Verifies a PortableSecretBox message.
             * @function verify
             * @memberof sheason_chat.PortableSecretBox
             * @static
             * @param {Object.<string,*>} message Plain object to verify
             * @returns {string|null} `null` if valid, otherwise the reason why it is not
             */
            PortableSecretBox.verify = function verify(message) {
                if (typeof message !== "object" || message === null)
                    return "object expected";
                if (message.cipherData != null && message.hasOwnProperty("cipherData"))
                    if (!(message.cipherData && typeof message.cipherData.length === "number" || $util.isString(message.cipherData)))
                        return "cipherData: buffer expected";
                if (message.nonce != null && message.hasOwnProperty("nonce"))
                    if (!(message.nonce && typeof message.nonce.length === "number" || $util.isString(message.nonce)))
                        return "nonce: buffer expected";
                if (message.mac != null && message.hasOwnProperty("mac"))
                    if (!(message.mac && typeof message.mac.length === "number" || $util.isString(message.mac)))
                        return "mac: buffer expected";
                if (message.sender != null && message.hasOwnProperty("sender")) {
                    var error = $root.sheason_chat.AccountIndex.verify(message.sender);
                    if (error)
                        return "sender." + error;
                }
                if (message.receiver != null && message.hasOwnProperty("receiver")) {
                    var error = $root.sheason_chat.AccountIndex.verify(message.receiver);
                    if (error)
                        return "receiver." + error;
                }
                if (message.encryptType != null && message.hasOwnProperty("encryptType"))
                    switch (message.encryptType) {
                    default:
                        return "encryptType: enum value expected";
                    case 0:
                    case 1:
                    case 2:
                        break;
                    }
                return null;
            };
    
            /**
             * Creates a PortableSecretBox message from a plain object. Also converts values to their respective internal types.
             * @function fromObject
             * @memberof sheason_chat.PortableSecretBox
             * @static
             * @param {Object.<string,*>} object Plain object
             * @returns {sheason_chat.PortableSecretBox} PortableSecretBox
             */
            PortableSecretBox.fromObject = function fromObject(object) {
                if (object instanceof $root.sheason_chat.PortableSecretBox)
                    return object;
                var message = new $root.sheason_chat.PortableSecretBox();
                if (object.cipherData != null)
                    if (typeof object.cipherData === "string")
                        $util.base64.decode(object.cipherData, message.cipherData = $util.newBuffer($util.base64.length(object.cipherData)), 0);
                    else if (object.cipherData.length >= 0)
                        message.cipherData = object.cipherData;
                if (object.nonce != null)
                    if (typeof object.nonce === "string")
                        $util.base64.decode(object.nonce, message.nonce = $util.newBuffer($util.base64.length(object.nonce)), 0);
                    else if (object.nonce.length >= 0)
                        message.nonce = object.nonce;
                if (object.mac != null)
                    if (typeof object.mac === "string")
                        $util.base64.decode(object.mac, message.mac = $util.newBuffer($util.base64.length(object.mac)), 0);
                    else if (object.mac.length >= 0)
                        message.mac = object.mac;
                if (object.sender != null) {
                    if (typeof object.sender !== "object")
                        throw TypeError(".sheason_chat.PortableSecretBox.sender: object expected");
                    message.sender = $root.sheason_chat.AccountIndex.fromObject(object.sender);
                }
                if (object.receiver != null) {
                    if (typeof object.receiver !== "object")
                        throw TypeError(".sheason_chat.PortableSecretBox.receiver: object expected");
                    message.receiver = $root.sheason_chat.AccountIndex.fromObject(object.receiver);
                }
                switch (object.encryptType) {
                default:
                    if (typeof object.encryptType === "number") {
                        message.encryptType = object.encryptType;
                        break;
                    }
                    break;
                case "ENCRYPT_TYPE_NONE":
                case 0:
                    message.encryptType = 0;
                    break;
                case "ENCRYPT_TYPE_SHARED_SECRET":
                case 1:
                    message.encryptType = 1;
                    break;
                case "ENCRYPT_TYPE_DECLARED_SECRET":
                case 2:
                    message.encryptType = 2;
                    break;
                }
                return message;
            };
    
            /**
             * Creates a plain object from a PortableSecretBox message. Also converts values to other types if specified.
             * @function toObject
             * @memberof sheason_chat.PortableSecretBox
             * @static
             * @param {sheason_chat.PortableSecretBox} message PortableSecretBox
             * @param {$protobuf.IConversionOptions} [options] Conversion options
             * @returns {Object.<string,*>} Plain object
             */
            PortableSecretBox.toObject = function toObject(message, options) {
                if (!options)
                    options = {};
                var object = {};
                if (options.defaults) {
                    if (options.bytes === String)
                        object.cipherData = "";
                    else {
                        object.cipherData = [];
                        if (options.bytes !== Array)
                            object.cipherData = $util.newBuffer(object.cipherData);
                    }
                    if (options.bytes === String)
                        object.nonce = "";
                    else {
                        object.nonce = [];
                        if (options.bytes !== Array)
                            object.nonce = $util.newBuffer(object.nonce);
                    }
                    if (options.bytes === String)
                        object.mac = "";
                    else {
                        object.mac = [];
                        if (options.bytes !== Array)
                            object.mac = $util.newBuffer(object.mac);
                    }
                    object.sender = null;
                    object.receiver = null;
                    object.encryptType = options.enums === String ? "ENCRYPT_TYPE_NONE" : 0;
                }
                if (message.cipherData != null && message.hasOwnProperty("cipherData"))
                    object.cipherData = options.bytes === String ? $util.base64.encode(message.cipherData, 0, message.cipherData.length) : options.bytes === Array ? Array.prototype.slice.call(message.cipherData) : message.cipherData;
                if (message.nonce != null && message.hasOwnProperty("nonce"))
                    object.nonce = options.bytes === String ? $util.base64.encode(message.nonce, 0, message.nonce.length) : options.bytes === Array ? Array.prototype.slice.call(message.nonce) : message.nonce;
                if (message.mac != null && message.hasOwnProperty("mac"))
                    object.mac = options.bytes === String ? $util.base64.encode(message.mac, 0, message.mac.length) : options.bytes === Array ? Array.prototype.slice.call(message.mac) : message.mac;
                if (message.sender != null && message.hasOwnProperty("sender"))
                    object.sender = $root.sheason_chat.AccountIndex.toObject(message.sender, options);
                if (message.receiver != null && message.hasOwnProperty("receiver"))
                    object.receiver = $root.sheason_chat.AccountIndex.toObject(message.receiver, options);
                if (message.encryptType != null && message.hasOwnProperty("encryptType"))
                    object.encryptType = options.enums === String ? $root.sheason_chat.EcryptType[message.encryptType] === undefined ? message.encryptType : $root.sheason_chat.EcryptType[message.encryptType] : message.encryptType;
                return object;
            };
    
            /**
             * Converts this PortableSecretBox to JSON.
             * @function toJSON
             * @memberof sheason_chat.PortableSecretBox
             * @instance
             * @returns {Object.<string,*>} JSON object
             */
            PortableSecretBox.prototype.toJSON = function toJSON() {
                return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
            };
    
            /**
             * Gets the default type url for PortableSecretBox
             * @function getTypeUrl
             * @memberof sheason_chat.PortableSecretBox
             * @static
             * @param {string} [typeUrlPrefix] your custom typeUrlPrefix(default "type.googleapis.com")
             * @returns {string} The default type url
             */
            PortableSecretBox.getTypeUrl = function getTypeUrl(typeUrlPrefix) {
                if (typeUrlPrefix === undefined) {
                    typeUrlPrefix = "type.googleapis.com";
                }
                return typeUrlPrefix + "/sheason_chat.PortableSecretBox";
            };
    
            return PortableSecretBox;
        })();
    
        /**
         * OperationType enum.
         * @name sheason_chat.OperationType
         * @enum {number}
         * @property {number} UNKNOWN_OPEARTION=0 UNKNOWN_OPEARTION value
         * @property {number} PUT_USERNAME=1 PUT_USERNAME value
         * @property {number} PUT_SERVICE=2 PUT_SERVICE value
         * @property {number} PUT_CONTACT=3 PUT_CONTACT value
         * @property {number} PUT_CONVERSATION=4 PUT_CONVERSATION value
         * @property {number} PUT_CONVERSATION_ANCHOR=5 PUT_CONVERSATION_ANCHOR value
         * @property {number} PUT_MESSAGE=6 PUT_MESSAGE value
         * @property {number} DELETE_SERVICE=101 DELETE_SERVICE value
         */
        sheason_chat.OperationType = (function() {
            var valuesById = {}, values = Object.create(valuesById);
            values[valuesById[0] = "UNKNOWN_OPEARTION"] = 0;
            values[valuesById[1] = "PUT_USERNAME"] = 1;
            values[valuesById[2] = "PUT_SERVICE"] = 2;
            values[valuesById[3] = "PUT_CONTACT"] = 3;
            values[valuesById[4] = "PUT_CONVERSATION"] = 4;
            values[valuesById[5] = "PUT_CONVERSATION_ANCHOR"] = 5;
            values[valuesById[6] = "PUT_MESSAGE"] = 6;
            values[valuesById[101] = "DELETE_SERVICE"] = 101;
            return values;
        })();
    
        sheason_chat.PortableOperation = (function() {
    
            /**
             * Properties of a PortableOperation.
             * @memberof sheason_chat
             * @interface IPortableOperation
             * @property {string|null} [clientId] PortableOperation clientId
             * @property {number|null} [clock] PortableOperation clock
             * @property {sheason_chat.OperationType|null} [type] PortableOperation type
             * @property {string|null} [content] PortableOperation content
             */
    
            /**
             * Constructs a new PortableOperation.
             * @memberof sheason_chat
             * @classdesc Represents a PortableOperation.
             * @implements IPortableOperation
             * @constructor
             * @param {sheason_chat.IPortableOperation=} [properties] Properties to set
             */
            function PortableOperation(properties) {
                if (properties)
                    for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                        if (properties[keys[i]] != null)
                            this[keys[i]] = properties[keys[i]];
            }
    
            /**
             * PortableOperation clientId.
             * @member {string} clientId
             * @memberof sheason_chat.PortableOperation
             * @instance
             */
            PortableOperation.prototype.clientId = "";
    
            /**
             * PortableOperation clock.
             * @member {number} clock
             * @memberof sheason_chat.PortableOperation
             * @instance
             */
            PortableOperation.prototype.clock = 0;
    
            /**
             * PortableOperation type.
             * @member {sheason_chat.OperationType} type
             * @memberof sheason_chat.PortableOperation
             * @instance
             */
            PortableOperation.prototype.type = 0;
    
            /**
             * PortableOperation content.
             * @member {string} content
             * @memberof sheason_chat.PortableOperation
             * @instance
             */
            PortableOperation.prototype.content = "";
    
            /**
             * Creates a new PortableOperation instance using the specified properties.
             * @function create
             * @memberof sheason_chat.PortableOperation
             * @static
             * @param {sheason_chat.IPortableOperation=} [properties] Properties to set
             * @returns {sheason_chat.PortableOperation} PortableOperation instance
             */
            PortableOperation.create = function create(properties) {
                return new PortableOperation(properties);
            };
    
            /**
             * Encodes the specified PortableOperation message. Does not implicitly {@link sheason_chat.PortableOperation.verify|verify} messages.
             * @function encode
             * @memberof sheason_chat.PortableOperation
             * @static
             * @param {sheason_chat.IPortableOperation} message PortableOperation message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            PortableOperation.encode = function encode(message, writer) {
                if (!writer)
                    writer = $Writer.create();
                if (message.clientId != null && Object.hasOwnProperty.call(message, "clientId"))
                    writer.uint32(/* id 1, wireType 2 =*/10).string(message.clientId);
                if (message.clock != null && Object.hasOwnProperty.call(message, "clock"))
                    writer.uint32(/* id 2, wireType 0 =*/16).int32(message.clock);
                if (message.type != null && Object.hasOwnProperty.call(message, "type"))
                    writer.uint32(/* id 5, wireType 0 =*/40).int32(message.type);
                if (message.content != null && Object.hasOwnProperty.call(message, "content"))
                    writer.uint32(/* id 6, wireType 2 =*/50).string(message.content);
                return writer;
            };
    
            /**
             * Encodes the specified PortableOperation message, length delimited. Does not implicitly {@link sheason_chat.PortableOperation.verify|verify} messages.
             * @function encodeDelimited
             * @memberof sheason_chat.PortableOperation
             * @static
             * @param {sheason_chat.IPortableOperation} message PortableOperation message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            PortableOperation.encodeDelimited = function encodeDelimited(message, writer) {
                return this.encode(message, writer).ldelim();
            };
    
            /**
             * Decodes a PortableOperation message from the specified reader or buffer.
             * @function decode
             * @memberof sheason_chat.PortableOperation
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @param {number} [length] Message length if known beforehand
             * @returns {sheason_chat.PortableOperation} PortableOperation
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            PortableOperation.decode = function decode(reader, length) {
                if (!(reader instanceof $Reader))
                    reader = $Reader.create(reader);
                var end = length === undefined ? reader.len : reader.pos + length, message = new $root.sheason_chat.PortableOperation();
                while (reader.pos < end) {
                    var tag = reader.uint32();
                    switch (tag >>> 3) {
                    case 1: {
                            message.clientId = reader.string();
                            break;
                        }
                    case 2: {
                            message.clock = reader.int32();
                            break;
                        }
                    case 5: {
                            message.type = reader.int32();
                            break;
                        }
                    case 6: {
                            message.content = reader.string();
                            break;
                        }
                    default:
                        reader.skipType(tag & 7);
                        break;
                    }
                }
                return message;
            };
    
            /**
             * Decodes a PortableOperation message from the specified reader or buffer, length delimited.
             * @function decodeDelimited
             * @memberof sheason_chat.PortableOperation
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @returns {sheason_chat.PortableOperation} PortableOperation
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            PortableOperation.decodeDelimited = function decodeDelimited(reader) {
                if (!(reader instanceof $Reader))
                    reader = new $Reader(reader);
                return this.decode(reader, reader.uint32());
            };
    
            /**
             * Verifies a PortableOperation message.
             * @function verify
             * @memberof sheason_chat.PortableOperation
             * @static
             * @param {Object.<string,*>} message Plain object to verify
             * @returns {string|null} `null` if valid, otherwise the reason why it is not
             */
            PortableOperation.verify = function verify(message) {
                if (typeof message !== "object" || message === null)
                    return "object expected";
                if (message.clientId != null && message.hasOwnProperty("clientId"))
                    if (!$util.isString(message.clientId))
                        return "clientId: string expected";
                if (message.clock != null && message.hasOwnProperty("clock"))
                    if (!$util.isInteger(message.clock))
                        return "clock: integer expected";
                if (message.type != null && message.hasOwnProperty("type"))
                    switch (message.type) {
                    default:
                        return "type: enum value expected";
                    case 0:
                    case 1:
                    case 2:
                    case 3:
                    case 4:
                    case 5:
                    case 6:
                    case 101:
                        break;
                    }
                if (message.content != null && message.hasOwnProperty("content"))
                    if (!$util.isString(message.content))
                        return "content: string expected";
                return null;
            };
    
            /**
             * Creates a PortableOperation message from a plain object. Also converts values to their respective internal types.
             * @function fromObject
             * @memberof sheason_chat.PortableOperation
             * @static
             * @param {Object.<string,*>} object Plain object
             * @returns {sheason_chat.PortableOperation} PortableOperation
             */
            PortableOperation.fromObject = function fromObject(object) {
                if (object instanceof $root.sheason_chat.PortableOperation)
                    return object;
                var message = new $root.sheason_chat.PortableOperation();
                if (object.clientId != null)
                    message.clientId = String(object.clientId);
                if (object.clock != null)
                    message.clock = object.clock | 0;
                switch (object.type) {
                default:
                    if (typeof object.type === "number") {
                        message.type = object.type;
                        break;
                    }
                    break;
                case "UNKNOWN_OPEARTION":
                case 0:
                    message.type = 0;
                    break;
                case "PUT_USERNAME":
                case 1:
                    message.type = 1;
                    break;
                case "PUT_SERVICE":
                case 2:
                    message.type = 2;
                    break;
                case "PUT_CONTACT":
                case 3:
                    message.type = 3;
                    break;
                case "PUT_CONVERSATION":
                case 4:
                    message.type = 4;
                    break;
                case "PUT_CONVERSATION_ANCHOR":
                case 5:
                    message.type = 5;
                    break;
                case "PUT_MESSAGE":
                case 6:
                    message.type = 6;
                    break;
                case "DELETE_SERVICE":
                case 101:
                    message.type = 101;
                    break;
                }
                if (object.content != null)
                    message.content = String(object.content);
                return message;
            };
    
            /**
             * Creates a plain object from a PortableOperation message. Also converts values to other types if specified.
             * @function toObject
             * @memberof sheason_chat.PortableOperation
             * @static
             * @param {sheason_chat.PortableOperation} message PortableOperation
             * @param {$protobuf.IConversionOptions} [options] Conversion options
             * @returns {Object.<string,*>} Plain object
             */
            PortableOperation.toObject = function toObject(message, options) {
                if (!options)
                    options = {};
                var object = {};
                if (options.defaults) {
                    object.clientId = "";
                    object.clock = 0;
                    object.type = options.enums === String ? "UNKNOWN_OPEARTION" : 0;
                    object.content = "";
                }
                if (message.clientId != null && message.hasOwnProperty("clientId"))
                    object.clientId = message.clientId;
                if (message.clock != null && message.hasOwnProperty("clock"))
                    object.clock = message.clock;
                if (message.type != null && message.hasOwnProperty("type"))
                    object.type = options.enums === String ? $root.sheason_chat.OperationType[message.type] === undefined ? message.type : $root.sheason_chat.OperationType[message.type] : message.type;
                if (message.content != null && message.hasOwnProperty("content"))
                    object.content = message.content;
                return object;
            };
    
            /**
             * Converts this PortableOperation to JSON.
             * @function toJSON
             * @memberof sheason_chat.PortableOperation
             * @instance
             * @returns {Object.<string,*>} JSON object
             */
            PortableOperation.prototype.toJSON = function toJSON() {
                return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
            };
    
            /**
             * Gets the default type url for PortableOperation
             * @function getTypeUrl
             * @memberof sheason_chat.PortableOperation
             * @static
             * @param {string} [typeUrlPrefix] your custom typeUrlPrefix(default "type.googleapis.com")
             * @returns {string} The default type url
             */
            PortableOperation.getTypeUrl = function getTypeUrl(typeUrlPrefix) {
                if (typeUrlPrefix === undefined) {
                    typeUrlPrefix = "type.googleapis.com";
                }
                return typeUrlPrefix + "/sheason_chat.PortableOperation";
            };
    
            return PortableOperation;
        })();
    
        /**
         * ConversationType enum.
         * @name sheason_chat.ConversationType
         * @enum {number}
         * @property {number} CONVERSATION_UNKNOWN=0 CONVERSATION_UNKNOWN value
         * @property {number} CONVERSATION_PRIVATE=1 CONVERSATION_PRIVATE value
         * @property {number} CONVERSATION_GROUP=2 CONVERSATION_GROUP value
         */
        sheason_chat.ConversationType = (function() {
            var valuesById = {}, values = Object.create(valuesById);
            values[valuesById[0] = "CONVERSATION_UNKNOWN"] = 0;
            values[valuesById[1] = "CONVERSATION_PRIVATE"] = 1;
            values[valuesById[2] = "CONVERSATION_GROUP"] = 2;
            return values;
        })();
    
        sheason_chat.PortableConversation = (function() {
    
            /**
             * Properties of a PortableConversation.
             * @memberof sheason_chat
             * @interface IPortableConversation
             * @property {sheason_chat.ConversationType|null} [type] PortableConversation type
             * @property {Array.<sheason_chat.IAccountSnapshot>|null} [members] PortableConversation members
             * @property {sheason_chat.IAccountSnapshot|null} [owner] PortableConversation owner
             * @property {string|null} [remoteUrl] PortableConversation remoteUrl
             * @property {Object.<string,Uint8Array>|null} [declaredSecrets] PortableConversation declaredSecrets
             * @property {sheason_chat.IAccountIndex|null} [agent] PortableConversation agent
             */
    
            /**
             * Constructs a new PortableConversation.
             * @memberof sheason_chat
             * @classdesc Represents a PortableConversation.
             * @implements IPortableConversation
             * @constructor
             * @param {sheason_chat.IPortableConversation=} [properties] Properties to set
             */
            function PortableConversation(properties) {
                this.members = [];
                this.declaredSecrets = {};
                if (properties)
                    for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                        if (properties[keys[i]] != null)
                            this[keys[i]] = properties[keys[i]];
            }
    
            /**
             * PortableConversation type.
             * @member {sheason_chat.ConversationType} type
             * @memberof sheason_chat.PortableConversation
             * @instance
             */
            PortableConversation.prototype.type = 0;
    
            /**
             * PortableConversation members.
             * @member {Array.<sheason_chat.IAccountSnapshot>} members
             * @memberof sheason_chat.PortableConversation
             * @instance
             */
            PortableConversation.prototype.members = $util.emptyArray;
    
            /**
             * PortableConversation owner.
             * @member {sheason_chat.IAccountSnapshot|null|undefined} owner
             * @memberof sheason_chat.PortableConversation
             * @instance
             */
            PortableConversation.prototype.owner = null;
    
            /**
             * PortableConversation remoteUrl.
             * @member {string} remoteUrl
             * @memberof sheason_chat.PortableConversation
             * @instance
             */
            PortableConversation.prototype.remoteUrl = "";
    
            /**
             * PortableConversation declaredSecrets.
             * @member {Object.<string,Uint8Array>} declaredSecrets
             * @memberof sheason_chat.PortableConversation
             * @instance
             */
            PortableConversation.prototype.declaredSecrets = $util.emptyObject;
    
            /**
             * PortableConversation agent.
             * @member {sheason_chat.IAccountIndex|null|undefined} agent
             * @memberof sheason_chat.PortableConversation
             * @instance
             */
            PortableConversation.prototype.agent = null;
    
            /**
             * Creates a new PortableConversation instance using the specified properties.
             * @function create
             * @memberof sheason_chat.PortableConversation
             * @static
             * @param {sheason_chat.IPortableConversation=} [properties] Properties to set
             * @returns {sheason_chat.PortableConversation} PortableConversation instance
             */
            PortableConversation.create = function create(properties) {
                return new PortableConversation(properties);
            };
    
            /**
             * Encodes the specified PortableConversation message. Does not implicitly {@link sheason_chat.PortableConversation.verify|verify} messages.
             * @function encode
             * @memberof sheason_chat.PortableConversation
             * @static
             * @param {sheason_chat.IPortableConversation} message PortableConversation message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            PortableConversation.encode = function encode(message, writer) {
                if (!writer)
                    writer = $Writer.create();
                if (message.type != null && Object.hasOwnProperty.call(message, "type"))
                    writer.uint32(/* id 1, wireType 0 =*/8).int32(message.type);
                if (message.members != null && message.members.length)
                    for (var i = 0; i < message.members.length; ++i)
                        $root.sheason_chat.AccountSnapshot.encode(message.members[i], writer.uint32(/* id 2, wireType 2 =*/18).fork()).ldelim();
                if (message.owner != null && Object.hasOwnProperty.call(message, "owner"))
                    $root.sheason_chat.AccountSnapshot.encode(message.owner, writer.uint32(/* id 3, wireType 2 =*/26).fork()).ldelim();
                if (message.remoteUrl != null && Object.hasOwnProperty.call(message, "remoteUrl"))
                    writer.uint32(/* id 4, wireType 2 =*/34).string(message.remoteUrl);
                if (message.declaredSecrets != null && Object.hasOwnProperty.call(message, "declaredSecrets"))
                    for (var keys = Object.keys(message.declaredSecrets), i = 0; i < keys.length; ++i)
                        writer.uint32(/* id 5, wireType 2 =*/42).fork().uint32(/* id 1, wireType 0 =*/8).int32(keys[i]).uint32(/* id 2, wireType 2 =*/18).bytes(message.declaredSecrets[keys[i]]).ldelim();
                if (message.agent != null && Object.hasOwnProperty.call(message, "agent"))
                    $root.sheason_chat.AccountIndex.encode(message.agent, writer.uint32(/* id 6, wireType 2 =*/50).fork()).ldelim();
                return writer;
            };
    
            /**
             * Encodes the specified PortableConversation message, length delimited. Does not implicitly {@link sheason_chat.PortableConversation.verify|verify} messages.
             * @function encodeDelimited
             * @memberof sheason_chat.PortableConversation
             * @static
             * @param {sheason_chat.IPortableConversation} message PortableConversation message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            PortableConversation.encodeDelimited = function encodeDelimited(message, writer) {
                return this.encode(message, writer).ldelim();
            };
    
            /**
             * Decodes a PortableConversation message from the specified reader or buffer.
             * @function decode
             * @memberof sheason_chat.PortableConversation
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @param {number} [length] Message length if known beforehand
             * @returns {sheason_chat.PortableConversation} PortableConversation
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            PortableConversation.decode = function decode(reader, length) {
                if (!(reader instanceof $Reader))
                    reader = $Reader.create(reader);
                var end = length === undefined ? reader.len : reader.pos + length, message = new $root.sheason_chat.PortableConversation(), key, value;
                while (reader.pos < end) {
                    var tag = reader.uint32();
                    switch (tag >>> 3) {
                    case 1: {
                            message.type = reader.int32();
                            break;
                        }
                    case 2: {
                            if (!(message.members && message.members.length))
                                message.members = [];
                            message.members.push($root.sheason_chat.AccountSnapshot.decode(reader, reader.uint32()));
                            break;
                        }
                    case 3: {
                            message.owner = $root.sheason_chat.AccountSnapshot.decode(reader, reader.uint32());
                            break;
                        }
                    case 4: {
                            message.remoteUrl = reader.string();
                            break;
                        }
                    case 5: {
                            if (message.declaredSecrets === $util.emptyObject)
                                message.declaredSecrets = {};
                            var end2 = reader.uint32() + reader.pos;
                            key = 0;
                            value = [];
                            while (reader.pos < end2) {
                                var tag2 = reader.uint32();
                                switch (tag2 >>> 3) {
                                case 1:
                                    key = reader.int32();
                                    break;
                                case 2:
                                    value = reader.bytes();
                                    break;
                                default:
                                    reader.skipType(tag2 & 7);
                                    break;
                                }
                            }
                            message.declaredSecrets[key] = value;
                            break;
                        }
                    case 6: {
                            message.agent = $root.sheason_chat.AccountIndex.decode(reader, reader.uint32());
                            break;
                        }
                    default:
                        reader.skipType(tag & 7);
                        break;
                    }
                }
                return message;
            };
    
            /**
             * Decodes a PortableConversation message from the specified reader or buffer, length delimited.
             * @function decodeDelimited
             * @memberof sheason_chat.PortableConversation
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @returns {sheason_chat.PortableConversation} PortableConversation
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            PortableConversation.decodeDelimited = function decodeDelimited(reader) {
                if (!(reader instanceof $Reader))
                    reader = new $Reader(reader);
                return this.decode(reader, reader.uint32());
            };
    
            /**
             * Verifies a PortableConversation message.
             * @function verify
             * @memberof sheason_chat.PortableConversation
             * @static
             * @param {Object.<string,*>} message Plain object to verify
             * @returns {string|null} `null` if valid, otherwise the reason why it is not
             */
            PortableConversation.verify = function verify(message) {
                if (typeof message !== "object" || message === null)
                    return "object expected";
                if (message.type != null && message.hasOwnProperty("type"))
                    switch (message.type) {
                    default:
                        return "type: enum value expected";
                    case 0:
                    case 1:
                    case 2:
                        break;
                    }
                if (message.members != null && message.hasOwnProperty("members")) {
                    if (!Array.isArray(message.members))
                        return "members: array expected";
                    for (var i = 0; i < message.members.length; ++i) {
                        var error = $root.sheason_chat.AccountSnapshot.verify(message.members[i]);
                        if (error)
                            return "members." + error;
                    }
                }
                if (message.owner != null && message.hasOwnProperty("owner")) {
                    var error = $root.sheason_chat.AccountSnapshot.verify(message.owner);
                    if (error)
                        return "owner." + error;
                }
                if (message.remoteUrl != null && message.hasOwnProperty("remoteUrl"))
                    if (!$util.isString(message.remoteUrl))
                        return "remoteUrl: string expected";
                if (message.declaredSecrets != null && message.hasOwnProperty("declaredSecrets")) {
                    if (!$util.isObject(message.declaredSecrets))
                        return "declaredSecrets: object expected";
                    var key = Object.keys(message.declaredSecrets);
                    for (var i = 0; i < key.length; ++i) {
                        if (!$util.key32Re.test(key[i]))
                            return "declaredSecrets: integer key{k:int32} expected";
                        if (!(message.declaredSecrets[key[i]] && typeof message.declaredSecrets[key[i]].length === "number" || $util.isString(message.declaredSecrets[key[i]])))
                            return "declaredSecrets: buffer{k:int32} expected";
                    }
                }
                if (message.agent != null && message.hasOwnProperty("agent")) {
                    var error = $root.sheason_chat.AccountIndex.verify(message.agent);
                    if (error)
                        return "agent." + error;
                }
                return null;
            };
    
            /**
             * Creates a PortableConversation message from a plain object. Also converts values to their respective internal types.
             * @function fromObject
             * @memberof sheason_chat.PortableConversation
             * @static
             * @param {Object.<string,*>} object Plain object
             * @returns {sheason_chat.PortableConversation} PortableConversation
             */
            PortableConversation.fromObject = function fromObject(object) {
                if (object instanceof $root.sheason_chat.PortableConversation)
                    return object;
                var message = new $root.sheason_chat.PortableConversation();
                switch (object.type) {
                default:
                    if (typeof object.type === "number") {
                        message.type = object.type;
                        break;
                    }
                    break;
                case "CONVERSATION_UNKNOWN":
                case 0:
                    message.type = 0;
                    break;
                case "CONVERSATION_PRIVATE":
                case 1:
                    message.type = 1;
                    break;
                case "CONVERSATION_GROUP":
                case 2:
                    message.type = 2;
                    break;
                }
                if (object.members) {
                    if (!Array.isArray(object.members))
                        throw TypeError(".sheason_chat.PortableConversation.members: array expected");
                    message.members = [];
                    for (var i = 0; i < object.members.length; ++i) {
                        if (typeof object.members[i] !== "object")
                            throw TypeError(".sheason_chat.PortableConversation.members: object expected");
                        message.members[i] = $root.sheason_chat.AccountSnapshot.fromObject(object.members[i]);
                    }
                }
                if (object.owner != null) {
                    if (typeof object.owner !== "object")
                        throw TypeError(".sheason_chat.PortableConversation.owner: object expected");
                    message.owner = $root.sheason_chat.AccountSnapshot.fromObject(object.owner);
                }
                if (object.remoteUrl != null)
                    message.remoteUrl = String(object.remoteUrl);
                if (object.declaredSecrets) {
                    if (typeof object.declaredSecrets !== "object")
                        throw TypeError(".sheason_chat.PortableConversation.declaredSecrets: object expected");
                    message.declaredSecrets = {};
                    for (var keys = Object.keys(object.declaredSecrets), i = 0; i < keys.length; ++i)
                        if (typeof object.declaredSecrets[keys[i]] === "string")
                            $util.base64.decode(object.declaredSecrets[keys[i]], message.declaredSecrets[keys[i]] = $util.newBuffer($util.base64.length(object.declaredSecrets[keys[i]])), 0);
                        else if (object.declaredSecrets[keys[i]].length >= 0)
                            message.declaredSecrets[keys[i]] = object.declaredSecrets[keys[i]];
                }
                if (object.agent != null) {
                    if (typeof object.agent !== "object")
                        throw TypeError(".sheason_chat.PortableConversation.agent: object expected");
                    message.agent = $root.sheason_chat.AccountIndex.fromObject(object.agent);
                }
                return message;
            };
    
            /**
             * Creates a plain object from a PortableConversation message. Also converts values to other types if specified.
             * @function toObject
             * @memberof sheason_chat.PortableConversation
             * @static
             * @param {sheason_chat.PortableConversation} message PortableConversation
             * @param {$protobuf.IConversionOptions} [options] Conversion options
             * @returns {Object.<string,*>} Plain object
             */
            PortableConversation.toObject = function toObject(message, options) {
                if (!options)
                    options = {};
                var object = {};
                if (options.arrays || options.defaults)
                    object.members = [];
                if (options.objects || options.defaults)
                    object.declaredSecrets = {};
                if (options.defaults) {
                    object.type = options.enums === String ? "CONVERSATION_UNKNOWN" : 0;
                    object.owner = null;
                    object.remoteUrl = "";
                    object.agent = null;
                }
                if (message.type != null && message.hasOwnProperty("type"))
                    object.type = options.enums === String ? $root.sheason_chat.ConversationType[message.type] === undefined ? message.type : $root.sheason_chat.ConversationType[message.type] : message.type;
                if (message.members && message.members.length) {
                    object.members = [];
                    for (var j = 0; j < message.members.length; ++j)
                        object.members[j] = $root.sheason_chat.AccountSnapshot.toObject(message.members[j], options);
                }
                if (message.owner != null && message.hasOwnProperty("owner"))
                    object.owner = $root.sheason_chat.AccountSnapshot.toObject(message.owner, options);
                if (message.remoteUrl != null && message.hasOwnProperty("remoteUrl"))
                    object.remoteUrl = message.remoteUrl;
                var keys2;
                if (message.declaredSecrets && (keys2 = Object.keys(message.declaredSecrets)).length) {
                    object.declaredSecrets = {};
                    for (var j = 0; j < keys2.length; ++j)
                        object.declaredSecrets[keys2[j]] = options.bytes === String ? $util.base64.encode(message.declaredSecrets[keys2[j]], 0, message.declaredSecrets[keys2[j]].length) : options.bytes === Array ? Array.prototype.slice.call(message.declaredSecrets[keys2[j]]) : message.declaredSecrets[keys2[j]];
                }
                if (message.agent != null && message.hasOwnProperty("agent"))
                    object.agent = $root.sheason_chat.AccountIndex.toObject(message.agent, options);
                return object;
            };
    
            /**
             * Converts this PortableConversation to JSON.
             * @function toJSON
             * @memberof sheason_chat.PortableConversation
             * @instance
             * @returns {Object.<string,*>} JSON object
             */
            PortableConversation.prototype.toJSON = function toJSON() {
                return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
            };
    
            /**
             * Gets the default type url for PortableConversation
             * @function getTypeUrl
             * @memberof sheason_chat.PortableConversation
             * @static
             * @param {string} [typeUrlPrefix] your custom typeUrlPrefix(default "type.googleapis.com")
             * @returns {string} The default type url
             */
            PortableConversation.getTypeUrl = function getTypeUrl(typeUrlPrefix) {
                if (typeUrlPrefix === undefined) {
                    typeUrlPrefix = "type.googleapis.com";
                }
                return typeUrlPrefix + "/sheason_chat.PortableConversation";
            };
    
            return PortableConversation;
        })();
    
        /**
         * MessageType enum.
         * @name sheason_chat.MessageType
         * @enum {number}
         * @property {number} MESSAGE_TYPE_UNKNOWN=0 MESSAGE_TYPE_UNKNOWN value
         * @property {number} MESSAGE_TYPE_TEXT=1 MESSAGE_TYPE_TEXT value
         * @property {number} MESSAGE_TYPE_AUDIO=2 MESSAGE_TYPE_AUDIO value
         * @property {number} MESSAGE_TYPE_IMAGE=3 MESSAGE_TYPE_IMAGE value
         * @property {number} MESSAGE_TYPE_VIDEO=4 MESSAGE_TYPE_VIDEO value
         * @property {number} MESSAGE_TYPE_FILE=5 MESSAGE_TYPE_FILE value
         * @property {number} MESSAGE_TYPE_STATE_ONLY=101 MESSAGE_TYPE_STATE_ONLY value
         */
        sheason_chat.MessageType = (function() {
            var valuesById = {}, values = Object.create(valuesById);
            values[valuesById[0] = "MESSAGE_TYPE_UNKNOWN"] = 0;
            values[valuesById[1] = "MESSAGE_TYPE_TEXT"] = 1;
            values[valuesById[2] = "MESSAGE_TYPE_AUDIO"] = 2;
            values[valuesById[3] = "MESSAGE_TYPE_IMAGE"] = 3;
            values[valuesById[4] = "MESSAGE_TYPE_VIDEO"] = 4;
            values[valuesById[5] = "MESSAGE_TYPE_FILE"] = 5;
            values[valuesById[101] = "MESSAGE_TYPE_STATE_ONLY"] = 101;
            return values;
        })();
    
        sheason_chat.PortableMessage = (function() {
    
            /**
             * Properties of a PortableMessage.
             * @memberof sheason_chat
             * @interface IPortableMessage
             * @property {string|null} [uuid] PortableMessage uuid
             * @property {sheason_chat.MessageType|null} [messageType] PortableMessage messageType
             * @property {string|null} [content] PortableMessage content
             * @property {sheason_chat.IAccountSnapshot|null} [sender] PortableMessage sender
             * @property {sheason_chat.IPortableConversation|null} [conversation] PortableMessage conversation
             * @property {Array.<sheason_chat.IPortableMessageState>|null} [messageStates] PortableMessage messageStates
             * @property {number|Long|null} [createdAt] PortableMessage createdAt
             */
    
            /**
             * Constructs a new PortableMessage.
             * @memberof sheason_chat
             * @classdesc Represents a PortableMessage.
             * @implements IPortableMessage
             * @constructor
             * @param {sheason_chat.IPortableMessage=} [properties] Properties to set
             */
            function PortableMessage(properties) {
                this.messageStates = [];
                if (properties)
                    for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                        if (properties[keys[i]] != null)
                            this[keys[i]] = properties[keys[i]];
            }
    
            /**
             * PortableMessage uuid.
             * @member {string} uuid
             * @memberof sheason_chat.PortableMessage
             * @instance
             */
            PortableMessage.prototype.uuid = "";
    
            /**
             * PortableMessage messageType.
             * @member {sheason_chat.MessageType} messageType
             * @memberof sheason_chat.PortableMessage
             * @instance
             */
            PortableMessage.prototype.messageType = 0;
    
            /**
             * PortableMessage content.
             * @member {string} content
             * @memberof sheason_chat.PortableMessage
             * @instance
             */
            PortableMessage.prototype.content = "";
    
            /**
             * PortableMessage sender.
             * @member {sheason_chat.IAccountSnapshot|null|undefined} sender
             * @memberof sheason_chat.PortableMessage
             * @instance
             */
            PortableMessage.prototype.sender = null;
    
            /**
             * PortableMessage conversation.
             * @member {sheason_chat.IPortableConversation|null|undefined} conversation
             * @memberof sheason_chat.PortableMessage
             * @instance
             */
            PortableMessage.prototype.conversation = null;
    
            /**
             * PortableMessage messageStates.
             * @member {Array.<sheason_chat.IPortableMessageState>} messageStates
             * @memberof sheason_chat.PortableMessage
             * @instance
             */
            PortableMessage.prototype.messageStates = $util.emptyArray;
    
            /**
             * PortableMessage createdAt.
             * @member {number|Long} createdAt
             * @memberof sheason_chat.PortableMessage
             * @instance
             */
            PortableMessage.prototype.createdAt = $util.Long ? $util.Long.fromBits(0,0,false) : 0;
    
            /**
             * Creates a new PortableMessage instance using the specified properties.
             * @function create
             * @memberof sheason_chat.PortableMessage
             * @static
             * @param {sheason_chat.IPortableMessage=} [properties] Properties to set
             * @returns {sheason_chat.PortableMessage} PortableMessage instance
             */
            PortableMessage.create = function create(properties) {
                return new PortableMessage(properties);
            };
    
            /**
             * Encodes the specified PortableMessage message. Does not implicitly {@link sheason_chat.PortableMessage.verify|verify} messages.
             * @function encode
             * @memberof sheason_chat.PortableMessage
             * @static
             * @param {sheason_chat.IPortableMessage} message PortableMessage message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            PortableMessage.encode = function encode(message, writer) {
                if (!writer)
                    writer = $Writer.create();
                if (message.uuid != null && Object.hasOwnProperty.call(message, "uuid"))
                    writer.uint32(/* id 1, wireType 2 =*/10).string(message.uuid);
                if (message.messageType != null && Object.hasOwnProperty.call(message, "messageType"))
                    writer.uint32(/* id 2, wireType 0 =*/16).int32(message.messageType);
                if (message.content != null && Object.hasOwnProperty.call(message, "content"))
                    writer.uint32(/* id 3, wireType 2 =*/26).string(message.content);
                if (message.sender != null && Object.hasOwnProperty.call(message, "sender"))
                    $root.sheason_chat.AccountSnapshot.encode(message.sender, writer.uint32(/* id 4, wireType 2 =*/34).fork()).ldelim();
                if (message.conversation != null && Object.hasOwnProperty.call(message, "conversation"))
                    $root.sheason_chat.PortableConversation.encode(message.conversation, writer.uint32(/* id 5, wireType 2 =*/42).fork()).ldelim();
                if (message.messageStates != null && message.messageStates.length)
                    for (var i = 0; i < message.messageStates.length; ++i)
                        $root.sheason_chat.PortableMessageState.encode(message.messageStates[i], writer.uint32(/* id 6, wireType 2 =*/50).fork()).ldelim();
                if (message.createdAt != null && Object.hasOwnProperty.call(message, "createdAt"))
                    writer.uint32(/* id 7, wireType 0 =*/56).int64(message.createdAt);
                return writer;
            };
    
            /**
             * Encodes the specified PortableMessage message, length delimited. Does not implicitly {@link sheason_chat.PortableMessage.verify|verify} messages.
             * @function encodeDelimited
             * @memberof sheason_chat.PortableMessage
             * @static
             * @param {sheason_chat.IPortableMessage} message PortableMessage message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            PortableMessage.encodeDelimited = function encodeDelimited(message, writer) {
                return this.encode(message, writer).ldelim();
            };
    
            /**
             * Decodes a PortableMessage message from the specified reader or buffer.
             * @function decode
             * @memberof sheason_chat.PortableMessage
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @param {number} [length] Message length if known beforehand
             * @returns {sheason_chat.PortableMessage} PortableMessage
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            PortableMessage.decode = function decode(reader, length) {
                if (!(reader instanceof $Reader))
                    reader = $Reader.create(reader);
                var end = length === undefined ? reader.len : reader.pos + length, message = new $root.sheason_chat.PortableMessage();
                while (reader.pos < end) {
                    var tag = reader.uint32();
                    switch (tag >>> 3) {
                    case 1: {
                            message.uuid = reader.string();
                            break;
                        }
                    case 2: {
                            message.messageType = reader.int32();
                            break;
                        }
                    case 3: {
                            message.content = reader.string();
                            break;
                        }
                    case 4: {
                            message.sender = $root.sheason_chat.AccountSnapshot.decode(reader, reader.uint32());
                            break;
                        }
                    case 5: {
                            message.conversation = $root.sheason_chat.PortableConversation.decode(reader, reader.uint32());
                            break;
                        }
                    case 6: {
                            if (!(message.messageStates && message.messageStates.length))
                                message.messageStates = [];
                            message.messageStates.push($root.sheason_chat.PortableMessageState.decode(reader, reader.uint32()));
                            break;
                        }
                    case 7: {
                            message.createdAt = reader.int64();
                            break;
                        }
                    default:
                        reader.skipType(tag & 7);
                        break;
                    }
                }
                return message;
            };
    
            /**
             * Decodes a PortableMessage message from the specified reader or buffer, length delimited.
             * @function decodeDelimited
             * @memberof sheason_chat.PortableMessage
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @returns {sheason_chat.PortableMessage} PortableMessage
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            PortableMessage.decodeDelimited = function decodeDelimited(reader) {
                if (!(reader instanceof $Reader))
                    reader = new $Reader(reader);
                return this.decode(reader, reader.uint32());
            };
    
            /**
             * Verifies a PortableMessage message.
             * @function verify
             * @memberof sheason_chat.PortableMessage
             * @static
             * @param {Object.<string,*>} message Plain object to verify
             * @returns {string|null} `null` if valid, otherwise the reason why it is not
             */
            PortableMessage.verify = function verify(message) {
                if (typeof message !== "object" || message === null)
                    return "object expected";
                if (message.uuid != null && message.hasOwnProperty("uuid"))
                    if (!$util.isString(message.uuid))
                        return "uuid: string expected";
                if (message.messageType != null && message.hasOwnProperty("messageType"))
                    switch (message.messageType) {
                    default:
                        return "messageType: enum value expected";
                    case 0:
                    case 1:
                    case 2:
                    case 3:
                    case 4:
                    case 5:
                    case 101:
                        break;
                    }
                if (message.content != null && message.hasOwnProperty("content"))
                    if (!$util.isString(message.content))
                        return "content: string expected";
                if (message.sender != null && message.hasOwnProperty("sender")) {
                    var error = $root.sheason_chat.AccountSnapshot.verify(message.sender);
                    if (error)
                        return "sender." + error;
                }
                if (message.conversation != null && message.hasOwnProperty("conversation")) {
                    var error = $root.sheason_chat.PortableConversation.verify(message.conversation);
                    if (error)
                        return "conversation." + error;
                }
                if (message.messageStates != null && message.hasOwnProperty("messageStates")) {
                    if (!Array.isArray(message.messageStates))
                        return "messageStates: array expected";
                    for (var i = 0; i < message.messageStates.length; ++i) {
                        var error = $root.sheason_chat.PortableMessageState.verify(message.messageStates[i]);
                        if (error)
                            return "messageStates." + error;
                    }
                }
                if (message.createdAt != null && message.hasOwnProperty("createdAt"))
                    if (!$util.isInteger(message.createdAt) && !(message.createdAt && $util.isInteger(message.createdAt.low) && $util.isInteger(message.createdAt.high)))
                        return "createdAt: integer|Long expected";
                return null;
            };
    
            /**
             * Creates a PortableMessage message from a plain object. Also converts values to their respective internal types.
             * @function fromObject
             * @memberof sheason_chat.PortableMessage
             * @static
             * @param {Object.<string,*>} object Plain object
             * @returns {sheason_chat.PortableMessage} PortableMessage
             */
            PortableMessage.fromObject = function fromObject(object) {
                if (object instanceof $root.sheason_chat.PortableMessage)
                    return object;
                var message = new $root.sheason_chat.PortableMessage();
                if (object.uuid != null)
                    message.uuid = String(object.uuid);
                switch (object.messageType) {
                default:
                    if (typeof object.messageType === "number") {
                        message.messageType = object.messageType;
                        break;
                    }
                    break;
                case "MESSAGE_TYPE_UNKNOWN":
                case 0:
                    message.messageType = 0;
                    break;
                case "MESSAGE_TYPE_TEXT":
                case 1:
                    message.messageType = 1;
                    break;
                case "MESSAGE_TYPE_AUDIO":
                case 2:
                    message.messageType = 2;
                    break;
                case "MESSAGE_TYPE_IMAGE":
                case 3:
                    message.messageType = 3;
                    break;
                case "MESSAGE_TYPE_VIDEO":
                case 4:
                    message.messageType = 4;
                    break;
                case "MESSAGE_TYPE_FILE":
                case 5:
                    message.messageType = 5;
                    break;
                case "MESSAGE_TYPE_STATE_ONLY":
                case 101:
                    message.messageType = 101;
                    break;
                }
                if (object.content != null)
                    message.content = String(object.content);
                if (object.sender != null) {
                    if (typeof object.sender !== "object")
                        throw TypeError(".sheason_chat.PortableMessage.sender: object expected");
                    message.sender = $root.sheason_chat.AccountSnapshot.fromObject(object.sender);
                }
                if (object.conversation != null) {
                    if (typeof object.conversation !== "object")
                        throw TypeError(".sheason_chat.PortableMessage.conversation: object expected");
                    message.conversation = $root.sheason_chat.PortableConversation.fromObject(object.conversation);
                }
                if (object.messageStates) {
                    if (!Array.isArray(object.messageStates))
                        throw TypeError(".sheason_chat.PortableMessage.messageStates: array expected");
                    message.messageStates = [];
                    for (var i = 0; i < object.messageStates.length; ++i) {
                        if (typeof object.messageStates[i] !== "object")
                            throw TypeError(".sheason_chat.PortableMessage.messageStates: object expected");
                        message.messageStates[i] = $root.sheason_chat.PortableMessageState.fromObject(object.messageStates[i]);
                    }
                }
                if (object.createdAt != null)
                    if ($util.Long)
                        (message.createdAt = $util.Long.fromValue(object.createdAt)).unsigned = false;
                    else if (typeof object.createdAt === "string")
                        message.createdAt = parseInt(object.createdAt, 10);
                    else if (typeof object.createdAt === "number")
                        message.createdAt = object.createdAt;
                    else if (typeof object.createdAt === "object")
                        message.createdAt = new $util.LongBits(object.createdAt.low >>> 0, object.createdAt.high >>> 0).toNumber();
                return message;
            };
    
            /**
             * Creates a plain object from a PortableMessage message. Also converts values to other types if specified.
             * @function toObject
             * @memberof sheason_chat.PortableMessage
             * @static
             * @param {sheason_chat.PortableMessage} message PortableMessage
             * @param {$protobuf.IConversionOptions} [options] Conversion options
             * @returns {Object.<string,*>} Plain object
             */
            PortableMessage.toObject = function toObject(message, options) {
                if (!options)
                    options = {};
                var object = {};
                if (options.arrays || options.defaults)
                    object.messageStates = [];
                if (options.defaults) {
                    object.uuid = "";
                    object.messageType = options.enums === String ? "MESSAGE_TYPE_UNKNOWN" : 0;
                    object.content = "";
                    object.sender = null;
                    object.conversation = null;
                    if ($util.Long) {
                        var long = new $util.Long(0, 0, false);
                        object.createdAt = options.longs === String ? long.toString() : options.longs === Number ? long.toNumber() : long;
                    } else
                        object.createdAt = options.longs === String ? "0" : 0;
                }
                if (message.uuid != null && message.hasOwnProperty("uuid"))
                    object.uuid = message.uuid;
                if (message.messageType != null && message.hasOwnProperty("messageType"))
                    object.messageType = options.enums === String ? $root.sheason_chat.MessageType[message.messageType] === undefined ? message.messageType : $root.sheason_chat.MessageType[message.messageType] : message.messageType;
                if (message.content != null && message.hasOwnProperty("content"))
                    object.content = message.content;
                if (message.sender != null && message.hasOwnProperty("sender"))
                    object.sender = $root.sheason_chat.AccountSnapshot.toObject(message.sender, options);
                if (message.conversation != null && message.hasOwnProperty("conversation"))
                    object.conversation = $root.sheason_chat.PortableConversation.toObject(message.conversation, options);
                if (message.messageStates && message.messageStates.length) {
                    object.messageStates = [];
                    for (var j = 0; j < message.messageStates.length; ++j)
                        object.messageStates[j] = $root.sheason_chat.PortableMessageState.toObject(message.messageStates[j], options);
                }
                if (message.createdAt != null && message.hasOwnProperty("createdAt"))
                    if (typeof message.createdAt === "number")
                        object.createdAt = options.longs === String ? String(message.createdAt) : message.createdAt;
                    else
                        object.createdAt = options.longs === String ? $util.Long.prototype.toString.call(message.createdAt) : options.longs === Number ? new $util.LongBits(message.createdAt.low >>> 0, message.createdAt.high >>> 0).toNumber() : message.createdAt;
                return object;
            };
    
            /**
             * Converts this PortableMessage to JSON.
             * @function toJSON
             * @memberof sheason_chat.PortableMessage
             * @instance
             * @returns {Object.<string,*>} JSON object
             */
            PortableMessage.prototype.toJSON = function toJSON() {
                return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
            };
    
            /**
             * Gets the default type url for PortableMessage
             * @function getTypeUrl
             * @memberof sheason_chat.PortableMessage
             * @static
             * @param {string} [typeUrlPrefix] your custom typeUrlPrefix(default "type.googleapis.com")
             * @returns {string} The default type url
             */
            PortableMessage.getTypeUrl = function getTypeUrl(typeUrlPrefix) {
                if (typeUrlPrefix === undefined) {
                    typeUrlPrefix = "type.googleapis.com";
                }
                return typeUrlPrefix + "/sheason_chat.PortableMessage";
            };
    
            return PortableMessage;
        })();
    
        sheason_chat.PortableMessageState = (function() {
    
            /**
             * Properties of a PortableMessageState.
             * @memberof sheason_chat
             * @interface IPortableMessageState
             * @property {sheason_chat.IAccountIndex|null} [accountIndex] PortableMessageState accountIndex
             * @property {number|Long|null} [createdAt] PortableMessageState createdAt
             * @property {number|Long|null} [receiveAt] PortableMessageState receiveAt
             * @property {number|Long|null} [checkedAt] PortableMessageState checkedAt
             */
    
            /**
             * Constructs a new PortableMessageState.
             * @memberof sheason_chat
             * @classdesc Represents a PortableMessageState.
             * @implements IPortableMessageState
             * @constructor
             * @param {sheason_chat.IPortableMessageState=} [properties] Properties to set
             */
            function PortableMessageState(properties) {
                if (properties)
                    for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                        if (properties[keys[i]] != null)
                            this[keys[i]] = properties[keys[i]];
            }
    
            /**
             * PortableMessageState accountIndex.
             * @member {sheason_chat.IAccountIndex|null|undefined} accountIndex
             * @memberof sheason_chat.PortableMessageState
             * @instance
             */
            PortableMessageState.prototype.accountIndex = null;
    
            /**
             * PortableMessageState createdAt.
             * @member {number|Long} createdAt
             * @memberof sheason_chat.PortableMessageState
             * @instance
             */
            PortableMessageState.prototype.createdAt = $util.Long ? $util.Long.fromBits(0,0,false) : 0;
    
            /**
             * PortableMessageState receiveAt.
             * @member {number|Long} receiveAt
             * @memberof sheason_chat.PortableMessageState
             * @instance
             */
            PortableMessageState.prototype.receiveAt = $util.Long ? $util.Long.fromBits(0,0,false) : 0;
    
            /**
             * PortableMessageState checkedAt.
             * @member {number|Long} checkedAt
             * @memberof sheason_chat.PortableMessageState
             * @instance
             */
            PortableMessageState.prototype.checkedAt = $util.Long ? $util.Long.fromBits(0,0,false) : 0;
    
            /**
             * Creates a new PortableMessageState instance using the specified properties.
             * @function create
             * @memberof sheason_chat.PortableMessageState
             * @static
             * @param {sheason_chat.IPortableMessageState=} [properties] Properties to set
             * @returns {sheason_chat.PortableMessageState} PortableMessageState instance
             */
            PortableMessageState.create = function create(properties) {
                return new PortableMessageState(properties);
            };
    
            /**
             * Encodes the specified PortableMessageState message. Does not implicitly {@link sheason_chat.PortableMessageState.verify|verify} messages.
             * @function encode
             * @memberof sheason_chat.PortableMessageState
             * @static
             * @param {sheason_chat.IPortableMessageState} message PortableMessageState message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            PortableMessageState.encode = function encode(message, writer) {
                if (!writer)
                    writer = $Writer.create();
                if (message.accountIndex != null && Object.hasOwnProperty.call(message, "accountIndex"))
                    $root.sheason_chat.AccountIndex.encode(message.accountIndex, writer.uint32(/* id 1, wireType 2 =*/10).fork()).ldelim();
                if (message.createdAt != null && Object.hasOwnProperty.call(message, "createdAt"))
                    writer.uint32(/* id 2, wireType 0 =*/16).int64(message.createdAt);
                if (message.receiveAt != null && Object.hasOwnProperty.call(message, "receiveAt"))
                    writer.uint32(/* id 3, wireType 0 =*/24).int64(message.receiveAt);
                if (message.checkedAt != null && Object.hasOwnProperty.call(message, "checkedAt"))
                    writer.uint32(/* id 4, wireType 0 =*/32).int64(message.checkedAt);
                return writer;
            };
    
            /**
             * Encodes the specified PortableMessageState message, length delimited. Does not implicitly {@link sheason_chat.PortableMessageState.verify|verify} messages.
             * @function encodeDelimited
             * @memberof sheason_chat.PortableMessageState
             * @static
             * @param {sheason_chat.IPortableMessageState} message PortableMessageState message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            PortableMessageState.encodeDelimited = function encodeDelimited(message, writer) {
                return this.encode(message, writer).ldelim();
            };
    
            /**
             * Decodes a PortableMessageState message from the specified reader or buffer.
             * @function decode
             * @memberof sheason_chat.PortableMessageState
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @param {number} [length] Message length if known beforehand
             * @returns {sheason_chat.PortableMessageState} PortableMessageState
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            PortableMessageState.decode = function decode(reader, length) {
                if (!(reader instanceof $Reader))
                    reader = $Reader.create(reader);
                var end = length === undefined ? reader.len : reader.pos + length, message = new $root.sheason_chat.PortableMessageState();
                while (reader.pos < end) {
                    var tag = reader.uint32();
                    switch (tag >>> 3) {
                    case 1: {
                            message.accountIndex = $root.sheason_chat.AccountIndex.decode(reader, reader.uint32());
                            break;
                        }
                    case 2: {
                            message.createdAt = reader.int64();
                            break;
                        }
                    case 3: {
                            message.receiveAt = reader.int64();
                            break;
                        }
                    case 4: {
                            message.checkedAt = reader.int64();
                            break;
                        }
                    default:
                        reader.skipType(tag & 7);
                        break;
                    }
                }
                return message;
            };
    
            /**
             * Decodes a PortableMessageState message from the specified reader or buffer, length delimited.
             * @function decodeDelimited
             * @memberof sheason_chat.PortableMessageState
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @returns {sheason_chat.PortableMessageState} PortableMessageState
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            PortableMessageState.decodeDelimited = function decodeDelimited(reader) {
                if (!(reader instanceof $Reader))
                    reader = new $Reader(reader);
                return this.decode(reader, reader.uint32());
            };
    
            /**
             * Verifies a PortableMessageState message.
             * @function verify
             * @memberof sheason_chat.PortableMessageState
             * @static
             * @param {Object.<string,*>} message Plain object to verify
             * @returns {string|null} `null` if valid, otherwise the reason why it is not
             */
            PortableMessageState.verify = function verify(message) {
                if (typeof message !== "object" || message === null)
                    return "object expected";
                if (message.accountIndex != null && message.hasOwnProperty("accountIndex")) {
                    var error = $root.sheason_chat.AccountIndex.verify(message.accountIndex);
                    if (error)
                        return "accountIndex." + error;
                }
                if (message.createdAt != null && message.hasOwnProperty("createdAt"))
                    if (!$util.isInteger(message.createdAt) && !(message.createdAt && $util.isInteger(message.createdAt.low) && $util.isInteger(message.createdAt.high)))
                        return "createdAt: integer|Long expected";
                if (message.receiveAt != null && message.hasOwnProperty("receiveAt"))
                    if (!$util.isInteger(message.receiveAt) && !(message.receiveAt && $util.isInteger(message.receiveAt.low) && $util.isInteger(message.receiveAt.high)))
                        return "receiveAt: integer|Long expected";
                if (message.checkedAt != null && message.hasOwnProperty("checkedAt"))
                    if (!$util.isInteger(message.checkedAt) && !(message.checkedAt && $util.isInteger(message.checkedAt.low) && $util.isInteger(message.checkedAt.high)))
                        return "checkedAt: integer|Long expected";
                return null;
            };
    
            /**
             * Creates a PortableMessageState message from a plain object. Also converts values to their respective internal types.
             * @function fromObject
             * @memberof sheason_chat.PortableMessageState
             * @static
             * @param {Object.<string,*>} object Plain object
             * @returns {sheason_chat.PortableMessageState} PortableMessageState
             */
            PortableMessageState.fromObject = function fromObject(object) {
                if (object instanceof $root.sheason_chat.PortableMessageState)
                    return object;
                var message = new $root.sheason_chat.PortableMessageState();
                if (object.accountIndex != null) {
                    if (typeof object.accountIndex !== "object")
                        throw TypeError(".sheason_chat.PortableMessageState.accountIndex: object expected");
                    message.accountIndex = $root.sheason_chat.AccountIndex.fromObject(object.accountIndex);
                }
                if (object.createdAt != null)
                    if ($util.Long)
                        (message.createdAt = $util.Long.fromValue(object.createdAt)).unsigned = false;
                    else if (typeof object.createdAt === "string")
                        message.createdAt = parseInt(object.createdAt, 10);
                    else if (typeof object.createdAt === "number")
                        message.createdAt = object.createdAt;
                    else if (typeof object.createdAt === "object")
                        message.createdAt = new $util.LongBits(object.createdAt.low >>> 0, object.createdAt.high >>> 0).toNumber();
                if (object.receiveAt != null)
                    if ($util.Long)
                        (message.receiveAt = $util.Long.fromValue(object.receiveAt)).unsigned = false;
                    else if (typeof object.receiveAt === "string")
                        message.receiveAt = parseInt(object.receiveAt, 10);
                    else if (typeof object.receiveAt === "number")
                        message.receiveAt = object.receiveAt;
                    else if (typeof object.receiveAt === "object")
                        message.receiveAt = new $util.LongBits(object.receiveAt.low >>> 0, object.receiveAt.high >>> 0).toNumber();
                if (object.checkedAt != null)
                    if ($util.Long)
                        (message.checkedAt = $util.Long.fromValue(object.checkedAt)).unsigned = false;
                    else if (typeof object.checkedAt === "string")
                        message.checkedAt = parseInt(object.checkedAt, 10);
                    else if (typeof object.checkedAt === "number")
                        message.checkedAt = object.checkedAt;
                    else if (typeof object.checkedAt === "object")
                        message.checkedAt = new $util.LongBits(object.checkedAt.low >>> 0, object.checkedAt.high >>> 0).toNumber();
                return message;
            };
    
            /**
             * Creates a plain object from a PortableMessageState message. Also converts values to other types if specified.
             * @function toObject
             * @memberof sheason_chat.PortableMessageState
             * @static
             * @param {sheason_chat.PortableMessageState} message PortableMessageState
             * @param {$protobuf.IConversionOptions} [options] Conversion options
             * @returns {Object.<string,*>} Plain object
             */
            PortableMessageState.toObject = function toObject(message, options) {
                if (!options)
                    options = {};
                var object = {};
                if (options.defaults) {
                    object.accountIndex = null;
                    if ($util.Long) {
                        var long = new $util.Long(0, 0, false);
                        object.createdAt = options.longs === String ? long.toString() : options.longs === Number ? long.toNumber() : long;
                    } else
                        object.createdAt = options.longs === String ? "0" : 0;
                    if ($util.Long) {
                        var long = new $util.Long(0, 0, false);
                        object.receiveAt = options.longs === String ? long.toString() : options.longs === Number ? long.toNumber() : long;
                    } else
                        object.receiveAt = options.longs === String ? "0" : 0;
                    if ($util.Long) {
                        var long = new $util.Long(0, 0, false);
                        object.checkedAt = options.longs === String ? long.toString() : options.longs === Number ? long.toNumber() : long;
                    } else
                        object.checkedAt = options.longs === String ? "0" : 0;
                }
                if (message.accountIndex != null && message.hasOwnProperty("accountIndex"))
                    object.accountIndex = $root.sheason_chat.AccountIndex.toObject(message.accountIndex, options);
                if (message.createdAt != null && message.hasOwnProperty("createdAt"))
                    if (typeof message.createdAt === "number")
                        object.createdAt = options.longs === String ? String(message.createdAt) : message.createdAt;
                    else
                        object.createdAt = options.longs === String ? $util.Long.prototype.toString.call(message.createdAt) : options.longs === Number ? new $util.LongBits(message.createdAt.low >>> 0, message.createdAt.high >>> 0).toNumber() : message.createdAt;
                if (message.receiveAt != null && message.hasOwnProperty("receiveAt"))
                    if (typeof message.receiveAt === "number")
                        object.receiveAt = options.longs === String ? String(message.receiveAt) : message.receiveAt;
                    else
                        object.receiveAt = options.longs === String ? $util.Long.prototype.toString.call(message.receiveAt) : options.longs === Number ? new $util.LongBits(message.receiveAt.low >>> 0, message.receiveAt.high >>> 0).toNumber() : message.receiveAt;
                if (message.checkedAt != null && message.hasOwnProperty("checkedAt"))
                    if (typeof message.checkedAt === "number")
                        object.checkedAt = options.longs === String ? String(message.checkedAt) : message.checkedAt;
                    else
                        object.checkedAt = options.longs === String ? $util.Long.prototype.toString.call(message.checkedAt) : options.longs === Number ? new $util.LongBits(message.checkedAt.low >>> 0, message.checkedAt.high >>> 0).toNumber() : message.checkedAt;
                return object;
            };
    
            /**
             * Converts this PortableMessageState to JSON.
             * @function toJSON
             * @memberof sheason_chat.PortableMessageState
             * @instance
             * @returns {Object.<string,*>} JSON object
             */
            PortableMessageState.prototype.toJSON = function toJSON() {
                return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
            };
    
            /**
             * Gets the default type url for PortableMessageState
             * @function getTypeUrl
             * @memberof sheason_chat.PortableMessageState
             * @static
             * @param {string} [typeUrlPrefix] your custom typeUrlPrefix(default "type.googleapis.com")
             * @returns {string} The default type url
             */
            PortableMessageState.getTypeUrl = function getTypeUrl(typeUrlPrefix) {
                if (typeUrlPrefix === undefined) {
                    typeUrlPrefix = "type.googleapis.com";
                }
                return typeUrlPrefix + "/sheason_chat.PortableMessageState";
            };
    
            return PortableMessageState;
        })();
    
        /**
         * ContentType enum.
         * @name sheason_chat.ContentType
         * @enum {number}
         * @property {number} CONTENT_BUFFER=0 CONTENT_BUFFER value
         * @property {number} CONTENT_MESSAGE=1 CONTENT_MESSAGE value
         * @property {number} CONTENT_OPERATION=2 CONTENT_OPERATION value
         */
        sheason_chat.ContentType = (function() {
            var valuesById = {}, values = Object.create(valuesById);
            values[valuesById[0] = "CONTENT_BUFFER"] = 0;
            values[valuesById[1] = "CONTENT_MESSAGE"] = 1;
            values[valuesById[2] = "CONTENT_OPERATION"] = 2;
            return values;
        })();
    
        sheason_chat.SignWrapper = (function() {
    
            /**
             * Properties of a SignWrapper.
             * @memberof sheason_chat
             * @interface ISignWrapper
             * @property {sheason_chat.IAccountIndex|null} [signer] SignWrapper signer
             * @property {Uint8Array|null} [buffer] SignWrapper buffer
             * @property {Uint8Array|null} [sign] SignWrapper sign
             * @property {boolean|null} [encrypt] SignWrapper encrypt
             * @property {sheason_chat.ContentType|null} [contentType] SignWrapper contentType
             */
    
            /**
             * Constructs a new SignWrapper.
             * @memberof sheason_chat
             * @classdesc Represents a SignWrapper.
             * @implements ISignWrapper
             * @constructor
             * @param {sheason_chat.ISignWrapper=} [properties] Properties to set
             */
            function SignWrapper(properties) {
                if (properties)
                    for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                        if (properties[keys[i]] != null)
                            this[keys[i]] = properties[keys[i]];
            }
    
            /**
             * SignWrapper signer.
             * @member {sheason_chat.IAccountIndex|null|undefined} signer
             * @memberof sheason_chat.SignWrapper
             * @instance
             */
            SignWrapper.prototype.signer = null;
    
            /**
             * SignWrapper buffer.
             * @member {Uint8Array} buffer
             * @memberof sheason_chat.SignWrapper
             * @instance
             */
            SignWrapper.prototype.buffer = $util.newBuffer([]);
    
            /**
             * SignWrapper sign.
             * @member {Uint8Array} sign
             * @memberof sheason_chat.SignWrapper
             * @instance
             */
            SignWrapper.prototype.sign = $util.newBuffer([]);
    
            /**
             * SignWrapper encrypt.
             * @member {boolean} encrypt
             * @memberof sheason_chat.SignWrapper
             * @instance
             */
            SignWrapper.prototype.encrypt = false;
    
            /**
             * SignWrapper contentType.
             * @member {sheason_chat.ContentType} contentType
             * @memberof sheason_chat.SignWrapper
             * @instance
             */
            SignWrapper.prototype.contentType = 0;
    
            /**
             * Creates a new SignWrapper instance using the specified properties.
             * @function create
             * @memberof sheason_chat.SignWrapper
             * @static
             * @param {sheason_chat.ISignWrapper=} [properties] Properties to set
             * @returns {sheason_chat.SignWrapper} SignWrapper instance
             */
            SignWrapper.create = function create(properties) {
                return new SignWrapper(properties);
            };
    
            /**
             * Encodes the specified SignWrapper message. Does not implicitly {@link sheason_chat.SignWrapper.verify|verify} messages.
             * @function encode
             * @memberof sheason_chat.SignWrapper
             * @static
             * @param {sheason_chat.ISignWrapper} message SignWrapper message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            SignWrapper.encode = function encode(message, writer) {
                if (!writer)
                    writer = $Writer.create();
                if (message.signer != null && Object.hasOwnProperty.call(message, "signer"))
                    $root.sheason_chat.AccountIndex.encode(message.signer, writer.uint32(/* id 1, wireType 2 =*/10).fork()).ldelim();
                if (message.buffer != null && Object.hasOwnProperty.call(message, "buffer"))
                    writer.uint32(/* id 2, wireType 2 =*/18).bytes(message.buffer);
                if (message.sign != null && Object.hasOwnProperty.call(message, "sign"))
                    writer.uint32(/* id 3, wireType 2 =*/26).bytes(message.sign);
                if (message.encrypt != null && Object.hasOwnProperty.call(message, "encrypt"))
                    writer.uint32(/* id 4, wireType 0 =*/32).bool(message.encrypt);
                if (message.contentType != null && Object.hasOwnProperty.call(message, "contentType"))
                    writer.uint32(/* id 5, wireType 0 =*/40).int32(message.contentType);
                return writer;
            };
    
            /**
             * Encodes the specified SignWrapper message, length delimited. Does not implicitly {@link sheason_chat.SignWrapper.verify|verify} messages.
             * @function encodeDelimited
             * @memberof sheason_chat.SignWrapper
             * @static
             * @param {sheason_chat.ISignWrapper} message SignWrapper message or plain object to encode
             * @param {$protobuf.Writer} [writer] Writer to encode to
             * @returns {$protobuf.Writer} Writer
             */
            SignWrapper.encodeDelimited = function encodeDelimited(message, writer) {
                return this.encode(message, writer).ldelim();
            };
    
            /**
             * Decodes a SignWrapper message from the specified reader or buffer.
             * @function decode
             * @memberof sheason_chat.SignWrapper
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @param {number} [length] Message length if known beforehand
             * @returns {sheason_chat.SignWrapper} SignWrapper
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            SignWrapper.decode = function decode(reader, length) {
                if (!(reader instanceof $Reader))
                    reader = $Reader.create(reader);
                var end = length === undefined ? reader.len : reader.pos + length, message = new $root.sheason_chat.SignWrapper();
                while (reader.pos < end) {
                    var tag = reader.uint32();
                    switch (tag >>> 3) {
                    case 1: {
                            message.signer = $root.sheason_chat.AccountIndex.decode(reader, reader.uint32());
                            break;
                        }
                    case 2: {
                            message.buffer = reader.bytes();
                            break;
                        }
                    case 3: {
                            message.sign = reader.bytes();
                            break;
                        }
                    case 4: {
                            message.encrypt = reader.bool();
                            break;
                        }
                    case 5: {
                            message.contentType = reader.int32();
                            break;
                        }
                    default:
                        reader.skipType(tag & 7);
                        break;
                    }
                }
                return message;
            };
    
            /**
             * Decodes a SignWrapper message from the specified reader or buffer, length delimited.
             * @function decodeDelimited
             * @memberof sheason_chat.SignWrapper
             * @static
             * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
             * @returns {sheason_chat.SignWrapper} SignWrapper
             * @throws {Error} If the payload is not a reader or valid buffer
             * @throws {$protobuf.util.ProtocolError} If required fields are missing
             */
            SignWrapper.decodeDelimited = function decodeDelimited(reader) {
                if (!(reader instanceof $Reader))
                    reader = new $Reader(reader);
                return this.decode(reader, reader.uint32());
            };
    
            /**
             * Verifies a SignWrapper message.
             * @function verify
             * @memberof sheason_chat.SignWrapper
             * @static
             * @param {Object.<string,*>} message Plain object to verify
             * @returns {string|null} `null` if valid, otherwise the reason why it is not
             */
            SignWrapper.verify = function verify(message) {
                if (typeof message !== "object" || message === null)
                    return "object expected";
                if (message.signer != null && message.hasOwnProperty("signer")) {
                    var error = $root.sheason_chat.AccountIndex.verify(message.signer);
                    if (error)
                        return "signer." + error;
                }
                if (message.buffer != null && message.hasOwnProperty("buffer"))
                    if (!(message.buffer && typeof message.buffer.length === "number" || $util.isString(message.buffer)))
                        return "buffer: buffer expected";
                if (message.sign != null && message.hasOwnProperty("sign"))
                    if (!(message.sign && typeof message.sign.length === "number" || $util.isString(message.sign)))
                        return "sign: buffer expected";
                if (message.encrypt != null && message.hasOwnProperty("encrypt"))
                    if (typeof message.encrypt !== "boolean")
                        return "encrypt: boolean expected";
                if (message.contentType != null && message.hasOwnProperty("contentType"))
                    switch (message.contentType) {
                    default:
                        return "contentType: enum value expected";
                    case 0:
                    case 1:
                    case 2:
                        break;
                    }
                return null;
            };
    
            /**
             * Creates a SignWrapper message from a plain object. Also converts values to their respective internal types.
             * @function fromObject
             * @memberof sheason_chat.SignWrapper
             * @static
             * @param {Object.<string,*>} object Plain object
             * @returns {sheason_chat.SignWrapper} SignWrapper
             */
            SignWrapper.fromObject = function fromObject(object) {
                if (object instanceof $root.sheason_chat.SignWrapper)
                    return object;
                var message = new $root.sheason_chat.SignWrapper();
                if (object.signer != null) {
                    if (typeof object.signer !== "object")
                        throw TypeError(".sheason_chat.SignWrapper.signer: object expected");
                    message.signer = $root.sheason_chat.AccountIndex.fromObject(object.signer);
                }
                if (object.buffer != null)
                    if (typeof object.buffer === "string")
                        $util.base64.decode(object.buffer, message.buffer = $util.newBuffer($util.base64.length(object.buffer)), 0);
                    else if (object.buffer.length >= 0)
                        message.buffer = object.buffer;
                if (object.sign != null)
                    if (typeof object.sign === "string")
                        $util.base64.decode(object.sign, message.sign = $util.newBuffer($util.base64.length(object.sign)), 0);
                    else if (object.sign.length >= 0)
                        message.sign = object.sign;
                if (object.encrypt != null)
                    message.encrypt = Boolean(object.encrypt);
                switch (object.contentType) {
                default:
                    if (typeof object.contentType === "number") {
                        message.contentType = object.contentType;
                        break;
                    }
                    break;
                case "CONTENT_BUFFER":
                case 0:
                    message.contentType = 0;
                    break;
                case "CONTENT_MESSAGE":
                case 1:
                    message.contentType = 1;
                    break;
                case "CONTENT_OPERATION":
                case 2:
                    message.contentType = 2;
                    break;
                }
                return message;
            };
    
            /**
             * Creates a plain object from a SignWrapper message. Also converts values to other types if specified.
             * @function toObject
             * @memberof sheason_chat.SignWrapper
             * @static
             * @param {sheason_chat.SignWrapper} message SignWrapper
             * @param {$protobuf.IConversionOptions} [options] Conversion options
             * @returns {Object.<string,*>} Plain object
             */
            SignWrapper.toObject = function toObject(message, options) {
                if (!options)
                    options = {};
                var object = {};
                if (options.defaults) {
                    object.signer = null;
                    if (options.bytes === String)
                        object.buffer = "";
                    else {
                        object.buffer = [];
                        if (options.bytes !== Array)
                            object.buffer = $util.newBuffer(object.buffer);
                    }
                    if (options.bytes === String)
                        object.sign = "";
                    else {
                        object.sign = [];
                        if (options.bytes !== Array)
                            object.sign = $util.newBuffer(object.sign);
                    }
                    object.encrypt = false;
                    object.contentType = options.enums === String ? "CONTENT_BUFFER" : 0;
                }
                if (message.signer != null && message.hasOwnProperty("signer"))
                    object.signer = $root.sheason_chat.AccountIndex.toObject(message.signer, options);
                if (message.buffer != null && message.hasOwnProperty("buffer"))
                    object.buffer = options.bytes === String ? $util.base64.encode(message.buffer, 0, message.buffer.length) : options.bytes === Array ? Array.prototype.slice.call(message.buffer) : message.buffer;
                if (message.sign != null && message.hasOwnProperty("sign"))
                    object.sign = options.bytes === String ? $util.base64.encode(message.sign, 0, message.sign.length) : options.bytes === Array ? Array.prototype.slice.call(message.sign) : message.sign;
                if (message.encrypt != null && message.hasOwnProperty("encrypt"))
                    object.encrypt = message.encrypt;
                if (message.contentType != null && message.hasOwnProperty("contentType"))
                    object.contentType = options.enums === String ? $root.sheason_chat.ContentType[message.contentType] === undefined ? message.contentType : $root.sheason_chat.ContentType[message.contentType] : message.contentType;
                return object;
            };
    
            /**
             * Converts this SignWrapper to JSON.
             * @function toJSON
             * @memberof sheason_chat.SignWrapper
             * @instance
             * @returns {Object.<string,*>} JSON object
             */
            SignWrapper.prototype.toJSON = function toJSON() {
                return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
            };
    
            /**
             * Gets the default type url for SignWrapper
             * @function getTypeUrl
             * @memberof sheason_chat.SignWrapper
             * @static
             * @param {string} [typeUrlPrefix] your custom typeUrlPrefix(default "type.googleapis.com")
             * @returns {string} The default type url
             */
            SignWrapper.getTypeUrl = function getTypeUrl(typeUrlPrefix) {
                if (typeUrlPrefix === undefined) {
                    typeUrlPrefix = "type.googleapis.com";
                }
                return typeUrlPrefix + "/sheason_chat.SignWrapper";
            };
    
            return SignWrapper;
        })();
    
        return sheason_chat;
    })();

    return $root;
});
