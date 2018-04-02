module crimson.app.css.components.biosection;

import crimson.css.css;
import crimson.app.css.variables;

class BioSectionCSS {
	protected CssSheet sheet; 

	public this() {
		this.sheet = cssSheet([
			css(".bioContainer h2", [
				"padding-bottom": "0.5em"
			]),

			css(".bioContainer p", [
				"margin-top": "2em",
				"margin-bottom": "2em",
				"font-size": "0.9em"
			])
		]);
	}

	public string render() {
		return this.sheet.render();
	}
}
 