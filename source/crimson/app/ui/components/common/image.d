module crimson.app.ui.components.common.image;

import std.conv;

import crimson.html.document;
import crimson.html.element;

import crimson.app.ui.components.component;

class Image : ComponentInterface {
    private HTMLElement el;

    private ComponentInterface[] components = [];

    public @property string src;

    public @property string alt;

    public this(string src, string alt="") {
        this.src = src;
        this.alt = alt;
    }
    public void addComponent(ComponentInterface component) {
        this.components ~= component;
    }

    public HTMLElement getElement() {

        HTMLElement[] componentElements;

        foreach(int i, ComponentInterface component; this.components) {
            componentElements ~= component.getElement();
        }

        return this.el = h("img", ["src": this.src, "alt": this.alt]);
    }
}