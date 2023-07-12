import 'package:json_annotation/json_annotation.dart';
import 'package:kadena_dart_sdk/models/pact_models.dart';

part 'sign_models.g.dart';

@JsonSerializable(includeIfNull: false)
class DappCapp {
  /// The role of the capability
  String role;

  /// A description of the capability
  String description;

  /// The capability to include in the transaction
  Capability cap;

  DappCapp({
    required this.role,
    required this.description,
    required this.cap,
  });

  factory DappCapp.fromJson(Map<String, dynamic> json) => _$DappCappFromJson(json);

  Map<String, dynamic> toJson() => _$DappCappToJson(this);

  @override
  String toString() {
    return '{role: $role, description: $description, cap: $cap}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DappCapp &&
          runtimeType == other.runtimeType &&
          role == other.role &&
          description == other.description &&
          cap == other.cap;

  @override
  int get hashCode => role.hashCode ^ description.hashCode ^ cap.hashCode;
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

  factory SignRequest.fromJson(Map<String, dynamic> json) => _$SignRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignRequestToJson(this);

  @override
  String toString() {
    return '{code: ${code ?? pactCode}, data: ${data ?? envData}, sender: $sender, networkId: $networkId, chainId: $chainId, gasLimit: $gasLimit, gasPrice: $gasPrice, signingPubKey: $signingPubKey, ttl: $ttl, caps: $caps}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignRequest &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          data == other.data &&
          sender == other.sender &&
          networkId == other.networkId &&
          chainId == other.chainId &&
          gasLimit == other.gasLimit &&
          gasPrice == other.gasPrice &&
          signingPubKey == other.signingPubKey &&
          ttl == other.ttl &&
          caps == other.caps;

  @override
  int get hashCode =>
      code.hashCode ^
      data.hashCode ^
      sender.hashCode ^
      networkId.hashCode ^
      chainId.hashCode ^
      gasLimit.hashCode ^
      gasPrice.hashCode ^
      signingPubKey.hashCode ^
      ttl.hashCode ^
      caps.hashCode;
}

@JsonSerializable(includeIfNull: false)
class SignResult {
  /// The signed pact command.
  /// 'body' is the official name in the Kadena Wallet Signing API spec.
  /// body and/or signedCmd will be set.
  final PactCommand? body;

  /// The signed pact command.
  /// This is the implementation based on eckoWallet.
  /// body and/or signedCmd will be set.
  final PactCommand? signedCmd;

  /// The error message if the signing failed.
  final SignRequestError? error;

  SignResult({
    this.body,
    this.signedCmd,
    this.error,
  });

  factory SignResult.fromJson(Map<String, dynamic> json) => _$SignResultFromJson(json);

  Map<String, dynamic> toJson() => _$SignResultToJson(this);

  @override
  String toString() {
    return '{body: $body, signedCmd: $signedCmd}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignResult &&
          runtimeType == other.runtimeType &&
          body == other.body &&
          signedCmd == other.signedCmd &&
          error == other.error;

  @override
  int get hashCode => body.hashCode ^ signedCmd.hashCode ^ error.hashCode;
}

@JsonSerializable(includeIfNull: false)
class SignRequestError {
  /// The error message
  final String msg;

  SignRequestError({
    required this.msg,
  });

  factory SignRequestError.fromJson(Map<String, dynamic> json) => _$SignRequestErrorFromJson(json);

  Map<String, dynamic> toJson() => _$SignRequestErrorToJson(this);

  @override
  String toString() {
    return '{msg: $msg}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SignRequestError && runtimeType == other.runtimeType && msg == other.msg;

  @override
  int get hashCode => msg.hashCode;
}
