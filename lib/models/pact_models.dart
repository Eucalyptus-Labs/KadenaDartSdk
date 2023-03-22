import 'package:json_annotation/json_annotation.dart';
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
    return 'KadenaSignKeyPair{privateKey: $privateKey, publicKey: $publicKey}';
  }
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

  @override
  String toString() {
    return 'ExecMessage{data: $data, code: $code}';
  }
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

  @override
  String toString() {
    return 'ContinuationMessage{pactId: $pactId, step: $step, rollback: $rollback, data: $data, proof: $proof}';
  }
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

  @override
  String toString() {
    return 'CommandPayload{exec: $exec, cont: $cont}';
  }
}

@JsonSerializable()
class Capability {
  String name;
  List<dynamic> args;

  Capability({
    required this.name,
    required this.args,
  });

  factory Capability.fromJson(Map<String, dynamic> json) =>
      _$CapabilityFromJson(json);

  Map<String, dynamic> toJson() => _$CapabilityToJson(this);

  @override
  String toString() {
    return 'Capability{name: $name, args: $args}';
  }
}

@JsonSerializable()
class SignerCapabilities {
  String pubKey;
  List<Capability> clist;

  SignerCapabilities({
    required this.pubKey,
    required this.clist,
  });

  factory SignerCapabilities.fromJson(Map<String, dynamic> json) =>
      _$SignerCapabilitiesFromJson(json);

  Map<String, dynamic> toJson() => _$SignerCapabilitiesToJson(this);

  @override
  String toString() {
    return 'SignerCapabilities{pubKey: $pubKey, clist: $clist}';
  }
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
    required this.gasLimit,
    required this.gasPrice,
    required this.sender,
    this.ttl = 600,
    int? creationTime,
  }) : creationTime = creationTime ?? Utils.getCreationTime();

  factory CommandMetadata.fromJson(Map<String, dynamic> json) =>
      _$CommandMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$CommandMetadataToJson(this);

  @override
  String toString() {
    return 'CommandMetadata{chainId: $chainId, gasLimit: $gasLimit, gasPrice: $gasPrice, sender: $sender, ttl: $ttl, creationTime: $creationTime}';
  }
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

  factory PactCommandPayload.fromJson(Map<String, dynamic> json) =>
      _$PactCommandPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$PactCommandPayloadToJson(this);

  @override
  String toString() {
    return 'PactCommandPayload{networkId: $networkId, payload: $payload, signers: $signers, meta: $meta, nonce: $nonce}';
  }
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
    return 'Signer{pubKey: $pubKey, sig: $sig}';
  }
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

  factory PactCommand.fromJson(Map<String, dynamic> json) =>
      _$PactCommandFromJson(json);

  Map<String, dynamic> toJson() => _$PactCommandToJson(this);

  @override
  String toString() {
    return 'PactCommand{cmd: $cmd, hash: $hash, sigs: $sigs}';
  }
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

  factory PactResultMetadata.fromJson(Map<String, dynamic> json) =>
      _$PactResultMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$PactResultMetadataToJson(this);

  @override
  String toString() {
    return 'PactResultMetadata{publicMeta: $publicMeta, blockTime: $blockTime, prevBlockHash: $prevBlockHash, blockHeight: $blockHeight}';
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

  factory PactResponse.fromJson(Map<String, dynamic> json) =>
      _$PactResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PactResponseToJson(this);

  @override
  String toString() {
    return 'PactResponse{gas: $gas, result: $result, reqKey: $reqKey, logs: $logs, metadata: $metadata, continuation: $continuation, txId: $txId}';
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

  factory PactEvent.fromJson(Map<String, dynamic> json) =>
      _$PactEventFromJson(json);

  Map<String, dynamic> toJson() => _$PactEventToJson(this);

  @override
  String toString() {
    return 'PactEvent{name: $name, params: $params, module: $module, moduleHash: $moduleHash}';
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

  factory PactResult.fromJson(Map<String, dynamic> json) =>
      _$PactResultFromJson(json, (object) => object as T);

  Map<String, dynamic> toJson() => _$PactResultToJson(this, (t) => t);

  @override
  String toString() {
    return 'PactResult{status: $status, data: $data, error: $error}';
  }
}

@JsonSerializable(includeIfNull: false)
class PactApiError {
  final String error;

  PactApiError({
    required this.error,
  });

  factory PactApiError.fromJson(Map<String, dynamic> json) =>
      _$PactApiErrorFromJson(json);

  Map<String, dynamic> toJson() => _$PactApiErrorToJson(this);

  @override
  String toString() {
    return 'PactError{error: $error}';
  }
}

/// PACT SEND ENDPOINT ///

@JsonSerializable(includeIfNull: false)
class PactSendRequest {
  final List<PactCommand> cmds;

  PactSendRequest({
    required this.cmds,
  });

  factory PactSendRequest.fromJson(Map<String, dynamic> json) =>
      _$PactSendRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PactSendRequestToJson(this);

  @override
  String toString() {
    return 'PactSendRequest{cmds: $cmds}';
  }
}

@JsonSerializable(includeIfNull: false)
class PactSendResponse {
  final List<String> requestKeys;

  PactSendResponse({
    required this.requestKeys,
  });

  factory PactSendResponse.fromJson(Map<String, dynamic> json) =>
      _$PactSendResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PactSendResponseToJson(this);

  @override
  String toString() {
    return 'PactSendResponse{requestKeys: $requestKeys}';
  }
}

/// PACT LISTEN ENDPOINT

@JsonSerializable(includeIfNull: false)
class PactListenRequest {
  final String listen;

  PactListenRequest({
    required this.listen,
  });

  factory PactListenRequest.fromJson(Map<String, dynamic> json) =>
      _$PactListenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PactListenRequestToJson(this);

  @override
  String toString() {
    return 'PactListenRequest{listen: $listen}';
  }
}
