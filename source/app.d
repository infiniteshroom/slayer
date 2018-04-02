module slayer.entry;

import std.stdio;
import std.json;
import std.file;
import std.conv;

import core.thread;

import slayer.server.web;
import slayer.server.fcgi;
import crimson.cli.cli;



void main()
{

	string vhostsConfig = readText("/home/mark/Documents/slayer/data/vhosts.json");

	JSONValue[] doc = parseJSON(vhostsConfig).array;

	foreach(vhost; doc) {

		string docRoot = vhost.object["documentRoot"].str;
		int port = to!int(vhost.object["port"].str);
		string serverName = vhost.object["serverName"].str;
		string indexFiles = vhost.object["indexFiles"].str;
		bool redEnabled = to!bool(vhost.object["redEnabled"].str);
		bool dev = to!bool(vhost.object["dev"].str);



		if(dev) {

			//Launch cli interface
			new Thread({
				writefln("test");
				new cli();
			}).start();

			new Thread({
				writefln("Debug: Slayer Web server start on port :" ~ to!string(port));
				WebServer server = new WebServer();
				server.start(port, docRoot, serverName);
			}).start();
		}

		else {
			new Thread({
				FCGIServer server = new FCGIServer();
				server.start();
			}).start();
		}
	}
}
