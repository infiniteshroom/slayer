module crimson.config.paths;

import crimson.config.base;

class PathsConfig : configBase {
    public this() {

        this.settings["web"] = "./data/www/";
        this.settings["config"] = "./config/";
        this.settings["view"] = "./views";
    }   
}