import 'package:test/test.dart';
import 'package:convert/convert.dart';

import 'package:slp_parser/slp_parser.dart';
import './script_tests.dart';

void main() {
  testdata.forEach((testcase) {
    test(testcase["msg"], () {
      if (testcase["code"] == null) {
        var slpMsg = parseSLP(hex.decode(testcase["script"]));
        final Map<String, Object> exp = testcase["parsed"];
        final Map<String, Object> data = exp["data"];
        if (slpMsg["transactionType"] == "GENESIS") {
          //exp["ticker"] = utf8.encode(exp["ticker"]);
          //exp["name"] = utf8.encode(exp["name"]);
          //exp["documentUri"] = utf8.encode(exp["documentUri"]);
          //exp["documentHash"] = hex.decode(exp["documentHash"]);
          data["qty"] = BigInt.parse(data["qty"]);
        } else if (slpMsg["transactionType"] == "MINT") {
          data["tokenId"] = hex.decode(data["tokenId"]);
          data["qty"] = BigInt.parse(data["qty"]);
        } else if (slpMsg["transactionType"] == "SEND") {
          data["tokenId"] = hex.decode(data["tokenId"]);
          var amounts = (data["amounts"] as List<String>).map((a) { return BigInt.parse(a);}).toList() as List<BigInt>;
          data["amounts"] = amounts;
        }
        exp["data"] = data;
        expect(slpMsg, exp);
      } else {
        var throws = true;
        try {
          parseSLP(hex.decode(testcase["script"]));
          throws = false;
        } catch(_) {
          expect(throws, true);
        }
      }
    });
  });
}
