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

  Signer toSigner({
    bool includePubKey = false,
    bool includeSig = true,
  }) {
    return Signer(
      pubKey: includePubKey ? pubKey : null,
      sig: includeSig ? sig : null,
    );
  }

  factory QuicksignSigner.fromJson(Map<String, dynamic> json) =>
      _$QuicksignSignerFromJson(json);

  Map<String, dynamic> toJson() => _$QuicksignSignerToJson(this);

  @override
  String toString() {
    return 'QuicksignSigner{pubKey: $pubKey, sig: $sig}';
  }
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

  @override
  String toString() {
    return 'CommandSigData{cmd: $cmd, sigs: $sigs}';
  }
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

  @override
  String toString() {
    return 'QuicksignOutcome{result: $result, hash: $hash, msg: $msg}';
  }
}

class QuicksignResponsePactCommand {
  final String? msg;
  final PactCommand? pactCommand;

  QuicksignResponsePactCommand({
    this.msg,
    this.pactCommand,
  });

  @override
  String toString() {
    return 'QuicksignResponsePactCommand{msg: $msg, pactCommand: $pactCommand}';
  }
}

@JsonSerializable()
class QuicksignResponse {
  static const missingSignatures = 'Missing signatures';

  CommandSigData commandSigData;
  QuicksignOutcome outcome;

  QuicksignResponse({
    required this.commandSigData,
    required this.outcome,
  });

  QuicksignResponsePactCommand toPactCommand() {
    // If there was an error, return null
    if (outcome.result != QuicksignOutcome.success) {
      return QuicksignResponsePactCommand(
        msg: '${outcome.result}: ${outcome.msg}',
      );
    }

    // If any of the signers have no sig, return null
    if (commandSigData.sigs.any((e) => e.sig == null)) {
      return QuicksignResponsePactCommand(
        msg: missingSignatures,
      );
    }

    return QuicksignResponsePactCommand(
      pactCommand: PactCommand(
        cmd: commandSigData.cmd,
        sigs: commandSigData.sigs.map((e) => e.toSigner()).toList(),
        hash: outcome.hash!,
      ),
    );
  }

  factory QuicksignResponse.fromJson(Map<String, dynamic> json) =>
      _$QuicksignResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuicksignResponseToJson(this);

  @override
  String toString() {
    return 'QuicksignResponse{commandSigData: $commandSigData, outcome: $outcome}';
  }
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

  @override
  String toString() {
    return 'QuicksignError{type: $type, msg: $msg}';
  }
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

  @override
  String toString() {
    return 'QuicksignRequest{commandSigDatas: $commandSigDatas}';
  }
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

  @override
  String toString() {
    return 'QuicksignResult{responses: $responses, error: $error}';
  }
}
