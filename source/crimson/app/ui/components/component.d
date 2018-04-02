module crimson.app.ui.components.component;

import crimson.html.document;
import crimson.html.element;


interface ComponentInterface {
    HTMLElement getElement();
    void addComponent(ComponentInterface component);
}