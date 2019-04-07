
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableModel;
import java.sql.*;

public class Query {
    private final static String driver = "com.mysql.cj.jdbc.Driver";
    private final static String url = "jdbc:mysql://192.168.173.130:3306/dbexp";
    private final static String user = "dbexp";
    private final static String pass = "dbexp";
    private static Query instance = null;
    private final String[] row = new String[7];
    public final String[] columns = {
            "Sid",
            "Sname",
            "Sage",
            "Ssex",
            "Sclass",
            "Sdept",
            "Saddr"
    };
    private Query(){

    }

    public void query(String sql, DefaultTableModel model){
        model.setColumnIdentifiers(columns);
        model.setNumRows(0);
        try {
            Connection connect = DriverManager.getConnection(url, user, pass);
            Statement statement = connect.createStatement();
            ResultSet res = statement.executeQuery(sql);
            while(res.next()){
                for(int i = 0; i < row.length; i++){
                    row[i] = res.getString(columns[i]);
                }
                model.addRow(row);
            }
        }catch(SQLException e){
            e.printStackTrace();
            System.out.println("无法连接数据库！\n");
            return;
        }
    }

    public static Query getInstance() {
        if(instance == null){
            try{
                Class.forName(driver);
            }catch(ClassNotFoundException e){
                e.printStackTrace();
                return null;
            }
            instance = new Query();
        }
        return instance;
    }
}
