import 'package:json_annotation/json_annotation.dart';

part 'walletconnect_models.g.dart';

@JsonSerializable(includeIfNull: false)
class AccountRequest {
  final String account;
  final List<String>? contracts;

  AccountRequest({
    required this.account,
    this.contracts,
  });

  factory AccountRequest.fromJson(Map<String, dynamic> json) =>
      _$AccountRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AccountRequestToJson(this);

  @override
  String toString() {
    return 'AccountRequest{account: $account, contracts: $contracts}';
  }
}

@JsonSerializable(includeIfNull: false)
class GetAccountsRequest {
  final List<AccountRequest> accounts;

  GetAccountsRequest({
    required this.accounts,
  });

  factory GetAccountsRequest.fromJson(Map<String, dynamic> json) =>
      _$GetAccountsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetAccountsRequestToJson(this);

  @override
  String toString() {
    return 'GetAccountsRequest{accounts: $accounts}';
  }
}

@JsonSerializable(includeIfNull: false)
class KadenaAccount {
  final String name;
  final String contract;
  final List<String> chains;

  KadenaAccount({
    required this.name,
    required this.contract,
    required this.chains,
  });

  factory KadenaAccount.fromJson(Map<String, dynamic> json) =>
      _$KadenaAccountFromJson(json);

  Map<String, dynamic> toJson() => _$KadenaAccountToJson(this);

  @override
  String toString() {
    return 'KadenaAccount{name: $name, contract: $contract, chains: $chains}';
  }
}

@JsonSerializable(includeIfNull: false)
class AccountResponse {
  final String account;
  final String publicKey;
  final List<KadenaAccount> kadenaAccounts;

  AccountResponse({
    required this.account,
    required this.publicKey,
    required this.kadenaAccounts,
  });

  factory AccountResponse.fromJson(Map<String, dynamic> json) =>
      _$AccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AccountResponseToJson(this);

  @override
  String toString() {
    return 'AccountResponse{account: $account, publicKey: $publicKey, kadenaAccounts: $kadenaAccounts}';
  }
}

@JsonSerializable(includeIfNull: false)
class GetAccountsResponse {
  final List<AccountResponse> accounts;

  GetAccountsResponse({
    required this.accounts,
  });

  factory GetAccountsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAccountsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAccountsResponseToJson(this);

  @override
  String toString() {
    return 'GetAccountsResponse{accounts: $accounts}';
  }
}
