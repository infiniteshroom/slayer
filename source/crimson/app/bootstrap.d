module crimson.app.bootstrap;

import slayer.http.request;
import slayer.http.code;
import slayer.http.response;

import crimson.config.routes;
import crimson.http.router.router;

class Bootstrap {
    public this(IResponse res, IRequest req) {


       //Bootstrap your app
       auto router = new HTTPRouter(res, req);


       auto routes = new Routes(router);
       routes.process();
       router.dispatch();
    }
}