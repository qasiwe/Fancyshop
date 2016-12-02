package source;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.Vector;
import java.sql.Statement;
import java.sql.ResultSetMetaData;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.table.DefaultTableModel;

public class DatabaseClient 
{
	// Database connection details
	//String userName = "mona.rizvi";	// username
	String userName = "k.koishybay";
	//String password = "";				// password
	String password = "BU8HQVV";
	String dbms = "mysql";
	//String serverName = "10.10.200.67";
	String serverName = "46.101.171.158";
	String portNumber = "80";
	String dbname = "kenessary_koishybay";		// your schema name 

	
	Connection conn = null;
	
	/*
	 * In this constructor, connect to the mysql database and exit if it doesn't work
	 */
	public DatabaseClient()
	{
		try 
		{
			conn = getConnection();
		} 
		catch (SQLException e) 
		{	
			e.printStackTrace();
			System.exit(-1);
		}
	}
	
	/*
	 * Make the connection, pass the exception to the caller
	 */
	public Connection getConnection() throws SQLException 
	{

	    Connection conn = null;
	    Properties connectionProps = new Properties();
	    connectionProps.put("user", this.userName);
	    connectionProps.put("password", this.password);

	    if (this.dbms.equals("mysql")) {
	        conn = DriverManager.getConnection(
	                   "jdbc:" + this.dbms + "://" +
	                   this.serverName +
	                   ":" + this.portNumber + "/" + this.dbname,
	                   connectionProps);
	    }
	    System.out.println("Connected to database");
	    return conn;
	}
	
	
	/*
	 * Some of this method's code came from a very nice generic solution by user 'Paul Vargas' on stackoverflow
	 */
        public void insertSQL(String query){                       
            try {
                Statement stmt = conn.createStatement();
                stmt.execute(query);
            } catch (SQLException ex) {
                Logger.getLogger(DatabaseClient.class.getName()).log(Level.SEVERE, null, ex);
            }                    
        }
	public Vector<Vector<Object>> searchSQL(String query)
	{
	     
	        try
	        {
                    // Execute a query
                    Statement stmt = conn.createStatement();
                    
	            ResultSet rs = stmt.executeQuery(query);
	            
	            // Get the meta data so that you can set the table column names
	            ResultSetMetaData metaData = rs.getMetaData();
	            Vector<String> columnNames = new Vector<String>();
	            int columnCount = metaData.getColumnCount();
	            for (int i = 1; i <= columnCount; i++) 
	            {
	                // columnNames.add(metaData.getColumnName(i));
	            	columnNames.add(metaData.getColumnLabel(i));
	            }

	            // Now get the data itself and load it into a 2-D vector
	            Vector<Vector<Object>> data = new Vector<Vector<Object>>();
	            while (rs.next()) 
	            {
	                Vector<Object> vector = new Vector<Object>();
	                for (int i = 1; i <= columnCount; i++) {
	                    vector.add(rs.getObject(i));
	                }
	                data.add(vector);
	            }

	            // Give the data to the tableModel and it will be displayed in the table
	            return data;
	        } 
	        catch (Exception e) 
	        {
	            e.printStackTrace();
	        }
                return null;
	        
	    }
	}

