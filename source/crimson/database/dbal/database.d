module crimson.database.dbal.database;

interface DatabaseInterface {
	void setActiveConnection();
	void getActiveConnection();
	void init(string[string] datasources);
}
