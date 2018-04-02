module crimson.app.ui.components.navigation;

import crimson.html.document;
import crimson.html.element;

import crimson.app.ui.components.component;


class Navigation : ComponentInterface {
    private HTMLElement el;
    private string[string] links;

    private string active;

    public void addComponent(ComponentInterface component) {
        //stub
    }

    public void setLinks(string[string] links) {
        this.links = links;
    }

    public void addLink(string name, string url) {
        this.links[name] = url;
    }

    public void setActive(string name) {
        this.active = name;
    }

    private HTMLElement[] getNavItems() {
        HTMLElement navItemsContainer = h("ul.nav.navbar-nav", "");

        foreach(string name, string url; this.links) {
            string classNames = "";

            if(this.active == name) {
                classNames = "active";        
            }

            navItemsContainer.addChild(                
                h("li",["class": classNames], [
                    h("a", ["href": url], name)
                 ]
            ));
        }


        return [navItemsContainer];
    }

    public HTMLElement getElement() {
        return this.el = 

		h("header", [
			h("nav.navbar.navbar-inverse.navbar-fixed-top", [
				h("div.container", [
					h("div.navbar-header", [
						h("button.navbar-toggle collapsed",["type": "button","data-toggle": "collapse", "navbar": "#navbar"], [
							h("span.sr-only", "Toggle navigation"),
							//BUG!!!
							h("span.icon-bar", "")
						]),
						h("a.navbar-brand", ["href": "#"], "Mark <span class='colorize'>J.</span> Lang")
					]),

					h("div.collapse.navbar-collapse", ["id": "navbar"], [
						h("ul.nav.navbar-nav.pull-right", this.getNavItems())
					])
				])
			])
		]);
    }
}