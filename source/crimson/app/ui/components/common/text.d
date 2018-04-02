module crimson.app.ui.components.common.text;

import std.conv;

import crimson.html.document;
import crimson.html.element;

import crimson.app.ui.components.component;

class Text : ComponentInterface {
    private HTMLElement el;

    private ComponentInterface[] components = [];

    public @property string text;

    public this(string text) {
        this.text = text;
    }
    public void addComponent(ComponentInterface component) {
        this.components ~= component;
    }

    public HTMLElement getElement() {

        HTMLElement[] componentElements;

        foreach(int i, ComponentInterface component; this.components) {
            componentElements ~= component.getElement();
        }

        return this.el = h("span", [], text);
    }
}