import 'package:json_annotation/json_annotation.dart';
import 'package:kadena_dart_sdk/models/pact_models.dart';

part 'sign_models.g.dart';

// {
// 	role: String, // The role of the capability
// 	description: String, // A description of the capability
// 	cap: Capability
// }
@JsonSerializable(includeIfNull: false)
class DappCapp {
  String role;
  String description;
  Capability cap;

  DappCapp({
    required this.role,
    required this.description,
    required this.cap,
  });

  factory DappCapp.fromJson(Map<String, dynamic> json) =>
      _$DappCappFromJson(json);

  Map<String, dynamic> toJson() => _$DappCappToJson(this);
}

@JsonSerializable(includeIfNull: false)
class SignRequest {
  String code;
  Map<String, dynamic> data;
  String sender;
  String networkId;
  String chainId;
  int gasLimit;
  double gasPrice;
  String signingPubKey;
  int ttl;
  List<DappCapp> caps;

  SignRequest({
    required this.code,
    this.data = const {},
    required this.sender,
    required this.networkId,
    required this.chainId,
    this.gasLimit = 2500,
    this.gasPrice = 1e-8,
    required this.signingPubKey,
    this.ttl = 600,
    this.caps = const <DappCapp>[],
  });

  factory SignRequest.fromJson(Map<String, dynamic> json) =>
      _$SignRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class SignResult {
  final PactCommand? pactCommand;
  final SignRequestError? error;

  SignResult({
    this.pactCommand,
    this.error,
  });

  factory SignResult.fromJson(Map<String, dynamic> json) =>
      _$SignResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SignResultToJson(this);
}

@JsonSerializable(includeIfNull: false)
class SignRequestError {
  final String msg;

  SignRequestError({
    required this.msg,
  });

  factory SignRequestError.fromJson(Map<String, dynamic> json) =>
      _$SignRequestErrorFromJson(json);

  Map<String, dynamic> toJson() => _$SignRequestErrorToJson(this);
}
