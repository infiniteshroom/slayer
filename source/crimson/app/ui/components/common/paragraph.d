module crimson.app.ui.components.common.paragraph;

import std.conv;

import crimson.html.document;
import crimson.html.element;

import crimson.app.ui.components.component;

class Paragraph : ComponentInterface {
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

        return this.el = h("p", [], text);
    }
}