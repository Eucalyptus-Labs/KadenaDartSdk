## 2.3.3

- added fix for kadena cont transaction

## 2.3.2

- removed dependency on Flutter sdk from main code
- added deep equality utils to compare models

## 2.3.1

- updated dependencies
- updated dart sdk to 3.0.5

## 2.3.0

- updated dependencies
- updated dart sdk to >3.0.0


## 2.2.1

- Added `==` and `hashCode` to all models

## 2.2.0

- Added `buildEndpoint` to `IPactApiV1` interface, and updated `buildUrl` to return the full path to the Pact API with the endpoint.
- Fixed bugs with local where the query parameters were not being added to the URL
- Updated tests
- Added nodeUrl and networkId overrides to all Pact API functions

## 2.1.5

- Added `setNetworkId` and `getNodeUrl` to `IPactApiV1` interface and updated implementation

## 2.1.4

- Added `getNetworkId` to `IPactApiV1` interface and updated implementation
- Made `ExecCommand` `data` field not required, and default to blank

## 2.1.3

- Made `sig` in QuicksignSigner not be required

## 2.1.2

- Added `toSigner` to `QuicksignSigner` class
- Added `toPactCommand` to `QuicksignResponse` class. It returns a `QuicksignResponsePactCommand` object, which will have a `pactCommand` if the outcome was successful and all signatures are satisfied, and a msg if there was an error or the signatures are not satisfied

## 2.1.1

- Added signingPubKey to `constructPactCommandPayload`
- Made multiple values in `SignRequest` optional, and removed all defaults
- Added defaults to `CommandMetadata`
- If caps is empty, the `clist` in the PactCommandPayload will not exist now, so you can do unrestricted signing

## 2.1.0

- Pact API rework and tests added
- Sign API rework based on Pact API to make sure sig and hash are correct

## 2.0.5

- Updated sign API to double encode the cmd so that it matches the PactCommand's cmd string exactly

## 2.0.4

- Added `envData` and `pactCode` to the SigningRequest model

## 2.0.3

- Added defaults for `creationTime` and `nonce`

## 2.0.2

- Added KIP17 `kadena_getAccounts_v1` models for WalletConnect

## 2.0.1

- Fixed bug with QuicksignSigner

## 2.0.0

- Changes to sign function in the SigningApi class so you can parse -> Pact Command Payload -> Sign
- Added function to sign individual CommandSigData from a QuicksignRequest so wallets can display each and sign each individually
- Bug fixes and test updates

## 1.0.1

- Updated readme to give correct quickstart guide

## 1.0.0

* Initial Release
