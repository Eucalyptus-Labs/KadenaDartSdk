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

SignerCapability _$SignerCapabilityFromJson(Map<String, dynamic> json) =>
    SignerCapability(
      pubKey: json['pubKey'] as String,
      clist: (json['clist'] as List<dynamic>)
          .map((e) => Capability.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SignerCapabilityToJson(SignerCapability instance) =>
    <String, dynamic>{
      'pubKey': instance.pubKey,
      'clist': instance.clist,
    };

CommandMetadata _$CommandMetadataFromJson(Map<String, dynamic> json) =>
    CommandMetadata(
      chainId: json['chainId'] as String,
      gasLimit: json['gasLimit'] as int,
      gasPrice: json['gasPrice'] as int,
      sender: json['sender'] as String,
      ttl: json['ttl'] as int,
      creationTime: json['creationTime'] as int,
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
      payload: json['payload'] as Map<String, dynamic>,
      signers: (json['signers'] as List<dynamic>)
          .map((e) => SignerCapability.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: CommandMetadata.fromJson(json['meta'] as Map<String, dynamic>),
      nonce: json['nonce'] as String,
    );

Map<String, dynamic> _$PactCommandPayloadToJson(PactCommandPayload instance) =>
    <String, dynamic>{
      'payload': instance.payload,
      'signers': instance.signers,
      'meta': instance.meta,
      'nonce': instance.nonce,
    };
