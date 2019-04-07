import javax.swing.*;
import java.sql.SQLException;

public class TeacherInfor implements MainWindow{
    private JTabbedPane stuInfo;
    private JButton backToLogin;
    private JButton quit;
    private JButton newCourse;
    private JTextField staName;
    private JTextField staSex;
    private JTextField college;
    private JTextField oritation;
    private JTextField staIdShow;
    private JButton modify;
    private JButton coutseList;
    private JPanel root;
    private JTextField staAge;
    private JTable table1;
    private JTable table2;
    private JTable table3;
    private JTextField jobTitle;

    private String staId;

    private SqlQuery query;
    private TeacherInfor(String staId) {
        this.staId = staId;
        this.query = query;
        quit.addActionListener(e -> {
            System.exit(0);
        });
        backToLogin.addActionListener(e -> {
            JFrame frame = (JFrame)root.getParent();
            frame.dispose();
            LoginIn login = new LoginIn();
            login.setVisible(true);
        });
    }

    @Override
    public void prepareInformation() throws SQLException {

    }

    public static JFrame getFrame(String id){
        JFrame frame = new JFrame("教师个人信息管理系统");
        frame.setContentPane(new TeacherInfor(id).root);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        return frame;
    }
}
