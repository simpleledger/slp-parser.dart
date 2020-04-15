# SLP Parser for Dart

This package is for parsing [Simple Ledger Protocol (SLP)](https://github.com/simpleledger/slp-specifications) metadata. TokenType1 and NFT1 tokens are supported.


## Usage

```
var List<int> op_return = [ 106, 4, 83, 76, 80, 0, 1, 1, 7, 
                            71, 69, 78, 69, 83, 73, 83, 76, 
                            0, 76, 0, 76, 0, 76, 0, 1, 0, 76, 
                            0, 8, 0, 0, 0, 0, 0, 0, 0, 100 ];
var slpMsg = parseSLP(op_return);
```

## Test

`$ dart test/parser.spec.dart`

