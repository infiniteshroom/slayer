module crimson.cli.cli;


import std.stdio;
import std.string;

class cli {
	public this() {
		writefln("Crimson Web Framework for Dlang (A1)");

		while(true) {
			write(">>> ");
			string command = readln();
			command = command.chomp("");
			command = command.replace("\n", "");

			switch(command) {
				case "about":
					"Crimson Web Framework by Mark J. Lang. Pre-release".writeln();
					break;
				default:
					writefln("Command " ~ command ~ " is not a valid command");
			}
		}
	}
}
