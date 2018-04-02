module crimson.css.css;

CssStyle css(string name, string[string] rules, string description = ""){
	CssStyle style = new CssStyle(name, description);

	style.addRules(rules);

	return style;
}

CssSheet cssSheet(CssStyle[] styles) {
	CssSheet sheet = new CssSheet();
	
	sheet.addStyles(styles);	

	return sheet;
}

class CssSheet {
	protected CssStyle[] styles;

	public void addStyle(CssStyle style) {
		this.styles ~= style;
	}

	public void addStyles(CssStyle[] styles) {
		this.styles = styles;
	}

	public string render() {
		string cssSheetData = "";

		foreach(CssStyle style; this.styles) {
			cssSheetData ~= style.toCSS();
		}

		return cssSheetData;
	}
}
class CssStyle {
	protected string name;
	protected string[string] rules;
	protected string description;

	public this(string name, string description = "") {
		this.name = name;

		this.description = description;
	}	

	public void addRule(string attribute, string value) {
		this.rules[attribute] = value;
	}

	public void addRules(string[string] rules) {
		this.rules = rules;
	}

	public string toCSS() {
		string cssData = ""; 

		if(this.description != "") {
			cssData ~= "/*" ~ this.description ~ "*/";
		}

		cssData ~= this.name ~ "{";

		foreach(string ruleName, string ruleValue; this.rules) {
			cssData ~= ruleName ~ ":" ~ ruleValue ~ ";"; 
		}

		cssData ~= "}";

		return cssData;
	}
	

}
