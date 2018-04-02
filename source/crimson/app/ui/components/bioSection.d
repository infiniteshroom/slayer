module crimson.app.ui.components.biosection;

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


class BioSection : ComponentInterface {
    private HTMLElement el;

    public @property Image image = null;
    public @property Header header = null;
    public @property Header subHeader = null;
    public @property Paragraph description = null;

    public @property string jobTitle = "";
    public @property string companyName = "";

    private ComponentInterface[] components = [];

    public void addComponent(ComponentInterface component) {
        this.components ~= component;
    }

    public HTMLElement getElement() {


		FullSection section = new FullSection();

		Row profileRow = new Row();

		Column bioColumn = new Column(6);

		Column imageColumn = new Column(6);

		bioColumn.addComponent(this.header);
		bioColumn.addComponent(this.subHeader);
        
        //build job title section
        Paragraph jobParagraph = new Paragraph("Currently working as <strong>"~ this.jobTitle ~ "</strong> for <strong>"~ this.companyName ~"</strong>"); 

        bioColumn.addComponent(jobParagraph);
        bioColumn.addComponent(this.description);

        imageColumn.addComponent(this.image);
		
		
		profileRow.addComponent(imageColumn);
		profileRow.addComponent(bioColumn);


		section.addComponent(profileRow);

		this.addComponent(section);
        
        HTMLElement[] componentElements;

        foreach(int i, ComponentInterface component; this.components) {
            componentElements ~= component.getElement();
        }

        return this.el = h("div.bioContainer", componentElements);
    }
}