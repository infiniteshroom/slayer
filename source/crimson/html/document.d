module crimson.html.document;

import crimson.html.element;

enum HTMLDocType {
    HTML5 = 1,
    XHTMLS = 2,
    XHTMLT = 3
}

class HTMLDocument {
    private:
        HTMLElement[] elements;
        HTMLDocType docType;
    
    public void addElement(HTMLElement el) {
        this.elements ~= el;
    }

    public HTMLElement[] getElements() {
        return this.elements;
    }

    public string render() {
        string html = "";

        if(this.docType == HTMLDocType.HTML5) {
            html ~= "<!DOCTYPE html>";
        }

        foreach(int i, HTMLElement el; this.elements) {
            html ~= el.toHTML();
        }

        return html;
    }

    public void setDocType(HTMLDocType docType) {
        this.docType = docType;
    }
}