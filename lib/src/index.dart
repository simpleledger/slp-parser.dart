import 'dart:typed_data';
import 'dart:convert';
import 'package:convert/convert.dart';

class GenesisParseResult {
  List<int> tickerBuf, nameBuf, documentUriBuf, documentHashBuf;
  int decimals;
  int mintBatonVout;
  BigInt qty;
  String get ticker { return utf8.decode(this.tickerBuf); }
  String get name { return utf8.decode(this.nameBuf); }
  String get documentUri { return utf8.decode(this.documentUriBuf); }
  String get documentHash { return hex.encode(this.documentHashBuf); }
  GenesisParseResult({this.tickerBuf, this.nameBuf, this.documentUriBuf, this.documentHashBuf, this.decimals, this.mintBatonVout, this.qty});
  Map<String, Object> toMap({raw=false}) {
    return {
      "ticker": raw ? this.tickerBuf : this.ticker,
      "name": raw ? this.nameBuf : this.name,
      "documentUri": raw ? this.documentUriBuf : this.documentUri,
      "documentHash": raw ? this.documentHashBuf : this.documentHash,
      "decimals": this.decimals,
      "mintBatonVout": this.mintBatonVout,
      "qty": this.qty
    };
  }
}

class MintParseResult {
  List<int> tokenIdBuf;
  int mintBatonVout;
  BigInt qty;
  String get tokenId { return hex.encode(this.tokenIdBuf); }
  MintParseResult({this.tokenIdBuf, this.mintBatonVout, this.qty});
  Map<String, Object> toMap({raw=false}) {
    return {
      "tokenId": raw ? this.tokenIdBuf : this.tokenId,
      "mintBatonVout": mintBatonVout,
      "qty": this.qty
    };
  }
} 

class SendParseResult {
  List<int> tokenIdBuf;
  List<BigInt> amounts;
  SendParseResult({this.tokenIdBuf, this.amounts});
  String get tokenId { return hex.encode(this.tokenIdBuf); }
  Map<String, Object> toMap({raw=false}) {
    return {
      "tokenId": raw ? this.tokenIdBuf : this.tokenId,
      "amounts": this.amounts
    };
  }
}

class ImpossibleParseResult {
}

class ParseResult {
  int tokenType;
  String transactionType;
  dynamic data; /* GenesisParseResult | MintParseResult | SendParseResult | ImpossibleParseResult */
  ParseResult({this.tokenType, this.transactionType, this.data});
  Map<String, Object> toMap({raw: false}) {
    return {
      "tokenType": tokenType,
      "transactionType": transactionType,
      "data": data.toMap(raw: raw)
    };
  }
}

ParseResult parseSLP(List<int> scriptpubkey) {
  int it = 0;
  var itObj = Uint8List(scriptpubkey.length);
  itObj.setAll(0, scriptpubkey);

  const int OP_0 = 0x00;
  const int OP_RETURN = 0x6a;
  const int OP_PUSHDATA1 = 0x4c;
  const int OP_PUSHDATA2 = 0x4d;
  const int OP_PUSHDATA4 = 0x4e;

  final PARSE_CHECK = /* void */ (bool v , String str ) {
    if (v) {
      throw(str);
    }
  };

  final extractU8 = /* BN */ () {
    var r = itObj.buffer.asByteData().getUint8(it);
    it += 1;
    return r;
  };

  final extractU16 = /* BN */ (Endian endian) { 
    var r = itObj.buffer.asByteData().getUint16(it, endian);
    it += 2;
    return r;
  };

  final extractU32 = /* BN */ (Endian endian) {
    var r = itObj.buffer.asByteData().getUint32(it, endian);
    it += 4;
    return r;
  };

  final extractU64 = /* BN */ (Endian endian) {
    var r1 = itObj.buffer.asByteData().getUint32(it, endian);
    it += 4;
    var r2 = itObj.buffer.asByteData().getUint32(it, endian);
    it += 4;
    var b1 = BigInt.from(r1);
    var b2 = BigInt.from(r2);
    if (endian == Endian.big) {
      return (b1 * BigInt.from(2).pow(32)) + b2;
    } else {
      return (b2 * BigInt.from(2).pow(32)) + b1;
    }
  };

  PARSE_CHECK(itObj.lengthInBytes == 0, "scriptpubkey cannot be empty");
  PARSE_CHECK(itObj.buffer.asByteData().getUint8(it) != OP_RETURN, "scriptpubkey not op_return" );
  PARSE_CHECK(itObj.lengthInBytes < 10 ,"scriptpubkey too small" );
  ++it;

  final extractPushdata = /* num */ () {
    if (it == itObj.length) { return - 1;} 
    final int cnt = extractU8();
    if (cnt > OP_0 && cnt < OP_PUSHDATA1) { 
      if (it + cnt > itObj.length) { --it; return - 1;} 
      return cnt;
    } else if (cnt == OP_PUSHDATA1) {
      if (it + 1 >= itObj.length) { --it; return - 1;} 
      return extractU8();
    } else if (cnt == OP_PUSHDATA2) {
      if (it + 2 >= itObj.length ) { --it; return - 1;} 
      return extractU16(Endian.little);
    } else if (cnt == OP_PUSHDATA4) { 
      if (it + 4 >= itObj.length ) { --it; return - 1;} 
      return extractU32(Endian.little);
    }

    // other opcodes not allowed
    --it;
    return - 1;
  };

  final bufferToBN = /* BN */ () {
    if (itObj.length == 1) return extractU8();
    if (itObj.length == 2) return extractU16(Endian.big);
    if (itObj.length == 4) return extractU32(Endian.big);
    if (itObj.length == 8) return extractU64(Endian.big);
    throw("extraction of number from buffer failed");
  };

  final checkValidTokenId = (Uint8List tokenId) => tokenId.length == 32;
  final List<Uint8List> chunks = [];
  for (var len = extractPushdata();len >= 0;len = extractPushdata()) {
    final buf = Uint8List(len);
    buf.setAll(0, itObj.getRange(it, it + len));
    PARSE_CHECK(it + len > itObj.length, "pushdata data extraction failed" );
    it += len;chunks.add(buf);
    if (chunks.length == 1) {
      final lokadIdStr = chunks[0];
      PARSE_CHECK (lokadIdStr.length != 4, "lokad id wrong size");
      PARSE_CHECK (
          lokadIdStr.buffer.asByteData().getUint8(0) != "S".codeUnitAt(0)
        || lokadIdStr.buffer.asByteData().getUint8(1) != "L".codeUnitAt(0)
        || lokadIdStr.buffer.asByteData().getUint8(2) != "P".codeUnitAt(0)
        || lokadIdStr.buffer.asByteData().getUint8(3) != 0x00, "SLP not in first chunk");  
    }
  }

  PARSE_CHECK (it != itObj.length, "trailing data");
  PARSE_CHECK (chunks.isEmpty, "chunks empty");
  
  var cit = 0;
  final CHECK_NEXT = /* void */ () {
    ++cit;
    PARSE_CHECK (cit == chunks.length, "parsing ended early");
    it = 0;
    itObj = chunks[cit];
  };
  CHECK_NEXT ();

  final tokenTypeBuf = itObj;//.reversed;
  PARSE_CHECK (tokenTypeBuf.length != 1 && tokenTypeBuf.length != 2,
    "token_type string length must be 1 or 2" );
  final tokenType = bufferToBN();
  PARSE_CHECK (![ 0x01 , 0x41 , 0x81 ].contains(tokenType),
    "token_type not token-type1, nft1-group, or nft1-child" );
  CHECK_NEXT ();

  final transactionType = utf8.decode(itObj);
  if (transactionType == "GENESIS") { 
    PARSE_CHECK (chunks.length != 10, "wrong number of chunks" );
    CHECK_NEXT ();

    final ticker = itObj;
    CHECK_NEXT ();
    
    final name = itObj;
    CHECK_NEXT ();
    
    final documentUri = itObj;
    CHECK_NEXT ();
    
    final documentHash = itObj;
    PARSE_CHECK (documentHash.length != 0 && documentHash.length != 32 , "document_hash must be size 0 or 32" );
    CHECK_NEXT ();
    
    final decimalsBuf = itObj;
    PARSE_CHECK (decimalsBuf.length != 1, "decimals string length must be 1" );
    
    final decimals = bufferToBN() as int;
    PARSE_CHECK (decimals > 9 ,
      "decimals bigger than 9" );
    CHECK_NEXT ();
    
    final mintBatonVoutBuf = itObj;
    var mintBatonVout = 0;
    PARSE_CHECK (mintBatonVoutBuf.length >= 2 , "mint_baton_vout string length must be 0 or 1" );
    if (mintBatonVoutBuf.length > 0 ) {
      mintBatonVout = bufferToBN();
      PARSE_CHECK (mintBatonVout < 2, "mint_baton_vout must be at least 2" );
    }
    CHECK_NEXT ();

    final qtyBuf = itObj;//.reversed;
    PARSE_CHECK (qtyBuf.length != 8 ,
      "initial_qty must be provided as an 8-byte buffer" );
    final qty = bufferToBN();

    if (tokenType == 0x41) {
      PARSE_CHECK (decimals != 0, "NFT1 child token must have divisibility set to 0 decimal places" );
      PARSE_CHECK (mintBatonVout != 0, "NFT1 child token must not have a minting baton" );
      PARSE_CHECK (qty != BigInt.from(1), "NFT1 child token must have quantity of 1" );
    }
    final GenesisParseResult actionData = new GenesisParseResult(
      tickerBuf : ticker ,
      nameBuf : name ,
      documentUriBuf : documentUri ,
      documentHashBuf : documentHash ,
      decimals : decimals ,
      mintBatonVout : mintBatonVout ,
      qty : qty
    );
    return new ParseResult( 
      tokenType : tokenType , 
      transactionType : transactionType , 
      data : actionData 
    );
  } else if (transactionType == "MINT") {
    PARSE_CHECK (tokenType == 0x41, "NFT1 Child cannot have MINT transaction type." );
    
    PARSE_CHECK (chunks.length != 6, "wrong number of chunks");
    CHECK_NEXT ();
    
    final tokenId = itObj;
    PARSE_CHECK (! checkValidTokenId(tokenId), "tokenId invalid size");
    CHECK_NEXT ();
    
    final mintBatonVoutBuf = itObj;
    var mintBatonVout = 0;
    PARSE_CHECK (mintBatonVoutBuf.length >= 2 , "mint_baton_vout string length must be 0 or 1" );
    if (mintBatonVoutBuf.length > 0 ) {
      mintBatonVout = bufferToBN();
      PARSE_CHECK (mintBatonVout < 2 , "mint_baton_vout must be at least 2");
    }
    CHECK_NEXT ();
    
    final additionalQtyBuf = itObj;//.reversed;
    PARSE_CHECK (additionalQtyBuf.length != 8, "additional_qty must be provided as an 8-byte buffer" );
    final qty = bufferToBN();

    final actionData = new MintParseResult(
      tokenIdBuf : tokenId,
      mintBatonVout : mintBatonVout,
      qty : qty
    );

    return new ParseResult( 
      tokenType : tokenType,
      transactionType : transactionType,
      data : actionData
    );
  } else if (transactionType == "SEND") {
    PARSE_CHECK (chunks.length < 4, "wrong number of chunks");
    CHECK_NEXT ();
    
    final tokenId = itObj;
    PARSE_CHECK (! checkValidTokenId (tokenId ) , "tokenId invalid size");
    CHECK_NEXT ();

    final List<BigInt> amounts = [];
    while (cit != chunks.length) {
      final amountBuf = itObj; //.reversed;
      PARSE_CHECK(amountBuf.length != 8, "amount string size not 8 bytes");

      final value = bufferToBN();
      amounts.add(value);

      ++cit;
      if (cit < chunks.length) {
        itObj = chunks[cit];
      }
      it = 0;
    }

    PARSE_CHECK (amounts.length == 0, "token_amounts size is 0");
    PARSE_CHECK (amounts.length > 19, "token_amounts size is greater than 19");
    
    final actionData = new SendParseResult( 
      tokenIdBuf : tokenId , 
      amounts : amounts
    );
    return new ParseResult( 
      tokenType : tokenType,
      transactionType : transactionType,
      data : actionData 
    );
  } else {
      PARSE_CHECK (true , "unknown action type");
  }

  // unreachable code
  return new ParseResult( 
    tokenType : tokenType , 
    transactionType : transactionType , 
    data : new ImpossibleParseResult() 
  );
}
