import 'dart:convert';
import 'package:convert/convert.dart';

final testdata = [
 {
  "msg": "OK: minimal GENESIS",
  "script": "6a04534c500001010747454e455349534c004c004c004c0001004c00080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "GENESIS",
    "data": {
      "ticker": utf8.encode(''),
      "name": utf8.encode(''),
      "documentUri": utf8.encode(''),
      "documentHash": hex.decode(''),
      "decimals": 0,
      "mintBatonVout": 0,
      "qty": "100"
    }
  }
 },
 {
  "msg": "OK: minimal GENESIS for token_type=41",
  "script": "6a04534c500001410747454e455349534c004c004c004c0001004c00080000000000000001",
  "code": null,
  "parsed": {
    "tokenType": 0x41,
    "transactionType": "GENESIS",
    "data": {
      "ticker": utf8.encode(''),
      "name": utf8.encode(''),
      "documentUri": utf8.encode(''),
      "documentHash": utf8.encode(''),
      "decimals": 0,
      "mintBatonVout": 0,
      "qty": "1"
    }
  }
 },
 {
  "msg": "OK: minimal GENESIS for token_type=81",
  "script": "6a04534c500001810747454e455349534c004c004c004c0001004c00080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x81,
    "transactionType": "GENESIS",
    "data": {
      "ticker": utf8.encode(''),
      "name": utf8.encode(''),
      "documentUri": utf8.encode(''),
      "documentHash": utf8.encode(''),
      "decimals": 0,
      "mintBatonVout": 0,
      "qty": "100"
    }
  }
 },
 {
  "msg": "OK: minimal large GENESIS",
  "script": "6a04534c500001010747454e455349534c004c004c004c0001004c0008000347943532e324",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "GENESIS",
    "data": {
      "ticker": utf8.encode(''),
      "name": utf8.encode(''),
      "documentUri": utf8.encode(''),
      "documentHash": utf8.encode(''),
      "decimals": 0,
      "mintBatonVout": 0,
      "qty": "923126803391268"
    }
  }
 },
 {
  "msg": "OK: typical MINT without baton",
  "script": "6a04534c50000101044d494e5420ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff4c00080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "MINT",
    "data": {
      "tokenId": 'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
      "mintBatonVout": 0,
      "qty": "100"
    }
  }
 },
 {
  "msg": "OK: typical MINT without baton for token_type=81",
  "script": "6a04534c50000181044d494e5420ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff4c00080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x81,
    "transactionType": "MINT",
    "data": {
      "tokenId": 'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
      "mintBatonVout": 0,
      "qty": "100"
    }
  }
 },
 {
  "msg": "(must be invalid: impossible state): typical MINT without baton for token_type=41",
  "script": "6a04534c50000141044d494e5420ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff4c00080000000000000064",
  "code": 23
 },
 {
  "msg": "OK: typical large MINT without baton",
  "script": "6a04534c50000101044d494e5420ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff4c0008000347943532e324",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "MINT",
    "data": {
      "tokenId": 'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
      "mintBatonVout": 0,
      "qty": "923126803391268"
    }
  }
 },
 {
  "msg": "OK: typical 1-output SEND",
  "script": "6a04534c500001010453454e44208888888888888888888888888888888888888888888888888888888888888888080000000000000042",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "SEND",
    "data": {
      "tokenId": '8888888888888888888888888888888888888888888888888888888888888888',
      "amounts": ["66"]
    }
  }
 },
 {
  "msg": "OK: typical 1-output large SEND",
  "script": "6a04534c500001010453454e4420888888888888888888888888888888888888888888888888888888888888888808000347943532e324",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "SEND",
    "data": {
      "tokenId": '8888888888888888888888888888888888888888888888888888888888888888',
      "amounts": ["923126803391268"]
    }
  }
 },
 {
  "msg": "OK: typical 2-output SEND",
  "script": "6a04534c500001010453454e44208888888888888888888888888888888888888888888888888888888888888888080000000000000042080000000000000063",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "SEND",
    "data": {
      "tokenId": '8888888888888888888888888888888888888888888888888888888888888888',
      "amounts": ["66", "99"]
    }
  }
 },
 {
  "msg": "OK: typical SEND for token_type=41",
  "script": "6a04534c500001410453454e44208888888888888888888888888888888888888888888888888888888888888888080000000000000001",
  "code": null,
  "parsed": {
    "tokenType": 0x41,
    "transactionType": "SEND",
    "data": {
      "tokenId": '8888888888888888888888888888888888888888888888888888888888888888',
      "amounts": ["1"]
    }
  }
 },
 {
  "msg": "OK: typical SEND for token_type=81",
  "script": "6a04534c500001810453454e44208888888888888888888888888888888888888888888888888888888888888888080000000000000001",
  "code": null,
  "parsed": {
    "tokenType": 0x81,
    "transactionType": "SEND",
    "data": {
      "tokenId": '8888888888888888888888888888888888888888888888888888888888888888',
      "amounts": ["1"]
    }
  }
 },
 {
  "msg": "Script ending mid-PUSH (one byte short) must be SLP-invalid",
  "script": "6a04534c500001010747454e455349534c004c004c004c0001004c000800000000000064",
  "code": 1
 },
 {
  "msg": "Script ending mid-PUSH (no length) must be SLP-invalid",
  "script": "6a04534c500001010747454e455349534c004c004c004c0001004c004c",
  "code": 1
 },
 {
  "msg": "Script ending mid-PUSH (length is one byte short) must be SLP-invalid",
  "script": "6a04534c500001010747454e455349534c004c004c004c0001004c004d00",
  "code": 1
 },
 {
  "msg": "(must be invalid: forbidden opcode): uses opcode OP_0",
  "script": "6a04534c500001010747454e455349534c00004c004c0001004c00080000000000000064",
  "code": 2
 },
 {
  "msg": "(must be invalid: forbidden opcode): uses opcode OP_1",
  "script": "6a04534c5000510747454e455349534c004c004c004c0001004c00080000000000000064",
  "code": 2
 },
 {
  "msg": "(must be invalid: forbidden opcode): uses opcode OP_1NEGATE",
  "script": "6a04534c50004f0747454e455349534c004c004c004c0001004c00080000000000000064",
  "code": 2
 },
 {
  "msg": "(must be invalid: forbidden opcode): uses opcode 0x50",
  "script": "6a04534c5000500747454e455349534c004c004c004c0001004c00080000000000000064",
  "code": 2
 },
 {
  "msg": "(not SLP): p2pkh address script",
  "script": "76a914ffffffffffffffffffffffffffffffffffffffff88ac",
  "code": 3
 },
 {
  "msg": "(not SLP): empty op_return",
  "script": "6a",
  "code": 3
 },
 {
  "msg": "(not SLP): first push is 9-byte 'yours.org'",
  "script": "6a09796f7572732e6f7267",
  "code": 3
 },
 {
  "msg": "(not SLP): first push is 4-byte '\\x00BET'",
  "script": "6a0400424554",
  "code": 3
 },
 {
  "msg": "(not SLP): first push is 4-byte '\\x00SLP'",
  "script": "6a0400534c5001010747454e455349534c004c004c004c0001004c00080000000000000064",
  "code": 3
 },
 {
  "msg": "(not SLP): first push is 3-byte 'SLP'",
  "script": "6a03534c5001010747454e455349534c004c004c004c0001004c00080000000000000064",
  "code": 3
 },
 {
  "msg": "(not SLP): first push is 5-byte 'SLP\\x00\\x00'",
  "script": "6a05534c50000001010747454e455349534c004c004c004c0001004c00080000000000000064",
  "code": 3
 },
 {
  "msg": "(not SLP): first push is 7-byte '\\xef\\xbb\\xbfSLP\\x00' (UTF8 byte order mark + 'SLP\\x00')",
  "script": "6a07efbbbf534c500001010747454e455349534c004c004c004c0001004c00080000000000000064",
  "code": 3
 },
 {
  "msg": "OK: lokad pushed using PUSHDATA1",
  "script": "6a4c04534c500001010747454e455349534c004c004c004c0001004c00080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "GENESIS",
    "data": {
      "ticker": utf8.encode(''),
      "name": utf8.encode(''),
      "documentUri": utf8.encode(''),
      "documentHash": utf8.encode(''),
      "decimals": 0,
      "mintBatonVout": 0,
      "qty": "100"
    }
  }
 },
 {
  "msg": "OK: lokad pushed using PUSHDATA2",
  "script": "6a4d0400534c500001010747454e455349534c004c004c004c0001004c00080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "GENESIS",
    "data": {
      "ticker": utf8.encode(''),
      "name": utf8.encode(''),
      "documentUri": utf8.encode(''),
      "documentHash": utf8.encode(''),
      "decimals": 0,
      "mintBatonVout": 0,
      "qty": "100"
    }
  }
 },
 {
  "msg": "OK: lokad pushed using PUSHDATA4",
  "script": "6a4e04000000534c500001010747454e455349534c004c004c004c0001004c00080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "GENESIS",
    "data": {
      "ticker": utf8.encode(''),
      "name": utf8.encode(''),
      "documentUri": utf8.encode(''),
      "documentHash": utf8.encode(''),
      "decimals": 0,
      "mintBatonVout": 0,
      "qty": "100"
    }
  }
 },
 {
  "msg": "OK: 2 bytes for token_type=1",
  "script": "6a04534c50000200010747454e455349534c004c004c004c0001004c00080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "GENESIS",
    "data": {
      "ticker": utf8.encode(''),
      "name": utf8.encode(''),
      "documentUri": utf8.encode(''),
      "documentHash": utf8.encode(''),
      "decimals": 0,
      "mintBatonVout": 0,
      "qty": "100"
    }
  }
 },
 {
  "msg": "OK: can have more than 1 SLP output for token_type=41 (we check quantity <=1 in tx_input_tests.py)",
  "script": "6a04534c500001410453454e44208888888888888888888888888888888888888888888888888888888888888888080000000000000001080000000000000001",
  "code": null,
  "parsed": {
    "tokenType": 0x41,
    "transactionType": "SEND",
    "data": {
      "tokenId": '8888888888888888888888888888888888888888888888888888888888888888',
      "amounts": ["1", "1"]
    }
  }
 },
 {
  "msg": "(unsupported token type, must be token_type=1, 65, or 129): 2 bytes for token_type=2",
  "script": "6a04534c50000200020747454e455349534c004c004c004c0001004c00080000000000000064",
  "code": 255
 },
 {
  "msg": "(must be invalid: wrong size): 3 bytes for token_type",
  "script": "6a04534c5000030000010747454e455349534c004c004c004c0001004c00080000000000000064",
  "code": 10
 },
 {
  "msg": "(must be invalid: wrong size): 0 bytes for token_type",
  "script": "6a04534c50004c000747454e455349534c004c004c004c0001004c00080000000000000064",
  "code": 10
 },
 {
  "msg": "(must be invalid: too short): stopped after lokad ID",
  "script": "6a04534c5000",
  "code": 12
 },
 {
  "msg": "(must be invalid: too short): stopped after token_type",
  "script": "6a04534c50000101",
  "code": 12
 },
 {
  "msg": "(must be invalid: too short): stopped after transaction_type GENESIS",
  "script": "6a04534c500001010747454e45534953",
  "code": 12
 },
 {
  "msg": "(must be invalid: too short): stopped after transaction_type MINT",
  "script": "6a04534c50000101044d494e54",
  "code": 12
 },
 {
  "msg": "(must be invalid: too short): stopped after transaction_type SEND",
  "script": "6a04534c500001010453454e44",
  "code": 12
 },
 {
   "msg": "(must be invalid: bad value): transaction_type null",
   "script": "6a04534c500001014c004c00080000000000000064",
   "code": 11
 },
 {
  "msg": "(must be invalid: bad value): transaction_type 'INIT'",
  "script": "6a04534c5000010104494e49544c004c004c004c0001004c00080000000000000064",
  "code": 11
 },
 {
  "msg": "(must be invalid: bad value): transaction_type 'TRAN'",
  "script": "6a04534c50000101045452414e208888888888888888888888888888888888888888888888888888888888888888080000000000000042",
  "code": 11
 },
 {
  "msg": "(must be invalid: bad value): transaction_type 'send'",
  "script": "6a04534c500001010473656e64208888888888888888888888888888888888888888888888888888888888888888080000000000000042",
  "code": 11
 },
 {
  "msg": "(must be invalid: bad value): transaction_type 'SENÄ'",
  "script": "6a04534c500001010453454eC4208888888888888888888888888888888888888888888888888888888888888888080000000000000042",
  "code": 11
 },
 {
  "msg": "(must be invalid: bad value): transaction_type = 7-byte '\\xef\\xbb\\xbfSEND' (UTF8 byte order mark + 'SEND')",
  "script": "6a04534c5000010107efbbbf53454e44208888888888888888888888888888888888888888888888888888888888888888080000000000000042",
  "code": 11
 },
 {
  "msg": "(must be invalid: bad value): transaction_type = 10-byte UTF16 'SEND' (incl. BOM)",
  "script": "6a04534c500001010afffe530045004e004400208888888888888888888888888888888888888888888888888888888888888888080000000000000042",
  "code": 11
 },
 {
  "msg": "(must be invalid: bad value): transaction_type = 20-byte UTF32 'SEND' (incl. BOM)",
  "script": "6a04534c5000010114fffe000053000000450000004e00000044000000208888888888888888888888888888888888888888888888888888888888888888080000000000000042",
  "code": 11
 },
 {
  "msg": "OK: 8-character ticker 'NAKAMOTO' ascii",
  "script": "6a04534c500001010747454e45534953084e414b414d4f544f4c004c004c0001094c00080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "GENESIS",
    "data": {
      "ticker": utf8.encode('NAKAMOTO'),
      "name": utf8.encode(''),
      "documentUri": utf8.encode(''),
      "documentHash": utf8.encode(''),
      "decimals": 9,
      "mintBatonVout": 0,
      "qty": "100"
    }
  }
 },
 {
  "msg": "OK: 9-character ticker 'Satoshi_N' ascii",
  "script": "6a04534c500001010747454e45534953095361746f7368695f4e4c004c004c0001094c00080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "GENESIS",
    "data": {
      "ticker": utf8.encode('Satoshi_N'),
      "name": utf8.encode(''),
      "documentUri": utf8.encode(''),
      "documentHash": utf8.encode(''),
      "decimals": 9,
      "mintBatonVout": 0,
      "qty": "100"
    }
  }
 },
 {
  "msg": "OK: 2-character ticker '\u4e2d\u672c' ('nakamoto' kanji) -- 6 bytes utf8",
  "script": "6a04534c500001010747454e4553495306e4b8ade69cac4c004c004c0001094c00080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "GENESIS",
    "data": {
      "ticker": hex.decode('e4b8ade69cac'),
      "name": utf8.encode(''),
      "documentUri": utf8.encode(''),
      "documentHash": utf8.encode(''),
      "decimals": 9,
      "mintBatonVout": 0,
      "qty": "100"
    }
  }
 },
 {
  "msg": "OK: 4-character ticker '\u30ca\u30ab\u30e2\u30c8' ('nakamoto' katakana) -- 12 bytes utf8",
  "script": "6a04534c500001010747454e455349530ce3838ae382abe383a2e383884c004c004c0001094c00080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "GENESIS",
    "data": {
      "ticker": hex.decode('e3838ae382abe383a2e38388'),
      "name": utf8.encode(''),
      "documentUri": utf8.encode(''),
      "documentHash": utf8.encode(''),
      "decimals": 9,
      "mintBatonVout": 0,
      "qty": "100"
    }
  }
 },
 {
  "msg": "(must be invalid: wrong size): Genesis with 0-byte decimals",
  "script": "6a04534c500001010747454e455349534c004c004c004c004c004c00080000000000000064",
  "code": 10
 },
 {
  "msg": "(must be invalid: wrong size): Genesis with 2-byte decimals",
  "script": "6a04534c500001010747454e455349534c004c004c004c000200004c00080000000000000064",
  "code": 10
 },
 {
  "msg": "OK: Genesis with 32-byte dochash",
  "script": "6a04534c500001010747454e455349534c004c004c0020ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff01004c00080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "GENESIS",
    "data": {
      "ticker": utf8.encode(''),
      "name": utf8.encode(''),
      "documentUri": utf8.encode(''),
      "documentHash": hex.decode('ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'),
      "decimals": 0,
      "mintBatonVout": 0,
      "qty": "100"
    }
  }
 },
 {
  "msg": "(must be invalid: wrong size): Genesis with 31-byte dochash",
  "script": "6a04534c500001010747454e455349534c004c004c001fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff01004c00080000000000000064",
  "code": 10
 },
 {
  "msg": "(must be invalid: wrong size): Genesis with 33-byte dochash",
  "script": "6a04534c500001010747454e455349534c004c004c0021ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff01004c00080000000000000064",
  "code": 10
 },
 {
  "msg": "(must be invalid: wrong size): Genesis with 64-byte dochash",
  "script": "6a04534c500001010747454e455349534c004c004c0040ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff01004c00080000000000000064",
  "code": 10
 },
 {
  "msg": "(must be invalid: wrong size): Genesis with 20-byte dochash",
  "script": "6a04534c500001010747454e455349534c004c004c0014ffffffffffffffffffffffffffffffffffffffff01004c00080000000000000064",
  "code": 10
 },
 {
  "msg": "(must be invalid: wrong size): SEND with 0-byte token_id",
  "script": "6a04534c500001010453454e444c00080000000000000064",
  "code": 10
 },
 {
  "msg": "(must be invalid: wrong size): SEND with 31-byte token_id",
  "script": "6a04534c500001010453454e441fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff080000000000000064",
  "code": 10
 },
 {
  "msg": "(must be invalid: wrong size): SEND with 33-byte token_id",
  "script": "6a04534c500001010453454e4421ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff080000000000000064",
  "code": 10
 },
 {
  "msg": "(must be invalid: wrong size): MINT with 0-byte token_id",
  "script": "6a04534c50000101044d494e544c004c00080000000000000064",
  "code": 10
 },
 {
  "msg": "(must be invalid: wrong size): MINT with 31-byte token_id",
  "script": "6a04534c50000101044d494e541fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff4c00080000000000000064",
  "code": 10
 },
 {
  "msg": "(must be invalid: wrong size): MINT with 32-byte token_id",
  "script": "6a04534c50000101044d494e5421ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff4c00080000000000000064",
  "code": 10
 },
 {
  "msg": "(must be invalid: wrong size): SEND with a 7-byte amount",
  "script": "6a04534c500001010453454e442088888888888888888888888888888888888888888888888888888888888888880800000000000000630700000000000042080000000000000063",
  "code": 10
 },
 {
  "msg": "(must be invalid: wrong size): SEND with a 9-byte amount",
  "script": "6a04534c500001010453454e4420888888888888888888888888888888888888888888888888888888888888888808000000000000006309000000000000000042080000000000000063",
  "code": 10
 },
 {
  "msg": "(must be invalid: wrong size): SEND with a 0-byte amount",
  "script": "6a04534c500001010453454e442088888888888888888888888888888888888888888888888888888888888888880800000000000000634c00080000000000000063",
  "code": 10
 },
 {
  "msg": "OK: Genesis with decimals=9",
  "script": "6a04534c500001010747454e455349534c004c004c004c0001094c00080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "GENESIS",
    "data": {
      "ticker": utf8.encode(''),
      "name": utf8.encode(''),
      "documentUri": utf8.encode(''),
      "documentHash": utf8.encode(''),
      "decimals": 9,
      "mintBatonVout": 0,
      "qty": "100"
    }
  }
 },
 {
  "msg": "(must be invalid: bad value): Genesis with decimals=10",
  "script": "6a04534c500001010747454e455349534c004c004c004c00010a4c00080000000000000064",
  "code": 11
 },
 {
  "msg": "OK: Genesis with mint_baton_vout=255",
  "script": "6a04534c500001010747454e455349534c004c004c004c00010001ff080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "GENESIS",
    "data": {
      "ticker": utf8.encode(''),
      "name": utf8.encode(''),
      "documentUri": utf8.encode(''),
      "documentHash": utf8.encode(''),
      "decimals": 0,
      "mintBatonVout": 255,
      "qty": "100"
    }
  }
 },
 {
   "msg": "(must be invalid: bad value): NFT1 Child Genesis with mint_baton_vout!==null",
   "script": "6a04534c500001410747454e455349534c004c0001c04c0001000102080000000000000001",
   "code": 22
 },
 {
   "msg": "(must be invalid: bad value): NFT1 Child Genesis with divisibility!==0",
   "script": "6a04534c500001410747454e455349534c004c0001c04c0001094c00080000000000000001",
   "code": 22
 },
 {
   "msg": "(must be invalid: bad value): NFT1 Child Genesis with quanitity!==1",
   "script": "6a04534c50000200410747454e455349534c004c004c004c0001004c00080000000000000064",
   "code": 22
 },
 {
  "msg": "OK: Genesis with mint_baton_vout=95",
  "script": "6a04534c500001010747454e455349534c004c004c004c000100015f080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "GENESIS",
    "data": {
      "ticker": utf8.encode(''),
      "name": utf8.encode(''),
      "documentUri": utf8.encode(''),
      "documentHash": utf8.encode(''),
      "decimals": 0,
      "mintBatonVout": 95,
      "qty": "100"
    }
  }
 },
 {
  "msg": "OK: Genesis with mint_baton_vout=2",
  "script": "6a04534c500001010747454e455349534c004c004c004c0001000102080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "GENESIS",
    "data": {
      "ticker": utf8.encode(''),
      "name": utf8.encode(''),
      "documentUri": utf8.encode(''),
      "documentHash": utf8.encode(''),
      "decimals": 0,
      "mintBatonVout": 2,
      "qty": "100"
    }
  }
 },
 {
  "msg": "(must be invalid: bad value): Genesis with mint_baton_vout=1",
  "script": "6a04534c500001010747454e455349534c004c004c004c0001000101080000000000000064",
  "code": 11
 },
 {
  "msg": "(must be invalid: bad value): Genesis with mint_baton_vout=0",
  "script": "6a04534c500001010747454e455349534c004c004c004c0001000100080000000000000064",
  "code": 11
 },
 {
  "msg": "OK: MINT with mint_baton_vout=255",
  "script": "6a04534c50000101044d494e5420ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff01ff080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "MINT",
    "data": {
      "tokenId": 'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
      "mintBatonVout": 255,
      "qty": "100"
    }
  }
 },
 {
  "msg": "OK: MINT with mint_baton_vout=95",
  "script": "6a04534c50000101044d494e5420ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff015f080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "MINT",
    "data": {
      "tokenId": 'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
      "mintBatonVout": 95,
      "qty": "100"
    }
  }
 },
 {
  "msg": "OK: MINT with mint_baton_vout=2",
  "script": "6a04534c50000101044d494e5420ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0102080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "MINT",
    "data": {
      "tokenId": 'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
      "mintBatonVout": 2,
      "qty": "100"
    }
  }
 },
 {
  "msg": "(must be invalid: bad value): MINT with mint_baton_vout=1",
  "script": "6a04534c50000101044d494e5420ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0101080000000000000064",
  "code": 11
 },
 {
  "msg": "(must be invalid: bad value): MINT with mint_baton_vout=0",
  "script": "6a04534c50000101044d494e5420ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0100080000000000000064",
  "code": 11
 },
 {
  "msg": "(must be invalid: wrong number of params) GENESIS with extra token amount",
  "script": "6a04534c500001010747454e455349534c004c004c004c0001004c00080000000000000064080000000000000064",
  "code": 12
 },
 {
  "msg": "(must be invalid: wrong number of params) MINT with extra token amount",
  "script": "6a04534c50000101044d494e5420ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff4c00080000000000000064080000000000000064",
  "code": 12
 },
 {
  "msg": "OK: SEND with 19 token output amounts",
  "script": "6a04534c500001010453454e44208888888888888888888888888888888888888888888888888888888888888888080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "SEND",
    "data": {
      "tokenId": '8888888888888888888888888888888888888888888888888888888888888888',
      "amounts": ["1", "1", "1", "1", "1","1", "1", "1", "1", "1","1", "1", "1", "1", "1","1", "1", "1", "1"]
    }
  }
 },
 {
  "msg": "(must be invalid: too many parameters): SEND with 20 token output amounts",
  "script": "6a04534c500001010453454e44208888888888888888888888888888888888888888888888888888888888888888080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001080000000000000001",
  "code": 21
 },
 {
  "msg": "OK: all output amounts 0",
  "script": "6a04534c500001010453454e44208888888888888888888888888888888888888888888888888888888888888888080000000000000000080000000000000000",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "SEND",
    "data": {
      "tokenId": '8888888888888888888888888888888888888888888888888888888888888888',
      "amounts": ["0", "0"]
    }
  }
 },
 {
  "msg": "OK: three inputs of max value (2**64-1) whose sum overflows a 64-bit int",
  "script": "6a04534c500001010453454e4420888888888888888888888888888888888888888888888888888888888888888808ffffffffffffffff08ffffffffffffffff08ffffffffffffffff",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "SEND",
    "data": {
      "tokenId": '8888888888888888888888888888888888888888888888888888888888888888',
      "amounts": ["18446744073709551615", "18446744073709551615", "18446744073709551615"]
    }
  }
 },
 {
  "msg": "OK: using opcode PUSHDATA1 for 8-byte push",
  "script": "6a04534c500001010747454e455349534c004c004c004c0001004c004c080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "GENESIS",
    "data": {
      "ticker": utf8.encode(''),
      "name": utf8.encode(''),
      "documentUri": utf8.encode(''),
      "documentHash": utf8.encode(''),
      "decimals": 0,
      "mintBatonVout": 0,
      "qty": "100"
    }
  }
 },
 {
  "msg": "OK: using opcode PUSHDATA2 for empty push",
  "script": "6a04534c500001010747454e455349534c004d00004c004c0001004c00080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "GENESIS",
    "data": {
      "ticker": utf8.encode(''),
      "name": utf8.encode(''),
      "documentUri": utf8.encode(''),
      "documentHash": utf8.encode(''),
      "decimals": 0,
      "mintBatonVout": 0,
      "qty": "100"
    }
  }
 },
 {
  "msg": "OK: using opcode PUSHDATA4 for empty push",
  "script": "6a04534c500001010747454e455349534c004e000000004c004c0001004c00080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "GENESIS",
    "data": {
      "ticker": utf8.encode(''),
      "name": utf8.encode(''),
      "documentUri": utf8.encode(''),
      "documentHash": utf8.encode(''),
      "decimals": 0,
      "mintBatonVout": 0,
      "qty": "100"
    }
  }
 },
 {
  "msg": "OK: ticker is bad utf8 E08080 (validators must not require decodeable strings)",
  "script": "6a04534c500001010747454e4553495303e080804c004c004c0001094c00080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "GENESIS",
    "data": {
      "ticker": hex.decode('e08080'),
      "name": utf8.encode(''),
      "documentUri": utf8.encode(''),
      "documentHash": utf8.encode(''),
      "decimals": 9,
      "mintBatonVout": 0,
      "qty": "100"
    }
  }
 },
 {
  "msg": "OK: ticker is bad utf8 C0 (validators must not require decodeable strings)",
  "script": "6a04534c500001010747454e4553495301c04c004c004c0001094c00080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "GENESIS",
    "data": {
      "ticker": hex.decode('c0'),
      "name": utf8.encode(''),
      "documentUri": utf8.encode(''),
      "documentHash": utf8.encode(''),
      "decimals": 9,
      "mintBatonVout": 0,
      "qty": "100"
    }
  }
 },
 {
  "msg": "OK: name is bad utf8 E08080 (validators must not require decodeable strings)",
  "script": "6a04534c500001010747454e455349534c0003e080804c004c0001094c00080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "GENESIS",
    "data": {
      "ticker": utf8.encode(''),
      "name": hex.decode('e08080'),
      "documentUri": utf8.encode(''),
      "documentHash": utf8.encode(''),
      "decimals": 9,
      "mintBatonVout": 0,
      "qty": "100"
    }
  }
 },
 {
  "msg": "OK: name is bad utf8 C0 (validators must not require decodeable strings)",
  "script": "6a04534c500001010747454e455349534c0001c04c004c0001094c00080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "GENESIS",
    "data": {
      "ticker": utf8.encode(''),
      "name": hex.decode('c0'),
      "documentUri": utf8.encode(''),
      "documentHash": utf8.encode(''),
      "decimals": 9,
      "mintBatonVout": 0,
      "qty": "100"
    }
  }
 },
 {
  "msg": "OK: url is bad utf8 E08080 (validators must not require decodeable strings)",
  "script": "6a04534c500001010747454e455349534c004c0003e080804c0001094c00080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "GENESIS",
    "data": {
      "ticker": utf8.encode(''),
      "name": utf8.encode(''),
      "documentUri": hex.decode('e08080'),
      "documentHash": utf8.encode(''),
      "decimals": 9,
      "mintBatonVout": 0,
      "qty": "100"
    }
  }
 },
 {
  "msg": "OK: url is bad utf8 C0 (validators must not require decodeable strings)",
  "script": "6a04534c500001010747454e455349534c004c0001c04c0001094c00080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "GENESIS",
    "data": {
      "ticker": utf8.encode(''),
      "name": utf8.encode(''),
      "documentUri": hex.decode('c0'),
      "documentHash": utf8.encode(''),
      "decimals": 9,
      "mintBatonVout": 0,
      "qty": "100"
    }
  }
 },
 {
  "msg": "OK: genesis with 300-byte name 'UUUUU...' (op_return over 223 bytes, validators must not refuse this)",
  "script": "6a04534c500001010747454e455349534c004d2c015555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555554c004c0001004c00080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "GENESIS",
    "data": {
      "ticker": utf8.encode(''),
      "name": hex.decode('555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555'),
      "documentUri": utf8.encode(''),
      "documentHash": utf8.encode(''),
      "decimals": 0,
      "mintBatonVout": 0,
      "qty": "100"
    }
  }
 },
 {
  "msg": "OK: genesis with 300-byte document url 'UUUUU...' (op_return over 223 bytes, validators must not refuse this)",
  "script": "6a04534c500001010747454e455349534c004c004d2c015555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555554c0001004c00080000000000000064",
  "code": null,
  "parsed": {
    "tokenType": 0x01,
    "transactionType": "GENESIS",
    "data": {
      "ticker": utf8.encode(''),
      "name": utf8.encode(''),
      "documentUri": hex.decode('555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555'),
      "documentHash": utf8.encode(''),
      "decimals": 0,
      "mintBatonVout": 0,
      "qty": "100"
    }
  }
 }
];