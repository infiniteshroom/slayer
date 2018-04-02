module crimson.config.routes;

import std.stdio;
import std.conv;

import crimson.http.router.router;

import crimson.view.tokenizer;
import crimson.view.parser;

import crimson.database.dbal.crimson;

import slayer.http.request;
import slayer.http.code;
import slayer.http.response;

import crimson.app.ui.home;
import crimson.app.css.styles;


class Routes {
    private:
        RouterInterface router;

    public this(RouterInterface router) {
        this.router = router;
    }       

    public void process() {

        //Note: Add your routes here...
        with(this.router) {
			get("/db/", function(req, res) {
				string[string] params;
				
				params["driver"] = "mysql";	
				params["db_name"] = "";
				params["db_port"] = "3306";
				params["db_username"] = "";
				params["db_password"] = "";
				params["db_host"] = "";

				CrimsonDatabaseConnection conn = new CrimsonDatabaseConnection();
				conn.open(params);

				CrimsonDatabaseQuery query = new CrimsonDatabaseQuery();
				query.setConnection(conn);
				query.execute("SELECT * from user limit 1");

				auto row = query.fetchOne();

				
				
				res.setBody(row["username"]);
			});

            get("/parse/", function(req, res) {
                /*Tokenizer t = new Tokenizer("<h3>{{ Hello }}</h3><span></span>\r\n<div>{{ yes }}</div>");
                string output = "";
                
                foreach(int i, string token ;t.getTokens()) {
                    output ~= token ~= "||||";
                }*/

                string[string] vars;

                vars["title"] = "This is a string";
                vars["header"] = "this is another string";

                Parser p = new Parser("<!DOCTYPE html>
<html>
  <head>
    <meta charset='UTF-8'>
    <title>{{ title }}</title>
  </head>
  <body>
    <h3>{{ header }}</h3>
  </body>
</html>", vars);
                p.parse();
                

               res.setBody(p.getOutput());
            });
			get("/styles.css", function(req, res) {
					res.setContentType("text/css");
					StylesCSS styles = new StylesCSS();
					res.setBody(styles.render());
			});

            get("/test/", function(req, res)  {
            HomeUI ui = new HomeUI();
			res.setBody(ui.render());
            });
        }
    }
}
