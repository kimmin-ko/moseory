package com.moseory.dao;

import java.sql.Connection;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class DataSourceTest {

    @Setter(onMethod_ = @Autowired)
    private DataSource ds;
    
    @Test
    public void dataSourceTest() {
	
	try(Connection con = ds.getConnection()) {
	    log.info("con");
	} catch(Exception e) {
	    e.printStackTrace();
	}
	
    }
    
}
