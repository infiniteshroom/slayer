module crimson.database.dbal.crimson;

import std.conv;

import crimson.database.dbal.drivers.driver;
import crimson.database.dbal.drivers.mysql;

class CrimsonDatabaseConnection : GenericDatabaseConnection {
	private DatabaseConnectionInterface driver;

	public override void open(string[string] params) {
		string driver = params["driver"];

		final switch(driver) {
			case "mysql":
				this.driver = to!DatabaseConnectionInterface(new MySQLDatabaseConnection());
			break;
		}	
		
		this.driver.open(params);
	}

	public override void setSetting(string name, string value) {
		this.setSetting(name, value);
	}

	public override string getSetting(string name) {
		return this.getSetting(name);
	}

	public override void close() {
		this.driver.close();
	}

	public override Object getDriverObject() {
		return to!Object(this.driver);
	}
	
}

class CrimsonDatabaseQuery : GenericDatabaseQuery {
	private DatabaseQueryInterface driver;
	
	public override void setConnection(DatabaseConnectionInterface connection) {
		string driver = connection.getSetting("driver");

		DatabaseConnectionInterface driverconn = to!DatabaseConnectionInterface(connection.getDriverObject());
		
		final switch(driver) {
			case "mysql":
				this.driver = new MySQLDatabaseQuery();
			break;
		}	

		this.driver.setConnection(driverconn);
	}

	public override DatabaseConnectionInterface getConnection() {
		return this.driver.getConnection();

	}

	public override void execute(string sql) {
		this.driver.execute(sql);
	}	

	public override int getInsertID() {
		return this.driver.getInsertID();
	}
	
	public override string[string] fetchOne() {
		return this.driver.fetchOne();
	}

	public override string[string][] fetchAll() {
		return this.driver.fetchAll();
	}

	public override int count() {
		return this.count();
	}

	public override string escape(string input) {
		return this.escape(input);
	}

	public override void addParameter(string param, string type) {
		this.driver.addParameter(param, type);
	}
}
