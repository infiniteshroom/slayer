module crimson.app.ui.components.common.grid.column;

import std.conv;

import crimson.html.document;
import crimson.html.element;

import crimson.app.ui.components.component;

class Column : ComponentInterface {
    private HTMLElement el;

    private ComponentInterface[] components = [];

    public @property int size;

    public @property int mobileSize;

    public this(int size=1, int mobileSize=12) {
        this.size = size;
        this.mobileSize = mobileSize;
    }
    public void addComponent(ComponentInterface component) {
        this.components ~= component;
    }

    public HTMLElement getElement() {

        HTMLElement[] componentElements;

        foreach(int i, ComponentInterface component; this.components) {
            componentElements ~= component.getElement();
        }

        return this.el = h("div.col-md-" ~ to!string(this.size) ~ ".col-xs-" ~ to!string(this.mobileSize), componentElements);
    }
}