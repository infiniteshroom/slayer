module crimson.app.css.common.typography;

import crimson.css.css;
import crimson.app.css.variables;

class TypographyCSS {
	protected CssSheet sheet; 

	public this() {
		this.sheet = cssSheet([
			css("body", [
				"font-family": fonts.bodyFont,
				"color": colors.Font
			]),

			css("h1, h2, h3, h4, h5", [
				"font-weight": "300",
			])
		]);
	}

	public string render() {
		return this.sheet.render();
	}
}
