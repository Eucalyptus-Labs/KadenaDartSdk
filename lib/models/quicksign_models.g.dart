// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quicksign_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuicksignSigner _$QuicksignSignerFromJson(Map<String, dynamic> json) =>
    QuicksignSigner(
      pubKey: json['pubKey'] as String,
      sig: json['sig'] as String?,
    );

Map<String, dynamic> _$QuicksignSignerToJson(QuicksignSigner instance) {
  final val = <String, dynamic>{
    'pubKey': instance.pubKey,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sig', instance.sig);
  return val;
}

CommandSigData _$CommandSigDataFromJson(Map<String, dynamic> json) =>
    CommandSigData(
      cmd: json['cmd'] as String,
      sigs: (json['sigs'] as List<dynamic>)
          .map((e) => QuicksignSigner.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CommandSigDataToJson(CommandSigData instance) =>
    <String, dynamic>{
      'cmd': instance.cmd,
      'sigs': instance.sigs,
    };

QuicksignOutcome _$QuicksignOutcomeFromJson(Map<String, dynamic> json) =>
    QuicksignOutcome(
      result: json['result'] as String,
      hash: json['hash'] as String?,
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$QuicksignOutcomeToJson(QuicksignOutcome instance) {
  final val = <String, dynamic>{
    'result': instance.result,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('hash', instance.hash);
  writeNotNull('msg', instance.msg);
  return val;
}

QuicksignResponse _$QuicksignResponseFromJson(Map<String, dynamic> json) =>
    QuicksignResponse(
      commandSigData: CommandSigData.fromJson(
          json['commandSigData'] as Map<String, dynamic>),
      outcome:
          QuicksignOutcome.fromJson(json['outcome'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuicksignResponseToJson(QuicksignResponse instance) =>
    <String, dynamic>{
      'commandSigData': instance.commandSigData,
      'outcome': instance.outcome,
    };

QuicksignError _$QuicksignErrorFromJson(Map<String, dynamic> json) =>
    QuicksignError(
      type: json['type'] as String,
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$QuicksignErrorToJson(QuicksignError instance) {
  final val = <String, dynamic>{
    'type': instance.type,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('msg', instance.msg);
  return val;
}

QuicksignRequest _$QuicksignRequestFromJson(Map<String, dynamic> json) =>
    QuicksignRequest(
      commandSigDatas: (json['commandSigDatas'] as List<dynamic>)
          .map((e) => CommandSigData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuicksignRequestToJson(QuicksignRequest instance) =>
    <String, dynamic>{
      'commandSigDatas': instance.commandSigDatas,
    };

QuicksignResult _$QuicksignResultFromJson(Map<String, dynamic> json) =>
    QuicksignResult(
      responses: (json['responses'] as List<dynamic>?)
          ?.map((e) => QuicksignResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'] == null
          ? null
          : QuicksignError.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuicksignResultToJson(QuicksignResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('responses', instance.responses);
  writeNotNull('error', instance.error);
  return val;
}
