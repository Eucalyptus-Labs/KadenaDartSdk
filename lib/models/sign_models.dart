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
  /// The pact code to be executed.
  String? code;
  String? pactCode;

  /// The JSON data available during the execution of the code
  /// Accessible using built-in functions like `read-msg`
  Map<String, dynamic>? data;
  Map<String, dynamic>? envData;

  /// The account that will pay for the transaction's gas.
  String sender;

  /// mainnet01, testnet04
  String networkId;

  /// The chain the transaction will be executed on.
  /// 0, 1, 2...
  String chainId;

  /// The maximum amount of gas to be used for the transaction.
  int gasLimit;

  /// The price of gas to be used for the transaction.
  /// Generally something like 1e-5 or 1e-8
  double gasPrice;

  /// The public key that will sign the transaction.
  String signingPubKey;

  /// Time to live in seconds
  int ttl;

  /// The role and descriptiong are displayed to the user when signing
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
  final PactCommand? body;
  final SignRequestError? error;

  SignResult({
    this.body,
    this.error,
  });

  factory SignResult.fromJson(Map<String, dynamic> json) =>
      _$SignResultFromJson(json);

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
