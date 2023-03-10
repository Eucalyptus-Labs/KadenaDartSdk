import 'package:json_annotation/json_annotation.dart';
import 'package:kadena_dart_sdk/models/pact_models.dart';

part 'quicksign_models.g.dart';

@JsonSerializable(includeIfNull: false)
class QuicksignSigner {
  String pubKey;
  String? sig;

  QuicksignSigner({
    required this.pubKey,
    required this.sig,
  });

  factory QuicksignSigner.fromJson(Map<String, dynamic> json) =>
      _$QuicksignSignerFromJson(json);

  Map<String, dynamic> toJson() => _$QuicksignSignerToJson(this);
}

@JsonSerializable()
class CommandSigData {
  String cmd;
  List<QuicksignSigner> sigs;

  CommandSigData({
    required this.cmd,
    required this.sigs,
  });

  factory CommandSigData.fromJson(Map<String, dynamic> json) =>
      _$CommandSigDataFromJson(json);

  Map<String, dynamic> toJson() => _$CommandSigDataToJson(this);
}

@JsonSerializable(includeIfNull: false)
class QuicksignOutcome {
  static const String success = 'success';
  static const String failure = 'failure';
  static const String noSig = 'noSig';

  String result;
  String? hash;
  String? msg;

  QuicksignOutcome({
    required this.result,
    this.hash,
    this.msg,
  });

  factory QuicksignOutcome.fromJson(Map<String, dynamic> json) =>
      _$QuicksignOutcomeFromJson(json);

  Map<String, dynamic> toJson() => _$QuicksignOutcomeToJson(this);
}

@JsonSerializable()
class QuicksignResponse {
  CommandSigData commandSigData;
  QuicksignOutcome outcome;

  QuicksignResponse({
    required this.commandSigData,
    required this.outcome,
  });

  factory QuicksignResponse.fromJson(Map<String, dynamic> json) =>
      _$QuicksignResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuicksignResponseToJson(this);
}

@JsonSerializable(includeIfNull: false)
class QuicksignError {
  static const String reject = 'reject';
  static const String emptyList = 'emptyList';
  static const String other = 'other';

  String type;
  String? msg;

  QuicksignError({
    required this.type,
    this.msg,
  });

  factory QuicksignError.fromJson(Map<String, dynamic> json) =>
      _$QuicksignErrorFromJson(json);

  Map<String, dynamic> toJson() => _$QuicksignErrorToJson(this);
}

@JsonSerializable()
class QuicksignRequest {
  List<CommandSigData> commandSigDatas;

  QuicksignRequest({
    required this.commandSigDatas,
  });

  factory QuicksignRequest.fromJson(Map<String, dynamic> json) =>
      _$QuicksignRequestFromJson(json);

  Map<String, dynamic> toJson() => _$QuicksignRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class QuicksignResult {
  List<QuicksignResponse>? responses;
  QuicksignError? error;

  QuicksignResult({
    this.responses,
    this.error,
  });

  factory QuicksignResult.fromJson(Map<String, dynamic> json) =>
      _$QuicksignResultFromJson(json);

  Map<String, dynamic> toJson() => _$QuicksignResultToJson(this);
}
