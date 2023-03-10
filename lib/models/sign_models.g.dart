// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DappCapp _$DappCappFromJson(Map<String, dynamic> json) => DappCapp(
      role: json['role'] as String,
      description: json['description'] as String,
      cap: Capability.fromJson(json['cap'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DappCappToJson(DappCapp instance) => <String, dynamic>{
      'role': instance.role,
      'description': instance.description,
      'cap': instance.cap,
    };

SignRequest _$SignRequestFromJson(Map<String, dynamic> json) => SignRequest(
      code: json['code'] as String,
      data: json['data'] as Map<String, dynamic>? ?? const {},
      sender: json['sender'] as String,
      networkId: json['networkId'] as String,
      chainId: json['chainId'] as String,
      gasLimit: json['gasLimit'] as int? ?? 2500,
      gasPrice: (json['gasPrice'] as num?)?.toDouble() ?? 1e-8,
      signingPubKey: json['signingPubKey'] as String,
      ttl: json['ttl'] as int? ?? 600,
      caps: (json['caps'] as List<dynamic>?)
              ?.map((e) => DappCapp.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <DappCapp>[],
    );

Map<String, dynamic> _$SignRequestToJson(SignRequest instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'sender': instance.sender,
      'networkId': instance.networkId,
      'chainId': instance.chainId,
      'gasLimit': instance.gasLimit,
      'gasPrice': instance.gasPrice,
      'signingPubKey': instance.signingPubKey,
      'ttl': instance.ttl,
      'caps': instance.caps,
    };

SignResult _$SignResultFromJson(Map<String, dynamic> json) => SignResult(
      pactCommand: json['pactCommand'] == null
          ? null
          : PactCommand.fromJson(json['pactCommand'] as Map<String, dynamic>),
      error: json['error'] == null
          ? null
          : SignRequestError.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignResultToJson(SignResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('pactCommand', instance.pactCommand);
  writeNotNull('error', instance.error);
  return val;
}

SignRequestError _$SignRequestErrorFromJson(Map<String, dynamic> json) =>
    SignRequestError(
      msg: json['msg'] as String,
    );

Map<String, dynamic> _$SignRequestErrorToJson(SignRequestError instance) =>
    <String, dynamic>{
      'msg': instance.msg,
    };
