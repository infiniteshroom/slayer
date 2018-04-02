module crimson.http.router.router;

import std.array;
import std.string;
import std.algorithm;
import std.functional;
import std.stdio;

import slayer.http.request;
import slayer.http.response;

import crimson.http.router.route;
import crimson.http.router.dispatcher;
import crimson.controller;

interface RouterInterface {

        void add(string path, Object controller, string verb="GET");
        void add(string path, string dispatcher, string verb="GET");
        void add(string path, void function(IRequest req, IResponse res) dispatcher, string verb="GET");

        void get(string path, Object controller);
        void get(string path, string dispatcher);
        void get(string path, void function(IRequest req, IResponse res) dispatcher);

        void post(string path, Object controller);
        void post(string path, string dispatcher);
        void post(string path, void function(IRequest req, IResponse res) dispatcher);

        void dispatch();
        //public function add($path, $dispatcher, $verb='GET');
}

class HTTPRouter : RouterInterface {
        private:
            HTTPRoute[] routes;

            private IResponse res;

            private IRequest req;


        public this(IResponse res, IRequest req) {
            this.res = res;
            this.req = req;
        }


        public void get(string path, Object dispatcher) {
            this.add(path, dispatcher);
        }

        public void get(string path, string dispatcher) {
            this.add(path, dispatcher);
        }

        public void get(string path, void function(IRequest req, IResponse res) dispatcher) {
            this.add(path, dispatcher);
        }

        public void post(string path, Object dispatcher) {
            this.add(path, dispatcher, "POST");
        }

        public void post(string path, string dispatcher) {
            this.add(path, dispatcher, "POST");
        }

        public void post(string path, void function(IRequest req, IResponse res) dispatcher) {
            this.add(path,dispatcher, "POST");
        }

        public void add(string path, Object dispatcher, string verb="GET") {
            HTTPRoute route = new HTTPRoute();
            route.path = path;
            route.verb = verb;
            route.dispatcherObject = dispatcher;
            this.routes ~= route;
        }

        public void add(string path, string dispatcher, string verb="GET") {
            HTTPRoute route = new HTTPRoute();
            route.path = path;
            route.verb = verb;
            route.dispatcher = dispatcher;
            this.routes ~= route;
        }

        public void add(string path, void function(IRequest req, IResponse res) dispatcher, string verb="GET") {
            HTTPRoute route = new HTTPRoute();
            route.path = path;
            route.verb = verb;
            route.dispatcherFunc = dispatcher.toDelegate();
            this.routes ~= route;
        }

        public void dispatch() {

            

            string path = this.req.getPath();

            if(path == "") {
                path = "/";
            }

            string verb = this.req.getVerb();

            //Make sure path ends in a slash.
            long lastSlashIndex = path.lastIndexOf("/");

            bool routeFound = false;

            if(path.length -1 != lastSlashIndex) {
                path ~= "/";
            }

            foreach(int i, HTTPRoute route; this.routes) {
                string routePath = route.path;

                if(!routePath.startsWith("/")) {
                    routePath = "/" ~ routePath;
                }

                string routeDispatcher = route.dispatcher;

                string[] routeParts = routePath.split("/");
                string[] urlParts = path.split("/");

                string[string] routeVariables;

                foreach(int urlIndex, string urlPart; urlParts) {
                    string routePart = "";

                    if(routeParts.length - 1 >= urlIndex) {
                        routePart = routeParts[urlIndex];
                    }

                    if(routePart != "") {
                        if(routePart.startsWith(":")) {
                            string cleanName = routePart[1 .. $];

                            routeVariables[cleanName] = urlPart;

                            urlParts[urlIndex] = routeParts[urlIndex];
                        }
                    }
                }


                route.variables = routeVariables;

                string checkUrl = urlParts.join("/");


                if(checkUrl != "/") {
                    routePath = routePath[1 .. $];
                    checkUrl = checkUrl[1 .. $];
                }

                if(!routePath.endsWith("/")) {
                    routePath ~= "/";
                }

                writefln("checkurl:" ~ checkUrl);
                writefln("Rp:" ~ routePath);

                if(route.dispatcher == null) {

                    if(checkUrl.indexOf(routePath) != -1 && (route.verb == verb || route.verb == "ANY")) {
                        FunctionDispatcher funcDispatch = new FunctionDispatcher();
                        funcDispatch.Dispatch(route, this.req, this.res);

                        foreach(string key, string val; routeVariables) {
                         //   writeln(key ~ ":" ~ val);
                        }

                        routeFound = true;
                        break;
                    }
                }

                else {
                    //process controller
                }



            }

            if(!routeFound) {
                //route to 404

            }
        }

}
