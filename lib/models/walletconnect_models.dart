import 'package:json_annotation/json_annotation.dart';

part 'walletconnect_models.g.dart';

@JsonSerializable(includeIfNull: false)
class AccountRequest {
  /// The WalletConnect CAIP-10 account
  final String account;

  /// The contracts that the wallet should return kadena accounts for.
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
    return '{account: $account, contracts: $contracts}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountRequest &&
          runtimeType == other.runtimeType &&
          account == other.account &&
          contracts == other.contracts;

  @override
  int get hashCode => account.hashCode ^ contracts.hashCode;
}

@JsonSerializable(includeIfNull: false)
class GetAccountsRequest {
  /// The list of accounts that the wallet should return kadena accounts for.
  final List<AccountRequest> accounts;

  GetAccountsRequest({
    required this.accounts,
  });

  factory GetAccountsRequest.fromJson(Map<String, dynamic> json) =>
      _$GetAccountsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetAccountsRequestToJson(this);

  @override
  String toString() {
    return '{accounts: $accounts}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetAccountsRequest &&
          runtimeType == other.runtimeType &&
          accounts == other.accounts;

  @override
  int get hashCode => accounts.hashCode;
}

@JsonSerializable(includeIfNull: false)
class KadenaAccount {
  /// The account name on the chain
  /// This will generally be a k: account
  /// Example: k:abc123
  final String name;

  /// The contract that this account is associated with
  /// Example: coin
  final String contract;

  /// The chains that this account exists on
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
    return '{name: $name, contract: $contract, chains: $chains}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KadenaAccount &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          contract == other.contract &&
          chains == other.chains;

  @override
  int get hashCode => name.hashCode ^ contract.hashCode ^ chains.hashCode;
}

@JsonSerializable(includeIfNull: false)
class AccountResponse {
  /// The WalletConnect CAIP-10 account
  /// Example: kadena:mainnet01:abc123
  final String account;

  /// The public key of the account
  /// Example abc123
  final String publicKey;

  /// The list of Kadena accounts associated with the public key
  /// along with the chain the account exists on.
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
    return '{account: $account, publicKey: $publicKey, kadenaAccounts: $kadenaAccounts}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountResponse &&
          runtimeType == other.runtimeType &&
          account == other.account &&
          publicKey == other.publicKey &&
          kadenaAccounts == other.kadenaAccounts;

  @override
  int get hashCode =>
      account.hashCode ^ publicKey.hashCode ^ kadenaAccounts.hashCode;
}

@JsonSerializable(includeIfNull: false)
class GetAccountsResponse {
  /// The list of accounts that the wallet has private keys for.
  final List<AccountResponse> accounts;

  GetAccountsResponse({
    required this.accounts,
  });

  factory GetAccountsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAccountsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAccountsResponseToJson(this);

  @override
  String toString() {
    return '{accounts: $accounts}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetAccountsResponse &&
          runtimeType == other.runtimeType &&
          accounts == other.accounts;

  @override
  int get hashCode => accounts.hashCode;
}
