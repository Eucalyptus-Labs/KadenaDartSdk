// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'walletconnect_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountRequest _$AccountRequestFromJson(Map<String, dynamic> json) =>
    AccountRequest(
      account: json['account'] as String,
      contracts: (json['contracts'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AccountRequestToJson(AccountRequest instance) {
  final val = <String, dynamic>{
    'account': instance.account,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('contracts', instance.contracts);
  return val;
}

GetAccountsRequest _$GetAccountsRequestFromJson(Map<String, dynamic> json) =>
    GetAccountsRequest(
      accounts: (json['accounts'] as List<dynamic>)
          .map((e) => AccountRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAccountsRequestToJson(GetAccountsRequest instance) =>
    <String, dynamic>{
      'accounts': instance.accounts,
    };

KadenaAccount _$KadenaAccountFromJson(Map<String, dynamic> json) =>
    KadenaAccount(
      name: json['name'] as String,
      contract: json['contract'] as String,
      chains:
          (json['chains'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$KadenaAccountToJson(KadenaAccount instance) =>
    <String, dynamic>{
      'name': instance.name,
      'contract': instance.contract,
      'chains': instance.chains,
    };

AccountResponse _$AccountResponseFromJson(Map<String, dynamic> json) =>
    AccountResponse(
      account: json['account'] as String,
      publicKey: json['publicKey'] as String,
      kadenaAccounts: (json['kadenaAccounts'] as List<dynamic>)
          .map((e) => KadenaAccount.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AccountResponseToJson(AccountResponse instance) =>
    <String, dynamic>{
      'account': instance.account,
      'publicKey': instance.publicKey,
      'kadenaAccounts': instance.kadenaAccounts,
    };

GetAccountsResponse _$GetAccountsResponseFromJson(Map<String, dynamic> json) =>
    GetAccountsResponse(
      accounts: (json['accounts'] as List<dynamic>)
          .map((e) => AccountResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAccountsResponseToJson(
        GetAccountsResponse instance) =>
    <String, dynamic>{
      'accounts': instance.accounts,
    };
