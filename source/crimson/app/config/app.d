module crimson.config.app;

import crimson.config.base;

class AppConfig : configBase {
    public this() {

        this.settings["Name"] = "Test Application";
        this.settings["Version"] = "0.1";
        this.settings["Author"] = "Mark J. Lang";
        this.settings["Language"] = "en-gb";
        this.settings["theme"] = "";
    }
}