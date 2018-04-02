module crimson.app.ui.components.common.header;

import std.conv;

import crimson.html.document;
import crimson.html.element;

import crimson.app.ui.components.component;

class Header : ComponentInterface {
    private HTMLElement el;

    private ComponentInterface[] components = [];

    public @property string text;

    public @property int size = 1;

    public this(string text="", int size=1) {
        this.text = text;
        this.size = size;
    }
    public void addComponent(ComponentInterface component) {
        this.components ~= component;
    }

    public HTMLElement getElement() {

        HTMLElement[] componentElements;

        foreach(int i, ComponentInterface component; this.components) {
            componentElements ~= component.getElement();
        }

        return this.el = h("h" ~ to!string(this.size), this.text ,componentElements);
    }
}