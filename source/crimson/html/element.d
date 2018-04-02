module crimson.html.element;

import std.string;

HeadElement head() {
    return new HeadElement();
}

HTMLElement h(string name, HTMLElement[] children=null, string content="") {
    HTMLElement el = new HTMLElement(name);

    if(content != "") {
        el.setContent(content);
    }

    if(children != null) {
        foreach(HTMLElement childEl; children) {
            el.addChild(childEl);
        }
    }

    return el;
}

HTMLElement h(string name, string[string] attr, HTMLElement[] children=null) {
    HTMLElement el = new HTMLElement(name);

    if(children != null) {
        foreach(HTMLElement childEl; children) {
            el.addChild(childEl);
        }
    }

    foreach(string attrName, string attrValue; attr) {
        el.setAttribute(attrName, attrValue);
    }

    return el;
}

HTMLElement h(string name, string[string] attr, string content, HTMLElement[] children=null) {
    HTMLElement el = new HTMLElement(name);

    if(content != "") {
        el.setContent(content);
    }

    if(children != null) {
        foreach(HTMLElement childEl; children) {
            el.addChild(childEl);
        }
    }

    foreach(string attrName, string attrValue; attr) {
        el.setAttribute(attrName, attrValue);
    }

    return el;
}

HTMLElement h(string name, string content="", HTMLElement[] children=null) {
    HTMLElement el = new HTMLElement(name);

    if(content != "") {
        el.setContent(content);
    }

    if(children != null) {
        foreach(HTMLElement childEl; children) {
            el.addChild(childEl);
        }
    }

    return el;
}



class HeadElement : HTMLElement {

    private:
        HTMLElement titleElement = null;

    public this() {
        this.name = "head";
    }

    public HeadElement title(string title) {

        if(this.titleElement is null) {
            HTMLElement titleElement = new HTMLElement("title");
            titleElement.setContent(title);

            this.titleElement = titleElement;

            this.addChild(this.titleElement);
        }

        else {
            this.titleElement.setContent(title);
        }

        return this;
    }

    public HeadElement script(string url, string type="text/javascript") {
        HTMLElement scriptElement = new HTMLElement("script");
        scriptElement.setAttribute("src", url);
        scriptElement.setAttribute("type", type);
        this.addChild(scriptElement);

        return this;
    }

    public HeadElement style(string url) {
		HTMLElement styleElement = new HTMLElement("link");
		styleElement.setAttribute("rel", "stylesheet");
		styleElement.setAttribute("href", url);
		styleElement.setAttribute("type", "text/css");
		this.addChild(styleElement);

		return this;
    }
}

class HTMLElement {
    private:
        string[string] attributes;
        string content;

        HTMLElement[] children;

        string name;

        public this(string name="") {

            //check if name contains dot

            if(name.indexOf(".") != -1) {
                string[] nameParts = name.split(".");

                this.name = nameParts[0];

                nameParts = nameParts[1..$];

                string classData = "";
                foreach(string s; nameParts) {
                    classData ~= s ~ " ";
                }

                this.c(classData);
            }

            else {
                this.name = name;
            }
        }

        public HTMLElement setAttribute(string name, string value="") {
            this.attributes[name] = value;

            return this;
        } 

        public string getAttibute(string name) {
            return this.attributes[name];
        }

        public HTMLElement addChild(HTMLElement element) {
            this.children ~= element;

            return this;
        }

        public HTMLElement c(string classes) {
            this.setAttribute("class", classes);

            return this;
        }

        public string attr(string name) {
            return this.attributes[name];
        }

        public HTMLElement attr(string name, string value) {
            this.attributes[name] = value;
            return this;
        }

        public HTMLElement[] getChildren() {
            return this.children;
        }

        public void addChildren(HTMLElement[] elements) {
            this.children = elements;
        }

        public HTMLElement getChild(int index) {
            return this.children[index];
        }

        public string getContent() {
            return this.content;
        }

        public HTMLElement setContent(string content) {
            this.content = content;
            
            return this;
        }

        public string toHTML() {
            string html = "<"~ this.name;

            foreach(string key, string attribute; this.attributes) {
                if(attribute != "") {
                    html ~= " " ~ key ~ "='" ~ attribute ~ "'";
                }

                else {
                    html ~= " " ~ key ~ " ";
                }
            }

            html ~= ">";

            if(this.content != "") {
                html ~= this.content;
            }

            foreach(int i, HTMLElement el; this.children) {
                html ~= el.toHTML();
            } 



            html ~= "</" ~ this.name ~ ">";

            return html;

        }



}
