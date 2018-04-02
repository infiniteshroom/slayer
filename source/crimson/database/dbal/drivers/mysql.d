module crimson.database.dbal.drivers.mysql;

import crimson.database.dbal.drivers.driver;

import std.conv;

import mysql.d;


class MySQLDatabaseConnection : GenericDatabaseConnection {
	private:
		Mysql connection;

	public override void open(string[string] params) {
		super.open(params);
		
		string databaseName = params["db_name"];
		string databasePort = params["db_port"];
		string databaseUser = params["db_username"];
		string databasePassword = params["db_password"];
		string databaseHost = params["db_host"];

		this.connection = new Mysql(databaseHost, to!uint(databasePort), databaseUser, databasePassword, databaseName);	
		
		this.driverObj = to!Object(this.connection);	
	}

	public override void close() {
		this.connection = null;
	}
}

class MySQLDatabaseQuery : GenericDatabaseQuery {
	private:
		string[] params;
		string[string][] results;

	public override void execute(string sql) {
		Mysql conn = to!Mysql(this.getConnection().getDriverObject());
		auto results = conn.query(sql, params);
		
		foreach(row; results) {
			this.results ~= row.toAA();
		}	
	}

	public override int getInsertID() {
		Mysql conn = to!Mysql(this.getConnection().getDriverObject());
		return conn.lastInsertId();
	}

	public override string[string][] fetchAll() {
		return this.results;
	}

	public override string[string] fetchOne() {
		return this.results[0];
	}

	public override int count() {
		Mysql conn = to!Mysql(this.getConnection().getDriverObject());
		return conn.affectedRows();
	}

	public override string escape(string input) {	
		Mysql conn = to!Mysql(this.getConnection().getDriverObject());
		return conn.escape(input);
	}

}
