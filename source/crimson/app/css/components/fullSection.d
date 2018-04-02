module crimson.app.css.components.fullsection;

import crimson.css.css;
import crimson.app.css.variables;

class FullScreenCSS {
	protected CssSheet sheet; 

	public this() {
		this.sheet = cssSheet([
			css(".fullSection", [
				"height": "100vh",
				"padding-top": "8em"
			]),

			css(".fullSectionCharcoal", [
				"background-color": colors.Charcoal,
			])
		]);
	}

	public string render() {
		return this.sheet.render();
	}
}
 