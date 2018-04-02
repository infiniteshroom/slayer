module crimson.app.ui.components.contactsection;

import crimson.html.document;
import crimson.html.element;

import crimson.app.ui.components.component;
import crimson.app.ui.components.FullSection;

import crimson.app.ui.components.common.header;
import crimson.app.ui.components.common.image;
import crimson.app.ui.components.common.paragraph;
import crimson.app.ui.components.common.text;

import crimson.app.ui.components.common.grid.row;
import crimson.app.ui.components.common.grid.column;


class ContactSection : ComponentInterface {
    private HTMLElement el;

    public @property Header header = null;
    public @property Paragraph description = null;

    private ComponentInterface[] components = [];

    public void addComponent(ComponentInterface component) {
        this.components ~= component;
    }

    public HTMLElement getElement() {


		FullSection section = new FullSection();

		Row contactRow = new Row();

		Column column = new Column(12);

        column.addComponent(this.header);
        column.addComponent(this.description);
		
		contactRow.addComponent(column);


		section.addComponent(contactRow);
        section.color = FullSectionColors.charcoal;

		this.addComponent(section);
        
        HTMLElement[] componentElements;

        foreach(int i, ComponentInterface component; this.components) {
            componentElements ~= component.getElement();
        }

        return this.el = h("div.contactContainer", componentElements);
    }
}