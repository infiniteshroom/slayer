module crimson.app.ui.home;

import std.conv;

import crimson.app.ui.parent;

import crimson.html.document;
import crimson.html.element;

import crimson.app.ui.components.biosection;
import crimson.app.ui.components.component;
import crimson.app.ui.components.FullSection;
import crimson.app.ui.components.contactsection;

import crimson.app.ui.components.common.image;
import crimson.app.ui.components.common.header;
import crimson.app.ui.components.common.paragraph;


class HomeUI: ParentUI {

	public this() {
		
		BioSection bio = new BioSection();
		bio.header = new Header("Hello I'm Mark <span class='colorize'>J.</span> Lang", 2);
		bio.subHeader = new Header("BSC (Hons) Web Systems Developer", 3);
		bio.image = new Image("https://pbs.twimg.com/profile_images/780516601107996672/MU7oq6A5.jpg", "Mark J. Lang");
		bio.jobTitle = "Web Developer";
		bio.companyName = "Chess Digital";
		bio.description = new Paragraph("I see coding as an art form I love to create elegent, simple and effective code  . I see myself as more of a back-end developer preferring to dabble in the inner workings of a site then the full blown front-end design. I tend to work from a purely linux based LAMP enviroment using Linux Mint <3  However i'm not just a code monkey ;) I love progressive rock music  ,  Science Fiction in any form and Video Games.");

		ContactSection contactSection = new ContactSection();
		contactSection.header = new Header("&lt;Contact<span class='colorize'>/</span>&gt;", 1);
		contactSection.description = new Paragraph("Send me a short message. All comments  and criticism  welcome.");

		this.addComponent(bio);
		this.addComponent(contactSection);

		this.nav.setActive("Home");
	}
}
