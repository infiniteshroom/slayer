module crimson.http.router.dispatcher;

import crimson.http.router.route;
import crimson.reflection;

import slayer.http.request;
import slayer.http.code;
import slayer.http.response;

//public function Dispatch(\Crimson\HTTP\Router\Route\HTTPRoute $route);


interface DispatcherInterface {
    void Dispatch(HTTPRoute route, IRequest req, IResponse res);
}

class FunctionDispatcher : DispatcherInterface {

    public void Dispatch(HTTPRoute route, IRequest req, IResponse res) {
        route.dispatcherFunc(req, res);
    }
}

class ControllerDispatcher : DispatcherInterface {
    public void Dispatch(HTTPRoute route, IRequest req, IResponse res) {

    }
}