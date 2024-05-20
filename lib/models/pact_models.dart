import 'package:json_annotation/json_annotation.dart';
import 'package:kadena_dart_sdk/utils/collection_equality.dart';
import 'package:kadena_dart_sdk/utils/utils.dart';

part 'pact_models.g.dart';

class KadenaSignKeyPair {
  final String privateKey;
  final String publicKey;

  const KadenaSignKeyPair({
    required this.privateKey,
    required this.publicKey,
  });

  @override
  String toString() {
    return '{privateKey: $privateKey, publicKey: $publicKey}';
  }
}

@JsonSerializable()
class ExecMessage {
  String code;
  Map<String, dynamic> data;

  ExecMessage({
    required this.code,
    this.data = const {},
  });

  factory ExecMessage.fromJson(Map<String, dynamic> json) => _$ExecMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ExecMessageToJson(this);

  @override
  String toString() {
    return '{data: $data, code: $code}';
  }

  @override
  bool operator ==(Object other) {
    return other is ExecMessage && other.code == code && mapEquals(other.data, data);
  }

  @override
  int get hashCode =>
      code.hashCode ^ data.keys.fold(0, (i, e) => i + e.hashCode) ^ data.values.fold(0, (i, e) => i + e.hashCode);
}

@JsonSerializable()
class ContinuationMessage {
  String pactId;
  int step;
  bool rollback;
  Map<String, dynamic> data;
  String? proof;

  ContinuationMessage({
    required this.pactId,
    required this.step,
    required this.rollback,
    required this.data,
    required this.proof,
  });

  factory ContinuationMessage.fromJson(Map<String, dynamic> json) => _$ContinuationMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ContinuationMessageToJson(this);

  @override
  String toString() {
    return '{pactId: $pactId, step: $step, rollback: $rollback, data: $data, proof: $proof}';
  }

  @override
  bool operator ==(Object other) {
    return other is ContinuationMessage &&
        other.pactId == pactId &&
        other.step == step &&
        other.rollback == rollback &&
        mapEquals(other.data, data) &&
        other.proof == proof;
  }

  @override
  int get hashCode =>
      pactId.hashCode ^
      step.hashCode ^
      rollback.hashCode ^
      data.keys.fold(0, (i, e) => i + e.hashCode) ^
      data.values.fold(0, (i, e) => i + e.hashCode) ^
      proof.hashCode;
}

@JsonSerializable(includeIfNull: false)
class CommandPayload {
  /// The exec message to send to the chain.
  ExecMessage? exec;

  /// The continuation message to send to the chain, used to continue a pact.
  ContinuationMessage? cont;

  CommandPayload({
    this.exec,
    this.cont,
  });

  factory CommandPayload.fromJson(Map<String, dynamic> json) => _$CommandPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$CommandPayloadToJson(this);

  @override
  String toString() {
    return '{exec: $exec, cont: $cont}';
  }

  @override
  bool operator ==(Object other) {
    return other is CommandPayload && other.exec == exec && other.cont == cont;
  }

  @override
  int get hashCode => exec.hashCode ^ cont.hashCode;
}

@JsonSerializable()
class Capability {
  String name;
  List<dynamic> args;

  Capability({
    required this.name,
    this.args = const [],
  });

  factory Capability.fromJson(Map<String, dynamic> json) => _$CapabilityFromJson(json);

  Map<String, dynamic> toJson() => _$CapabilityToJson(this);

  @override
  String toString() {
    return '{name: $name, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    return other is Capability && other.name == name && listEquals(other.args, args);
  }

  @override
  int get hashCode => name.hashCode ^ args.fold(0, (i, e) => i + e.hashCode);
}

@JsonSerializable(includeIfNull: false)
class SignerCapabilities {
  String pubKey;
  List<Capability>? clist;

  SignerCapabilities({
    required this.pubKey,
    this.clist,
  });

  factory SignerCapabilities.fromJson(Map<String, dynamic> json) => _$SignerCapabilitiesFromJson(json);

  Map<String, dynamic> toJson() => _$SignerCapabilitiesToJson(this);

  @override
  String toString() {
    return '{pubKey: $pubKey, clist: $clist}';
  }

  @override
  bool operator ==(Object other) {
    return other is SignerCapabilities && other.pubKey == pubKey && listEquals(other.clist, clist);
  }

  @override
  int get hashCode => pubKey.hashCode ^ clist!.fold(0, (i, e) => i + e.hashCode);
}

@JsonSerializable()
class CommandMetadata {
  /// The chain id of the chain to send the transaction to.
  final String chainId;

  /// The gas limit for the transaction. Example: 2500.
  /// Higher gas limit means more gas is used if an error occurs.
  /// Keep the gas limit low to avoid this.
  final int gasLimit;

  /// The gas price for the transaction. Generally something like 1e-5.
  final double gasPrice;

  /// The public key of the sender. This is also the gas payer.
  final String sender;

  /// The time to live for the transaction. Example: 28800.
  final int ttl;

  /// The creation time of the transaction in epoch milliseconds.
  final int creationTime;

  CommandMetadata({
    required this.chainId,
    required this.sender,
    int? gasLimit,
    double? gasPrice,
    int? ttl,
    int? creationTime,
  })  : gasLimit = gasLimit ?? 2500,
        gasPrice = gasPrice ?? 0.00001,
        ttl = ttl ?? 600,
        creationTime = creationTime ?? Utils.getCreationTime();

  factory CommandMetadata.fromJson(Map<String, dynamic> json) => _$CommandMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$CommandMetadataToJson(this);

  @override
  String toString() {
    return '{chainId: $chainId, gasLimit: $gasLimit, gasPrice: $gasPrice, sender: $sender, ttl: $ttl, creationTime: $creationTime}';
  }

  @override
  bool operator ==(Object other) {
    return other is CommandMetadata &&
        other.chainId == chainId &&
        other.gasLimit == gasLimit &&
        other.gasPrice == gasPrice &&
        other.sender == sender &&
        other.ttl == ttl &&
        other.creationTime == creationTime;
  }

  @override
  int get hashCode =>
      chainId.hashCode ^ gasLimit.hashCode ^ gasPrice.hashCode ^ sender.hashCode ^ ttl.hashCode ^ creationTime.hashCode;
}

@JsonSerializable()
class PactCommandPayload {
  final String networkId;
  final CommandPayload payload;
  final List<SignerCapabilities> signers;
  final CommandMetadata meta;
  final String nonce;

  PactCommandPayload({
    required this.networkId,
    required this.payload,
    required this.signers,
    required this.meta,
    String? nonce,
  }) : nonce = nonce ?? DateTime.now().toIso8601String();

  factory PactCommandPayload.fromJson(Map<String, dynamic> json) => _$PactCommandPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$PactCommandPayloadToJson(this);

  @override
  String toString() {
    return '{networkId: $networkId, payload: $payload, signers: $signers, meta: $meta, nonce: $nonce}';
  }

  @override
  bool operator ==(Object other) {
    return other is PactCommandPayload &&
        other.networkId == networkId &&
        other.payload == payload &&
        listEquals(other.signers, signers) &&
        other.meta == meta &&
        other.nonce == nonce;
  }

  @override
  int get hashCode =>
      networkId.hashCode ^
      payload.hashCode ^
      signers.fold(0, (i, e) => i + e.hashCode) ^
      meta.hashCode ^
      nonce.hashCode;
}

@JsonSerializable(includeIfNull: false)
class Signer {
  String? pubKey;
  String? sig;

  Signer({
    this.pubKey,
    this.sig,
  });

  factory Signer.fromJson(Map<String, dynamic> json) => _$SignerFromJson(json);

  Map<String, dynamic> toJson() => _$SignerToJson(this);

  @override
  String toString() {
    return '{pubKey: $pubKey, sig: $sig}';
  }

  @override
  bool operator ==(Object other) {
    return other is Signer && other.pubKey == pubKey && other.sig == sig;
  }

  @override
  int get hashCode => pubKey.hashCode ^ sig.hashCode;
}

@JsonSerializable(includeIfNull: false)
class PactCommand {
  final String cmd;
  final String hash;
  final List<Signer> sigs;

  PactCommand({
    required this.cmd,
    required this.hash,
    required this.sigs,
  });

  factory PactCommand.fromJson(Map<String, dynamic> json) => _$PactCommandFromJson(json);

  Map<String, dynamic> toJson() => _$PactCommandToJson(this);

  @override
  String toString() {
    return '{cmd: $cmd, hash: $hash, sigs: $sigs}';
  }

  @override
  bool operator ==(Object other) {
    return other is PactCommand && other.cmd == cmd && other.hash == hash && listEquals(other.sigs, sigs);
  }

  @override
  int get hashCode => cmd.hashCode ^ hash.hashCode ^ sigs.fold(0, (i, e) => i + e.hashCode);
}

/// GENERIC PACT ENDPOINT OBJECTS

@JsonSerializable(includeIfNull: false)
class PactResultMetadata {
  /// The metadata that was sent with the transaction
  final CommandMetadata publicMeta;

  /// The block time in milliseconds
  final int blockTime;

  /// The previous block hash
  final String prevBlockHash;

  /// The block height
  final int blockHeight;

  PactResultMetadata({
    required this.publicMeta,
    required this.blockTime,
    required this.prevBlockHash,
    required this.blockHeight,
  });

  factory PactResultMetadata.fromJson(Map<String, dynamic> json) => _$PactResultMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$PactResultMetadataToJson(this);

  @override
  String toString() {
    return '{publicMeta: $publicMeta, blockTime: $blockTime, prevBlockHash: $prevBlockHash, blockHeight: $blockHeight}';
  }
}

@JsonSerializable(includeIfNull: false)
class PactResponse {
  final int gas;
  final PactResult result;
  final String reqKey;
  final String logs;
  final String? metadata;
  final String? continuation;
  final String? txId;

  PactResponse({
    required this.gas,
    required this.result,
    required this.reqKey,
    required this.logs,
    this.metadata,
    this.continuation,
    required this.txId,
  });

  factory PactResponse.fromJson(Map<String, dynamic> json) => _$PactResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PactResponseToJson(this);

  @override
  String toString() {
    return '{gas: $gas, result: $result, reqKey: $reqKey, logs: $logs, metadata: $metadata, continuation: $continuation, txId: $txId}';
  }
}

@JsonSerializable(includeIfNull: false)
class PactEvent {
  final String name;
  final List<dynamic> params;
  final String module;
  final String moduleHash;

  PactEvent({
    required this.name,
    required this.params,
    required this.module,
    required this.moduleHash,
  });

  factory PactEvent.fromJson(Map<String, dynamic> json) => _$PactEventFromJson(json);

  Map<String, dynamic> toJson() => _$PactEventToJson(this);

  @override
  String toString() {
    return '{name: $name, params: $params, module: $module, moduleHash: $moduleHash}';
  }
}

@JsonSerializable(includeIfNull: false, genericArgumentFactories: true)
class PactResult<T> {
  final String status;
  final T? data;
  final String? error;

  PactResult({
    required this.status,
    this.data,
    this.error,
  });

  factory PactResult.fromJson(Map<String, dynamic> json) => _$PactResultFromJson(json, (object) => object as T);

  Map<String, dynamic> toJson() => _$PactResultToJson(this, (t) => t);

  @override
  String toString() {
    return '{status: $status, data: $data, error: $error}';
  }
}

@JsonSerializable(includeIfNull: false)
class PactApiError {
  final String error;

  PactApiError({
    required this.error,
  });

  factory PactApiError.fromJson(Map<String, dynamic> json) => _$PactApiErrorFromJson(json);

  Map<String, dynamic> toJson() => _$PactApiErrorToJson(this);

  @override
  String toString() {
    return '{error: $error}';
  }
}

/// PACT SEND ENDPOINT ///

@JsonSerializable(includeIfNull: false)
class PactSendRequest {
  final List<PactCommand> cmds;

  PactSendRequest({
    required this.cmds,
  });

  factory PactSendRequest.fromJson(Map<String, dynamic> json) => _$PactSendRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PactSendRequestToJson(this);

  @override
  String toString() {
    return '{cmds: $cmds}';
  }
}

@JsonSerializable(includeIfNull: false)
class PactSendResponse {
  final List<String> requestKeys;

  PactSendResponse({
    required this.requestKeys,
  });

  factory PactSendResponse.fromJson(Map<String, dynamic> json) => _$PactSendResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PactSendResponseToJson(this);

  @override
  String toString() {
    return '{requestKeys: $requestKeys}';
  }
}

/// PACT LISTEN ENDPOINT

@JsonSerializable(includeIfNull: false)
class PactListenRequest {
  final String listen;

  PactListenRequest({
    required this.listen,
  });

  factory PactListenRequest.fromJson(Map<String, dynamic> json) => _$PactListenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PactListenRequestToJson(this);

  @override
  String toString() {
    return '{listen: $listen}';
  }
}
