package com.moseory.dao;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

public class JDBCTest {
    
    static {
	try {
	    Class.forName("oracle.jdbc.driver.OracleDriver");
	} catch (ClassNotFoundException e) {
	    e.printStackTrace();
	}
    }
    
    @Test
    public void connectionTest() {
	try(Connection con = DriverManager.getConnection(
				"jdbc:log4jdbc:oracle:thin:@52.79.242.16:1521:xe", "hong", "h8159")) {
	    
	} catch(Exception e) {
	    e.printStackTrace();
	}
    }
    
}
