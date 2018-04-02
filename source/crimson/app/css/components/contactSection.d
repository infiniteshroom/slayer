module crimson.app.css.components.contactsection;

import crimson.css.css;
import crimson.app.css.variables;

class ContactSectionCSS {
	protected CssSheet sheet; 

	public this() {
		this.sheet = cssSheet([
			css(".contactContainer", [
				"color": "white",
                "text-align": "center"
			]),
		]);
	}

	public string render() {
		return this.sheet.render();
	}
}
 