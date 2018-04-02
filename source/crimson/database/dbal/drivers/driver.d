module crimson.database.dbal.drivers.driver;

interface DatabaseConnectionInterface {
		void open(string[string] params);
    void setSetting(string name, string value);
    string getSetting(string name);
    void close();
	Object getDriverObject();
}

interface DatabaseQueryInterface {
    DatabaseConnectionInterface getConnection();
    void setConnection(DatabaseConnectionInterface conn);
    void execute(string sql);
		int getInsertID();
    string[string] fetchOne();
		string[string][] fetchAll();
		int count();
    string escape(string input);
    void addParameter(string param, string type);
}

class GenericDatabaseConnection : DatabaseConnectionInterface {
	protected:
		string[string] params;
		Object driverObj;

	public void open(string[string] params) {
		this.params = params;
		
	}

	public void setSetting(string name, string value) {
		this.params[name] = value;
	}

	public string getSetting(string name) {
		return this.params[name];
	}

	public Object getDriverObject() {
		return this.driverObj;
	}

	public void close() {}	
}

class GenericDatabaseQuery : DatabaseQueryInterface {
	protected:
		DatabaseConnectionInterface connection;

	public DatabaseConnectionInterface getConnection() {
		return this.connection;
	}

	public void setConnection(DatabaseConnectionInterface connection) {
		this.connection = connection;
	}

	public void execute(string sql) {}

	public int getInsertID() {return 0;}

	public string[string] fetchOne() { return null;}

	public string[string][] fetchAll() {return null;}

	public int count() {return 0;}

	public string escape(string input) {return null;}

	public void addParameter(string param, string type) {}

}
