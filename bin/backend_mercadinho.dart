import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:backend_mercadinho/backend_mercadinho.dart'
    as backend_mercadinho;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

void main(List<String> arguments) async {
  var app = Router();

  app.get('/', (request) {
    return Response.ok(json);
  });

  final pipeline = Pipeline() //
      .addMiddleware(logRequests())
      .addMiddleware(addJsonType())
      .addHandler(
        app,
      );

  final server = await shelf_io.serve(pipeline, '0.0.0.0', 4949);
  print('Server online: PORT ${server.port}');
}

Middleware addJsonType() {
  return (handle) {
    return (request) async {
      var response = await handle(request);
      response = response.change(headers: {
        'content-type': 'text/json',
      });
      return response;
    };
  };
}

final json = '''
{
  "message": "tudo certo por aqui"
}



''';
