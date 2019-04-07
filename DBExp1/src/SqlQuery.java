import javax.swing.table.DefaultTableModel;
import java.sql.*;

public class SqlQuery {
    private static SqlQuery instance = null;


    private final static String driver = "com.mysql.cj.jdbc.Driver";
    private final static String url = "jdbc:mysql://192.168.173.130:3306/dbexp?serverTimezone=UTC&characterEncoding=utf-8";
    private final static String user = "dbexp";
    private final static String pass = "dbexp";

    private Connection connect;

    private SqlQuery() throws SQLException{
        connect = DriverManager.getConnection(url, user, pass);
    }

    public void queryStatement(String sqlStatement, DefaultTableModel model) throws SQLException{
        Statement statement = connect.createStatement();
        ResultSet set = statement.executeQuery(sqlStatement);
        ResultSetMetaData meta = set.getMetaData();
        final int count = meta.getColumnCount();
        String[] columnName = new String[count];
        for(int i = 0; i < count; i++){
            columnName[i] = meta.getColumnName(i + 1);
        }
        model.setColumnIdentifiers(columnName);
        String[] row = new String[count];
        while(set.next()){
            for(int i = 0; i < count; i++){
                row[i] = set.getString(i + 1);
            }
            model.addRow(row);
        }
    }

    public ResultSet queryStatement(String sqlStatement) throws SQLException{
        Statement statement = connect.createStatement();
        return statement.executeQuery(sqlStatement);
    }

    public void modifyData(String sqlStatement) throws SQLException{
        Statement statement = connect.createStatement();
        statement.executeUpdate(sqlStatement);
    }
    public boolean existItem(String sqlStatement) throws SQLException{
        Statement statement = connect.createStatement();
        ResultSet set = statement.executeQuery(sqlStatement);
        if(!set.next()){
            return false;
        }
        return true;
    }
    public static SqlQuery  getQueryObj() throws Exception{
        if (instance == null) {
            Class.forName(driver);
            instance = new SqlQuery();
        }
        return instance;
    }
}
