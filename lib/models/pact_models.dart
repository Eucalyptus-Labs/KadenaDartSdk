import 'package:json_annotation/json_annotation.dart';

part 'pact_models.g.dart';

class KadenaSignKeyPair {
  final String privateKey;
  final String publicKey;

  const KadenaSignKeyPair({
    required this.privateKey,
    required this.publicKey,
  });
}

@JsonSerializable()
class ExecMessage {
  Map<String, dynamic> data;
  String code;

  ExecMessage({
    required this.data,
    required this.code,
  });

  factory ExecMessage.fromJson(Map<String, dynamic> json) =>
      _$ExecMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ExecMessageToJson(this);
}

@JsonSerializable()
class ContinuationMessage {
  String pactId;
  int step;
  bool rollback;
  Map<String, dynamic> data;
  String proof;

  ContinuationMessage({
    required this.pactId,
    required this.step,
    required this.rollback,
    required this.data,
    required this.proof,
  });

  factory ContinuationMessage.fromJson(Map<String, dynamic> json) =>
      _$ContinuationMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ContinuationMessageToJson(this);
}

@JsonSerializable(includeIfNull: false)
class CommandPayload {
  ExecMessage? exec;
  ContinuationMessage? cont;

  CommandPayload({
    this.exec,
    this.cont,
  });

  factory CommandPayload.fromJson(Map<String, dynamic> json) =>
      _$CommandPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$CommandPayloadToJson(this);
}

@JsonSerializable()
class Capability {
  String name;
  List args;

  Capability({
    required this.name,
    required this.args,
  });

  factory Capability.fromJson(Map<String, dynamic> json) =>
      _$CapabilityFromJson(json);

  Map<String, dynamic> toJson() => _$CapabilityToJson(this);
}

@JsonSerializable()
class SignerCapability {
  String pubKey;
  List<Capability> clist;

  SignerCapability({
    required this.pubKey,
    required this.clist,
  });

  factory SignerCapability.fromJson(Map<String, dynamic> json) =>
      _$SignerCapabilityFromJson(json);

  Map<String, dynamic> toJson() => _$SignerCapabilityToJson(this);
}

@JsonSerializable()
class CommandMetadata {
  /// The chain id of the chain to send the transaction to.
  String chainId;

  /// The gas limit for the transaction. Example: 2500.
  /// Higher gas limit means more gas is used if an error occurs.
  /// Keep the gas limit low to avoid this.
  int gasLimit;

  /// The gas price for the transaction. Generally something like 1e-5.
  int gasPrice;

  /// The public key of the sender. This is also the gas payer.
  String sender;

  /// The time to live for the transaction. Example: 28800.
  int ttl;

  /// The creation time of the transaction in epoch milliseconds.
  int creationTime;

  CommandMetadata({
    required this.chainId,
    required this.gasLimit,
    required this.gasPrice,
    required this.sender,
    required this.ttl,
    required this.creationTime,
  });

  factory CommandMetadata.fromJson(Map<String, dynamic> json) =>
      _$CommandMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$CommandMetadataToJson(this);
}

@JsonSerializable()
class PactCommandPayload {
  Map<String, dynamic> payload;
  List<SignerCapability> signers;
  CommandMetadata meta;
  String nonce;

  PactCommandPayload({
    required this.payload,
    required this.signers,
    required this.meta,
    required this.nonce,
  });

  factory PactCommandPayload.fromJson(Map<String, dynamic> json) =>
      _$PactCommandPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$PactCommandPayloadToJson(this);
}
