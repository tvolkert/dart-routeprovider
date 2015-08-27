library route_provider;

import 'dart:async';
import 'dart:io';
import 'package:route_provider/route_provider.dart';

class RouteControllerError extends RouteController {
    RouteControllerError();

    Future<Map> execute(HttpRequest request, Map params) async  {
        throw new RouteError(HttpStatus.NOT_FOUND,"ERROR");
    }

}

Future main() async {

    HttpServer server = await HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, 4040);

    print('listening on localhost, port ${server.port}');

    //start webserver
    RouteProvider provider = new RouteProvider(server, {
        "defaultRoute":"/",
        "staticContentRoot":"/docroot"
    })

    ..route(
        // url: "/",
        // controller: new EmptyRouteController(),
        responser: new FileResponse("docroot/home.html")
    )
    ..route(
        url: "/error",
        controller: new RouteControllerError(),
        responser: new FileResponse("docroot/home.html")
    )
    ..start();

    //perform more tests here

    provider.stop();
}
