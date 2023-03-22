// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pact_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExecMessage _$ExecMessageFromJson(Map<String, dynamic> json) => ExecMessage(
      data: json['data'] as Map<String, dynamic>,
      code: json['code'] as String,
    );

Map<String, dynamic> _$ExecMessageToJson(ExecMessage instance) =>
    <String, dynamic>{
      'data': instance.data,
      'code': instance.code,
    };

ContinuationMessage _$ContinuationMessageFromJson(Map<String, dynamic> json) =>
    ContinuationMessage(
      pactId: json['pactId'] as String,
      step: json['step'] as int,
      rollback: json['rollback'] as bool,
      data: json['data'] as Map<String, dynamic>,
      proof: json['proof'] as String,
    );

Map<String, dynamic> _$ContinuationMessageToJson(
        ContinuationMessage instance) =>
    <String, dynamic>{
      'pactId': instance.pactId,
      'step': instance.step,
      'rollback': instance.rollback,
      'data': instance.data,
      'proof': instance.proof,
    };

CommandPayload _$CommandPayloadFromJson(Map<String, dynamic> json) =>
    CommandPayload(
      exec: json['exec'] == null
          ? null
          : ExecMessage.fromJson(json['exec'] as Map<String, dynamic>),
      cont: json['cont'] == null
          ? null
          : ContinuationMessage.fromJson(json['cont'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommandPayloadToJson(CommandPayload instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('exec', instance.exec);
  writeNotNull('cont', instance.cont);
  return val;
}

Capability _$CapabilityFromJson(Map<String, dynamic> json) => Capability(
      name: json['name'] as String,
      args: json['args'] as List<dynamic>,
    );

Map<String, dynamic> _$CapabilityToJson(Capability instance) =>
    <String, dynamic>{
      'name': instance.name,
      'args': instance.args,
    };

SignerCapabilities _$SignerCapabilitiesFromJson(Map<String, dynamic> json) =>
    SignerCapabilities(
      pubKey: json['pubKey'] as String,
      clist: (json['clist'] as List<dynamic>)
          .map((e) => Capability.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SignerCapabilitiesToJson(SignerCapabilities instance) =>
    <String, dynamic>{
      'pubKey': instance.pubKey,
      'clist': instance.clist,
    };

CommandMetadata _$CommandMetadataFromJson(Map<String, dynamic> json) =>
    CommandMetadata(
      chainId: json['chainId'] as String,
      gasLimit: json['gasLimit'] as int,
      gasPrice: (json['gasPrice'] as num).toDouble(),
      sender: json['sender'] as String,
      ttl: json['ttl'] as int? ?? 600,
      creationTime: json['creationTime'] as int?,
    );

Map<String, dynamic> _$CommandMetadataToJson(CommandMetadata instance) =>
    <String, dynamic>{
      'chainId': instance.chainId,
      'gasLimit': instance.gasLimit,
      'gasPrice': instance.gasPrice,
      'sender': instance.sender,
      'ttl': instance.ttl,
      'creationTime': instance.creationTime,
    };

PactCommandPayload _$PactCommandPayloadFromJson(Map<String, dynamic> json) =>
    PactCommandPayload(
      networkId: json['networkId'] as String,
      payload: CommandPayload.fromJson(json['payload'] as Map<String, dynamic>),
      signers: (json['signers'] as List<dynamic>)
          .map((e) => SignerCapabilities.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: CommandMetadata.fromJson(json['meta'] as Map<String, dynamic>),
      nonce: json['nonce'] as String?,
    );

Map<String, dynamic> _$PactCommandPayloadToJson(PactCommandPayload instance) =>
    <String, dynamic>{
      'networkId': instance.networkId,
      'payload': instance.payload,
      'signers': instance.signers,
      'meta': instance.meta,
      'nonce': instance.nonce,
    };

Signer _$SignerFromJson(Map<String, dynamic> json) => Signer(
      pubKey: json['pubKey'] as String?,
      sig: json['sig'] as String?,
    );

Map<String, dynamic> _$SignerToJson(Signer instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('pubKey', instance.pubKey);
  writeNotNull('sig', instance.sig);
  return val;
}

PactCommand _$PactCommandFromJson(Map<String, dynamic> json) => PactCommand(
      cmd: json['cmd'] as String,
      hash: json['hash'] as String,
      sigs: (json['sigs'] as List<dynamic>)
          .map((e) => Signer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PactCommandToJson(PactCommand instance) =>
    <String, dynamic>{
      'cmd': instance.cmd,
      'hash': instance.hash,
      'sigs': instance.sigs,
    };

PactResultMetadata _$PactResultMetadataFromJson(Map<String, dynamic> json) =>
    PactResultMetadata(
      publicMeta:
          CommandMetadata.fromJson(json['publicMeta'] as Map<String, dynamic>),
      blockTime: json['blockTime'] as int,
      prevBlockHash: json['prevBlockHash'] as String,
      blockHeight: json['blockHeight'] as int,
    );

Map<String, dynamic> _$PactResultMetadataToJson(PactResultMetadata instance) =>
    <String, dynamic>{
      'publicMeta': instance.publicMeta,
      'blockTime': instance.blockTime,
      'prevBlockHash': instance.prevBlockHash,
      'blockHeight': instance.blockHeight,
    };

PactResponse _$PactResponseFromJson(Map<String, dynamic> json) => PactResponse(
      gas: json['gas'] as int,
      result:
          PactResult<dynamic>.fromJson(json['result'] as Map<String, dynamic>),
      reqKey: json['reqKey'] as String,
      logs: json['logs'] as String,
      metadata: json['metadata'] as String?,
      continuation: json['continuation'] as String?,
      txId: json['txId'] as String?,
    );

Map<String, dynamic> _$PactResponseToJson(PactResponse instance) {
  final val = <String, dynamic>{
    'gas': instance.gas,
    'result': instance.result,
    'reqKey': instance.reqKey,
    'logs': instance.logs,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('metadata', instance.metadata);
  writeNotNull('continuation', instance.continuation);
  writeNotNull('txId', instance.txId);
  return val;
}

PactEvent _$PactEventFromJson(Map<String, dynamic> json) => PactEvent(
      name: json['name'] as String,
      params: json['params'] as List<dynamic>,
      module: json['module'] as String,
      moduleHash: json['moduleHash'] as String,
    );

Map<String, dynamic> _$PactEventToJson(PactEvent instance) => <String, dynamic>{
      'name': instance.name,
      'params': instance.params,
      'module': instance.module,
      'moduleHash': instance.moduleHash,
    };

PactResult<T> _$PactResultFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PactResult<T>(
      status: json['status'] as String,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$PactResultToJson<T>(
  PactResult<T> instance,
  Object? Function(T value) toJsonT,
) {
  final val = <String, dynamic>{
    'status': instance.status,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', _$nullableGenericToJson(instance.data, toJsonT));
  writeNotNull('error', instance.error);
  return val;
}

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);

PactApiError _$PactApiErrorFromJson(Map<String, dynamic> json) => PactApiError(
      error: json['error'] as String,
    );

Map<String, dynamic> _$PactApiErrorToJson(PactApiError instance) =>
    <String, dynamic>{
      'error': instance.error,
    };

PactSendRequest _$PactSendRequestFromJson(Map<String, dynamic> json) =>
    PactSendRequest(
      cmds: (json['cmds'] as List<dynamic>)
          .map((e) => PactCommand.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PactSendRequestToJson(PactSendRequest instance) =>
    <String, dynamic>{
      'cmds': instance.cmds,
    };

PactSendResponse _$PactSendResponseFromJson(Map<String, dynamic> json) =>
    PactSendResponse(
      requestKeys: (json['requestKeys'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PactSendResponseToJson(PactSendResponse instance) =>
    <String, dynamic>{
      'requestKeys': instance.requestKeys,
    };

PactListenRequest _$PactListenRequestFromJson(Map<String, dynamic> json) =>
    PactListenRequest(
      listen: json['listen'] as String,
    );

Map<String, dynamic> _$PactListenRequestToJson(PactListenRequest instance) =>
    <String, dynamic>{
      'listen': instance.listen,
    };
