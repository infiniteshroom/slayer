module crimson.app.css.styles;

import std.string;

import crimson.css.css;
import crimson.app.css.variables;

import crimson.app.css.common.typography;

import crimson.app.css.components.nav;
import crimson.app.css.components.fullsection;
import crimson.app.css.components.biosection;
import crimson.app.css.components.contactsection;

class StylesCSS {
	protected CssSheet sheet; 

	public this() {

		
		this.sheet = cssSheet([
			css("body", [
				"background-color": colors.Background,
			]),

			css(".colorize", [
				"color": colors.Important,
			], "Colorise class adds important color as a style")
		]);
	}

	public string render() {
		return [
		
		this.sheet.render(), 
		new TypographyCSS().render(), 
		new NavCSS().render(), 
		new FullScreenCSS().render(),
		new BioSectionCSS().render(),
		new ContactSectionCSS().render(),

		].join("");
	}
}
