module crimson.kernel.application;

import std.stdio;
import std.socket;
import std.random;
import std.digest.md;
import std.stdio;
import std.conv;
import std.file;
import std.path;
import std.array;
import std.algorithm;

import slayer.http.request;
import slayer.http.code;
import slayer.http.response;

import endovena;


import crimson.reflection;
import crimson.config.app;
import crimson.config.paths;
import crimson.config.routes;
import crimson.http.router.router;

import crimson.app.bootstrap;

enum ApplicationMode {
    CONSOLE = 1,
    HTTP = 2
}


interface ApplicationInterface {


   // auto create(string className);
    void setMode(ApplicationMode mode);
    void start();
}

class HTTPApplication : ApplicationInterface {

    private:
        HTTPRequest request;
        HTTPResponse response;
        ApplicationMode mode;
        Container container;

    public @property string[string][string] settings;
    public @property string[string] path;


    public this(HTTPRequest request, HTTPResponse response) {
        this.request = request;
        this.response = response;

        this.mode = ApplicationMode.HTTP;
    }

    public auto create(string className) {
        return null;
    }

    public void setMode(ApplicationMode mode) {
        this.mode = mode; 
    }

    public void start() {

        this.container = container;

        //load config files
        AppConfig appConfig = new AppConfig();
        PathsConfig pathsConfig = new PathsConfig();

        this.settings["app"] = appConfig.settings;
        this.path = pathsConfig.settings;


        this.response.setStatusCode(statusCode.OK);
        this.response.setProtocol("HTTP/1.0");
        this.response.setContentType("text/html");

        ApplicationInterface app = this;


       // this.container.register!(IRequest, this.request);
       // this.container.register!(IResponse, this.response);

      // this.container.register!(IRequest, HTTPRequest);
       //this.container.register!(IResponse, HTTPResponse);

       Bootstrap bootstrap = new Bootstrap(this.response, this.request);



    }

}
