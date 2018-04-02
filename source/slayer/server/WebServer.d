module slayer.server.web;

import std.stdio;
import std.socket;
import std.conv;
import std.file;
import std.path;
import std.array;
import std.algorithm;

import slayer.http.request;
import slayer.http.code;
import slayer.http.response;
import slayer.http.mime;

import crimson.kernel.application;


//TODO: method detection GET,POST, HEAD
//TODO: post data
interface IServer {
    void start(int port, string path = "/home/mark/Document/slayer/data/www", string name = "localhost");
    void stop();
}

class WebServer : IServer {

    private:
        Socket server;
        SocketSet clientSet;
        Socket[] reads;

        string path;
        string name;
        string[int] indexFiles;
        string[int] protocols;
        immutable string serverVersion = "Slayer 0.1";



    public void start(int port, string path = "/", string name = "localhost") {
        
        this.path = path;
        this.name = name;
         // writefln(to!string(port));

        this.indexFiles[0] = "index.html";
        
        this.protocols[0] = "HTTP/1.0";
        this.protocols[1] = "HTTP/1.1";

        this.server = new TcpSocket();
        this.server.setOption(SocketOptionLevel.SOCKET, SocketOption.REUSEADDR, true);
        this.server.bind(new InternetAddress(to!ushort(port)));

      
        this.server.blocking = false;
        this.server.listen(1001);

        this.clientSet = new SocketSet(1001);

        this.process();
        
    }

    private void process() {

        while (true)
        {
            this.clientSet = new SocketSet(1001);
            this.clientSet.add(this.server);

            
            foreach (sock; this.reads) {
                this.clientSet.add(sock);
            }
            
            this.server.select(this.clientSet, null, null);
            
            for (size_t i = 0; i < this.reads.length; i++)
            {
                Socket currentRead = this.reads[i];

                if (this.clientSet.isSet(this.reads[i]))
                {

                     char[1024] buf;
                    auto datLength = this.reads[i].receive(buf[]);
                    
                    if (datLength == Socket.ERROR) {
                        //writeln("Connection error.");
                    }

                    else if (datLength != 0)
                    {
                        
                        string data = buf.dup;

                       // buf = null;

                        HTTPRequest request = to!HTTPRequest(HTTPRequest.parse(data));


                        string filepath = request.getPath();

                        

                        if(filepath == "/") {
                            filepath ~= this.indexFiles[0];
                        }

                        string ext = extension(filepath).replace(".", "");

                        writefln("filepath:" ~ filepath);

                        string fullFilePath = this.path ~ filepath;

                        HTTPResponse response = new HTTPResponse();

                        if(!exists(fullFilePath)) {

                            /*File f = File("/home/mark/slayer/data/errorPages/404.html", "r");

                            string fileData = "";
                            
                            foreach (line; f.byLine()) {
                                fileData ~= line ~ "\n";
                            }

                            //return slayer error page
                            response.setStatusCode(statusCode.NotFound);
                            response.setProtocol(this.protocols[0]);
                            response.setContentType(getMimeType(ext));
                            response.setBody(fileData);
                            response.setServer(this.serverVersion);*/

                            //boostrap red
                            HTTPApplication app = new HTTPApplication(request, response);
                            app.start();




                        }

                        else {
                            File f = File(fullFilePath, "r");

                            string fileData = "";
                            
                            foreach (line; f.byLine()) {
                                fileData ~= line ~ "\n";
                            }

                            string fileContents = fileData;

                            response.setStatusCode(statusCode.OK);
                            response.setProtocol(this.protocols[0]);
                            response.setContentType(getMimeType(ext));
                            response.setBody(fileContents);
                            response.setServer(this.serverVersion);
                        }

                        currentRead.send(response.toString());
                        
                    }
                    else
                    {
                        try
                        {
                            // if the connection closed due to an error, remoteAddress() could fail
                          //  writefln("Connection from %s closed.", this.reads[i].remoteAddress().toString());
                        }
                        catch (SocketException)
                        {
                           // writeln("Connection closed.");
                        }
                    }
                    
                    // release socket resources now
                    this.reads[i].close();

                    this.reads = remove(this.reads, i);
                    
                    //this.reads = reads[i].
                    // i will be incremented by the for, we don't want it to be.
                    i--;

                }

                    
            }
            
            if (this.clientSet.isSet(this.server))        // connection request
            {
                Socket sn = null;
                scope (failure)
                {
                   // writefln("Error accepting");
                    
                    if (sn) {
                        sn.close();
                    }
                }
                sn = this.server.accept();
                
                if (this.reads.length < 1000)
                {
                    this.reads ~= sn;
                }
                else
                {
                    sn.close();
                }
            }
            
            this.clientSet.reset();
        }
    }

    public void stop() {
        this.server = null;
    }
    
    private string getMimeType(string ext) {
        HTTPMime mime = new HTTPMime("");
        return mime.getMime(ext);
    }

}
