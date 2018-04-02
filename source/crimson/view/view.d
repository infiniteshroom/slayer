module crimson.view.view;

interface ViewInterface {
    void set(string[string] data);
    void setVar(string name, string value);
    void addPath(string path);
    bool exists(string view);
    string[] path(string view);
    void render(string view, string[string] data = null);
    string buffer(string view, string[string] data = null);
    void registerFunction(string name, string function() func);
}

class Larks : ViewInterface {

    private:
        string[string] variables;
        string[] paths;
        string[string function()] functions;

    public void set(string[string] data) {

        foreach(string key, string var; data) {
            this.setVar(key, var);
        }
    }

    public void setVar(string name, string value) {
        this.variables[name] = value;
    }

    public void addPath(string path) {
        this.paths ~= path;
    }

    public bool exists(string view) {
        return false;
    }

    public string[] path(string view) {
        return null;
    }

    public void render(string view, string[string] data = null) {
        //sss
    }

    public string buffer(string view, string[string] data = null) {
        return "";
    }

    public void registerFunction(string name, string function() func) {
        //dsds
    }
}

