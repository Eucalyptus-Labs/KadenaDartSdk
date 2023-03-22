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
      code: json['code'] as String?,
      data: json['data'] as Map<String, dynamic>?,
      sender: json['sender'] as String,
      networkId: json['networkId'] as String,
      chainId: json['chainId'] as String,
      gasLimit: json['gasLimit'] as int?,
      gasPrice: (json['gasPrice'] as num?)?.toDouble(),
      signingPubKey: json['signingPubKey'] as String?,
      ttl: json['ttl'] as int?,
      caps: (json['caps'] as List<dynamic>?)
          ?.map((e) => DappCapp.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..pactCode = json['pactCode'] as String?
      ..envData = json['envData'] as Map<String, dynamic>?;

Map<String, dynamic> _$SignRequestToJson(SignRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('code', instance.code);
  writeNotNull('pactCode', instance.pactCode);
  writeNotNull('data', instance.data);
  writeNotNull('envData', instance.envData);
  val['sender'] = instance.sender;
  val['networkId'] = instance.networkId;
  val['chainId'] = instance.chainId;
  writeNotNull('gasLimit', instance.gasLimit);
  writeNotNull('gasPrice', instance.gasPrice);
  writeNotNull('signingPubKey', instance.signingPubKey);
  writeNotNull('ttl', instance.ttl);
  writeNotNull('caps', instance.caps);
  return val;
}

SignResult _$SignResultFromJson(Map<String, dynamic> json) => SignResult(
      body: json['body'] == null
          ? null
          : PactCommand.fromJson(json['body'] as Map<String, dynamic>),
      signedCmd: json['signedCmd'] == null
          ? null
          : PactCommand.fromJson(json['signedCmd'] as Map<String, dynamic>),
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

  writeNotNull('body', instance.body);
  writeNotNull('signedCmd', instance.signedCmd);
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
