module slayer.http.response;

import std.stdio;
import std.array;
import std.conv;
import std.string;

import slayer.http.code;

public interface IResponse {

    void setProtocol(string protocol);
    string getProtocol();

    void setStatusCode(statusCode code);
    statusCode getStatusCode();

    void setBody(string data);
    string getBody();

    void setContentType(string type);
    string getContentType();

    void setContentLength(size_t size);
    size_t getContentLength();

    void setDate(string date);
    string getDate();

    void setServer(string server);
    string getServer();

    void setHeader(string name, string value);
    string getHeader(string name);
}

public class HTTPResponse : IResponse {
    private:
        string protocol;
        statusCode status;
        string bodyData;
        string[string] headers;

    //creates a string representation of the object
     public override string toString() {
        string responseMessage = "";

        string statusText = to!string(this.status);


        if(chomp(statusText, " ") == "NotFound") {
            statusText = "Not Found";
        }

        responseMessage = this.protocol ~ " " ~ to!string(to!int(this.status)) ~ " " ~ statusText ~ "\n";

        foreach(string name, string value; this.headers) {
            responseMessage ~= name ~ ":" ~ value ~ "\n";
        }

        responseMessage ~= "\n";
        responseMessage ~= this.bodyData;
        responseMessage ~= "\n";


        return responseMessage;
    }


    public void setProtocol(string protocol) {
        this.protocol = protocol;
    }

    public string getProtocol() {
        return this.protocol;
    }

    public void setStatusCode(statusCode code) {
        this.status = code;
    }

    public statusCode getStatusCode() {
        return this.status;
    }


    public void setBody(string data) {
        this.bodyData = data;

        this.setContentLength(data.length);
    }

    public string getBody() {
        return this.bodyData;
    }

    public void setContentType(string type) {
        this.headers["Content-Type"] = type;
    }

    public string getContentType() {
        return this.headers["Content-Type"];
    }

    public void setContentLength(size_t size) {
        this.headers["Content-Length"] = to!string(size);
    }

    public size_t getContentLength() {   
        return to!size_t(this.headers["Content-Length"]);
    }

    public void setDate(string date) {
        this.headers["Date"] = date;
    }

    public string getDate() {
        return this.headers["Date"];
    }

    public void setServer(string server) {
        this.headers["Server"] = server;
    }

    public string getServer() {
        return this.headers["Server"];
    }

    public void setHeader(string name, string value) {
        this.headers[name] = value;
    }

    public string getHeader(string name) {
        return this.headers[name];
    }
}