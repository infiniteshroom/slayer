module crimson.http.router.route;

import slayer.http.request;
import slayer.http.code;
import slayer.http.response;

class HTTPRoute {
    @property string verb;
    @property string path;
    @property string dispatcher;
    @property void delegate(IRequest req, IResponse res) dispatcherFunc;
    @property Object dispatcherObject;
    @property string[string] variables;
}