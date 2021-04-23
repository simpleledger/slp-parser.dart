import 'package:test/test.dart';
import 'package:convert/convert.dart';

import 'package:slp_parser/slp_parser.dart';
import './script_tests.dart';

void main() {
  testdata.forEach((testcase) {
    test(testcase["msg"], () {
      if (testcase["code"] == null) {
        final ParseResult slpMsg = parseSLP(hex.decode(testcase["script"] as String));
        final Map<String, Object> exp = testcase["parsed"] as Map<String, Object>;
        final Map<String, Object> data = exp["data"] as Map<String, Object>;
        if (slpMsg.transactionType == "GENESIS") {
          data["qty"] = BigInt.parse(data["qty"] as String);
        } else if (slpMsg.transactionType == "MINT") {
          data["tokenId"] = hex.decode(data["tokenId"] as String);
          data["qty"] = BigInt.parse(data["qty"] as String);
        } else if (slpMsg.transactionType == "SEND") {
          data["tokenId"] = hex.decode(data["tokenId"] as String);
          var amounts = (data["amounts"] as List<String>).map((a) { return BigInt.parse(a);}).toList() as List<BigInt>;
          data["amounts"] = amounts;
        }
        exp["data"] = data;
        final slpMsgMap = slpMsg.toMap(raw: true);
        expect(slpMsgMap, exp);
      } else {
        var throws = true;
        try {
          parseSLP(hex.decode(testcase["script"] as String));
          throws = false;
        } catch(_) {
          expect(throws, true);
        }
      }
    });
  });
}
