module slayer.http.request;

import std.stdio;
import std.array;
import std.conv;
import std.string;


public interface IRequest {
    //Verb, path, protocol, host 

    public static IRequest parse(string data);

    public string getVerb();
    public void setVerb(string verb);

    public string getPath();
    public void setPath(string path);

    public string getProtocol();
    public void setProtocol(string protocol);

    public string getHost();
    public void setHost(string host);

    public string getHeader(string name);
    public void setHeader(string name, string value);
}

public class HTTPRequest : IRequest {
    //Verb, path, protocol, host 
    private:
        string[string] headers;


    public static IRequest parse(string data) {
        
        string[] dataParts = data.split("\n");

        string[] mainRequestParts = dataParts[0].split(" ");

        IRequest request = new HTTPRequest();
        request.setVerb(mainRequestParts[0]);

        if(mainRequestParts.length > 1) {
            request.setPath(mainRequestParts[1]);
            request.setProtocol(mainRequestParts[2]);
        }

        else {
            request.setPath("/");
            request.setProtocol("HTTP/1.0");
        }

        foreach(int i, string header; dataParts) {

            //Miss out the resource line
            if(i > 0) {
                string[] keyAndValue = header.split(':');

                if(keyAndValue.length > 1) {

                    if(keyAndValue[0] == "Host") {
                        request.setHost(chomp(keyAndValue[1] ~ ':' ~ keyAndValue[2], " "));
                    }

                    else {
                        request.setHeader(chomp(keyAndValue[0]), keyAndValue[1]);
                    }
                }
            }
        }


        return to!IRequest(request);
    }

    public string getHeader(string name) {
        return this.headers[name];
    }

    public void setHeader(string name, string value) {
        this.headers[name] = value;
    }


    public string getVerb() {
        return this.headers["verb"];
    }

    public void setVerb(string verb) {
        this.headers["verb"] = verb;
    }

    public string getPath() {
        return this.headers["path"];
    }

    public void setPath(string path) {
        this.headers["path"] = path;
    }

    public string getProtocol() {
        return this.headers["protocol"];
    }

    public void setProtocol(string protocol) {
        this.headers["protocol"] = protocol;
    }

    public string getHost() {
        return this.headers["host"];
    }

    public void setHost(string host) {
        this.headers["host"] = host;
    }
}