import javax.swing.*;
import javax.swing.table.DefaultTableModel;

public class MainGui {
    private JTable sqlResult;
    private JCheckBox sidck;
    private JCheckBox snameck;
    private JCheckBox sageck;
    private JCheckBox ssexck;
    private JTextField sid;
    private JTextField sname;
    private JTextField sageFrom;
    private JTextField ssex;
    private JTextField sageTo;
    private JCheckBox sclassck;
    private JTextField sclass;
    private JCheckBox sdeptck;
    private JTextField sdept;
    private JCheckBox saddrck;
    private JTextField saddr;
    private JTextArea sqlOutput;
    private JPanel root;
    private JButton queryBtn;
    private DefaultTableModel model;
    private String[] sqlSlice = {
            "Sid like \"%s\"",
            "Sname like \"%s\"",
            "Sage >= \"%s and sage <= %s\"",
            "Ssex like \"%s\"",
            "Sclass like \"%s\"",
            "Sdept like \"%s\"",
            "Saddr like \"%s\""
    };
    private String[] sqlCon = {
            " where ",
            " and "
    };
    private final String basicSql = "select * from student";

    private MainGui() {
        queryBtn.addActionListener((e) -> {
            String sql = genSqlState();
            Query query = Query.getInstance();
            sqlOutput.setText(sql);
            if (query == null) {
                System.out.println("Inner error!");
                return;
            }
            query.query(sql, model);
        });
    }

    public static void main(String[] args) {
        JFrame frame = new JFrame("学生个人信息查询");
        frame.setContentPane(new MainGui().root);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
    }

    private String genSqlState() {
        boolean added = false;
        String buf;
        StringBuilder build = new StringBuilder();
        build.append(basicSql);
        if (sidck.isSelected()) {
            buf = sid.getText();
            added = addCon(false, build);
            build.append(String.format(sqlSlice[0], buf));
        }
        if (snameck.isSelected()) {
            buf = sname.getText();
            added = addCon(added, build);
            build.append(String.format(sqlSlice[1], buf));
        }
        if (sageck.isSelected()) {
            String buf2 = sageTo.getText();
            buf = sageFrom.getText();
            added = addCon(added, build);
            build.append(String.format(sqlSlice[2], buf, buf2));
        }
        if (ssexck.isSelected()) {
            buf = ssex.getText();
            added = addCon(added, build);
            build.append(String.format(sqlSlice[3], buf));
        }
        if (sclassck.isSelected()) {
            buf = sclass.getText();
            added = addCon(added, build);
            build.append(String.format(sqlSlice[4], buf));
        }
        if (sdeptck.isSelected()) {
            buf = sdept.getText();
            added = addCon(added, build);
            build.append(String.format(sqlSlice[5], buf));
        }
        if (saddrck.isSelected()) {
            buf = saddr.getText();
            addCon(added, build);
            build.append(String.format(sqlSlice[6], buf));
        }
        build.append(';');
        return build.toString();
    }

    private boolean addCon(boolean added, StringBuilder build) {
        if (added) {
            build.append(sqlCon[1]);
        } else {
            build.append(sqlCon[0]);
        }
        return true;
    }

    private void createUIComponents() {
        model = new DefaultTableModel();
        sqlResult = new JTable();
        sqlResult.setModel(model);
    }
}
