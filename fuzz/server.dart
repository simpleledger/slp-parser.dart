import 'dart:convert';
import 'dart:io';
import 'package:slp_parser/slp_parser.dart';
import 'package:convert/convert.dart';

Future main() async {
  var server = await HttpServer.bind(
    InternetAddress.loopbackIPv4,
    8080,
  );
  print('Listening on localhost: ${server.port}');

  await for (HttpRequest request in server) {
    print(request.uri.toString());

    var y = null;
    try {
      var url = request.uri.toString();
      var bin = hex.decode(url[0] == '/' ? url.substring(1) : url);
      y = parseSLP(bin);
      y.versionType = y.tokenType;

      if (y.transactionType == "GENESIS") {
          y.symbol         = hex.encode(y.data.ticker).toUpperCase();
          y.name           = hex.encode(y.data.name).toUpperCase();
          y.documentUri    = hex.encode(y.data.documentUri).toUpperCase();
          if (y.data.documentHash == null) {
              y.documentSha256 = "";
          }
          y.documentSha256 = hex.encode(y.data.documentHash).toUpperCase();
      }

      if (y.data.hasOwnProperty("decimals")) {
          y.decimals = y.data.decimals;
      }

      if (y.data.hasOwnProperty("qty")) {
          y.genesisOrMintQuantity = (y.data.qty).toString();
      }

      if (y.data.hasOwnProperty("tokenid")) {
          y.tokenIdHex = hex.encode(y.data.tokenid);
      }

      if (y.data.hasOwnProperty("mintBatonVout")) {
          y.batonVout = y.data.mintBatonVout;
      }

      if (y.data.hasOwnProperty("amounts")) {
          y.sendOutputs = y.data.amounts.map((v) => v.toString());
      }
    } catch(e) {
      var buf = utf8.encode("{'success': false, 'error:': ${e}}");
      request.headers.add('Content-Length', buf.length);
      request.response.write(buf);
    }

    await request.response.close();
  }
}
