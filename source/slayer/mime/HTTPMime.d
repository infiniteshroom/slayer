module slayer.http.mime;

import std.stdio;
import std.array;
import std.conv;
import std.string;

//TODO: dynamically load mimes from .json file
interface IMime {
    string getMime(string ext);
    void setMime(string ext, string mime);
}

class HTTPMime : IMime {
    private:
        string[string] mimes;

    public this(string file) {
        this.mimes["html"] = "text/html";
        this.mimes["png"] = "image/png";
        this.mimes["ico"] = "image/x-icon";
    }

    public string getMime(string ext) {
        return this.mimes[ext];
    }

    public void setMime(string ext, string mime) {
        this.mimes[ext] = mime;
    }


}