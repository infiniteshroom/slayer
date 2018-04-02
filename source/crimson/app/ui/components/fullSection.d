module crimson.app.ui.components.FullSection;

import crimson.html.document;
import crimson.html.element;

import crimson.app.ui.components.component;


enum FullSectionColors {
    gray = "fullSectionGray",
    charcoal = "fullSectionCharcoal",
    white = "fullSectionWhite"   
}

class FullSection : ComponentInterface {
    private HTMLElement el;

    public @property FullSectionColors color = FullSectionColors.gray;

    private ComponentInterface[] components = [];

    public void addComponent(ComponentInterface component) {
        this.components ~= component;
    }

    public HTMLElement getElement() {

        HTMLElement[] componentElements;

        foreach(int i, ComponentInterface component; this.components) {
            componentElements ~= component.getElement();
        }

        return this.el = h("div.fullSection." ~ this.color,[
            h("div.container", componentElements)
        ]);
    }
}