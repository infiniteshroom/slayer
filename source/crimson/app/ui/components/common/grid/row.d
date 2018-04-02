module crimson.app.ui.components.common.grid.row;

import std.conv;

import crimson.html.document;
import crimson.html.element;

import crimson.app.ui.components.component;

class Row : ComponentInterface {
    private HTMLElement el;

    private ComponentInterface[] components = [];

    public void addComponent(ComponentInterface component) {
        this.components ~= component;
    }

    public HTMLElement getElement() {

        HTMLElement[] componentElements;

        foreach(int i, ComponentInterface component; this.components) {
            componentElements ~= component.getElement();
        }

        return this.el = h("div.row", componentElements);
    }
}