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

  @override
  String toString() {
    return 'DappCapp{role: $role, description: $description, cap: $cap}';
  }
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
  int? gasLimit;

  /// The price of gas to be used for the transaction.
  /// Generally something like 1e-5 or 1e-8
  double? gasPrice;

  /// The public key that will sign the transaction.
  String? signingPubKey;

  /// Time to live in seconds
  int? ttl;

  /// The role and descriptiong are displayed to the user when signing
  List<DappCapp>? caps;

  SignRequest({
    required this.code,
    this.data,
    required this.sender,
    required this.networkId,
    required this.chainId,
    this.gasLimit,
    this.gasPrice,
    this.signingPubKey,
    this.ttl,
    this.caps,
  })  : pactCode = code,
        envData = data;

  factory SignRequest.fromJson(Map<String, dynamic> json) =>
      _$SignRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignRequestToJson(this);

  @override
  String toString() {
    return 'SignRequest{code or pactCode: ${code ?? pactCode}, data or envData: ${data ?? envData}, sender: $sender, networkId: $networkId, chainId: $chainId, gasLimit: $gasLimit, gasPrice: $gasPrice, signingPubKey: $signingPubKey, ttl: $ttl, caps: $caps}';
  }
}

@JsonSerializable(includeIfNull: false)
class SignResult {
  final PactCommand? body;
  final PactCommand? signedCmd;
  final SignRequestError? error;

  SignResult({
    this.body,
    this.signedCmd,
    this.error,
  });

  factory SignResult.fromJson(Map<String, dynamic> json) =>
      _$SignResultFromJson(json);

  Map<String, dynamic> toJson() => _$SignResultToJson(this);

  @override
  String toString() {
    return 'SignResult{body or signedCmd: ${body ?? signedCmd}, error: $error}';
  }
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

  @override
  String toString() {
    return 'SignRequestError{msg: $msg}';
  }
}
