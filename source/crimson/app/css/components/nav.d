module crimson.app.css.components.nav;

import crimson.css.css;
import crimson.app.css.variables;

class NavCSS {
	protected CssSheet sheet; 

	public this() {
		this.sheet = cssSheet([
			css(".navbar", [
				"padding": "1em",
			]),
			css(".navbar-inverse", [
				"background-color": "white",
                "border-color": "white",
			]),
			css(".navbar-inverse .navbar-brand, .navbar-inverse .navbar-brand:hover, .navbar-inverse .navbar-brand:focus", [
				"color": "#222",
				"font-size": "1.7em",
				"font-weight": "100",
			]),
			css(".navbar-inverse .navbar-nav > .active > a, .navbar-inverse .navbar-nav > .active > a:hover, .navbar-inverse .navbar-nav > .active > a:focus", [
				"color": colors.Important,
				"background-color": "white"
			]),
			css(".navbar-inverse .navbar-nav > li > a", [
				"color": colors.Light,
				"font-weight": "600"
			])
		]);
	}

	public string render() {
		return this.sheet.render();
	}
}
 