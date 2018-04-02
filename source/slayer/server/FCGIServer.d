module slayer.server.fcgi;


import std.stdio;
import std.socket;
import std.conv;
import std.file;
import std.path;
import std.array;
import std.algorithm;
import std.process;
import std.string;

import slayer.fastcgi;
import slayer.http.request;
import slayer.http.response;

import crimson.kernel.application;

class FCGIServer {
    public void start() {
        FCGX_Request frequest;

        FCGX_Init();

        FCGX_InitRequest(&frequest, 0, 0);

        while(FCGX_Accept_r(&frequest) == 0) {
            HTTPRequest request = new HTTPRequest();

            request.setVerb(to!string(FCGX_GetParam("REQUEST_METHOD", frequest.envp)));
            request.setPath(to!string(FCGX_GetParam("SCRIPT_NAME", frequest.envp)));
            request.setProtocol(to!string(FCGX_GetParam("SERVER_PROTOCOL", frequest.envp)));
            request.setHost(to!string(FCGX_GetParam("SERVER_NAME", frequest.envp)));

            HTTPResponse response = new HTTPResponse();

            HTTPApplication app = new HTTPApplication(request, response);
            app.start();
            
            FCGX_FPrintF(frequest._out, response.toString().toStringz());

            FCGX_Finish_r(&frequest);
        }

    }
}