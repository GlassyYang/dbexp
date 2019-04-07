import javax.swing.*;
import java.sql.SQLException;

public class CounsellorInfor implements MainWindow {
    private JTabbedPane tabbedPane1;
    private JTextField staIdShow;
    private JTextField name;
    private JTextField sex;
    private JTextField collage;
    private JButton modify;
    private JTextField type;
    private JTable stuInfor;
    private JTable table1;
    private JButton findByCla;
    private JButton findByStu;
    private JButton backToLogin;
    private JButton quit;
    private JPanel root;

    private String staId;
    SqlQuery query;
    private CounsellorInfor(String staId) {
        this.staId = staId;
        quit.addActionListener(e -> {
            System.exit(0);
        });
        backToLogin.addActionListener(e -> {
            JFrame frame = (JFrame)(root.getParent().getParent().getParent());
            frame.dispose();
            LoginIn login = new LoginIn();
            login.setVisible(true);
        });
    }

    @Override
    public void prepareInformation() throws SQLException {

    }

    public static JFrame getFrame(String id) {
        JFrame frame = new JFrame("辅导员信息管理系统");
        frame.setContentPane(new CounsellorInfor(id).root);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        return frame;
    }

    private void createUIComponents() {
        // TODO: place custom component creation code here
    }
}
