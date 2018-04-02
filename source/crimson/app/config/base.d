module crimson.config.base;

enum configType {
    JSON = 1,
    XML = 2
}
class configBase {
    private:
        configType type;

    public @property string[string] settings;


    public void load(string filename, configType type = configType.JSON) {
        this.type = type;

        //load file into settings

        if(this.type == configType.JSON) {
            
        }
    }
}