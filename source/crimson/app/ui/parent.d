module crimson.app.ui.parent;

import crimson.app.ui.components.navigation;
import crimson.app.ui.components.component;

import crimson.html.document;
import crimson.html.element;



class ParentUI {
	protected HTMLDocument doc;
	protected HTMLElement content = new HTMLElement();
	protected Navigation nav = new Navigation();

	protected ComponentInterface[] components = [];

	public void setNavigation(Navigation nav) {
		this.nav = nav;
	}

	public void addComponent(ComponentInterface component) {
		this.components ~= component;
	}

	public string render() {


		this.nav.setLinks([
			"Home": "",
			"Blog": "",
			"Projects": "",
			"Contact": "",
		]);

		HTMLElement[] componentElements = [];

		foreach(int i, ComponentInterface component; this.components) {
			componentElements ~= component.getElement();
		}

		componentElements ~= nav.getElement();

		HTMLDocument htmlDoc = new HTMLDocument();
		htmlDoc.setDocType(HTMLDocType.HTML5);
		htmlDoc.addElement(
			h("html", [
				head()
			.style("https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.css")
			.style("https://opensource.keycdn.com/fontawesome/4.7.0/font-awesome.min.css")
			.style("//fonts.googleapis.com/css?family=Raleway:400,300,600")
			.style("/styles.css")
				.title("Bootstrap test"),

				h("body", componentElements)
				]
			)
		);

		return htmlDoc.render();
	}
}
