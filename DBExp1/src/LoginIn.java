import lib.SqlQuery;

import javax.swing.*;
import java.awt.event.ItemEvent;
import java.sql.SQLException;

public class LoginIn extends JFrame {
    private JPanel root;
    private JButton login;
    private JComboBox selector;
    private JTextField id;

    private Tuple[] role;
    private int selectedRole = -1;

    private SqlQuery queryObj;

    public LoginIn() {
        setTitle("用户登录");
        setContentPane(root);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(400, 300);
        login.addActionListener(e -> {
            if(selectedRole == -1){
                JOptionPane.showMessageDialog(this, "没有选择角色，不能进入系统！");
                return;
            }
            String number = id.getText();
            JFrame frame = null;
            if (number.isEmpty()) {
                JOptionPane.showMessageDialog(this, "请输入学号！");
                return;
            }
            if(!varify(number, selectedRole)){
                JOptionPane.showMessageDialog(this, "无法查到该学号/职工号的相关记录，请检查输入是否正确！");
                return;
            }
            MainWindowFactory factory = null;
            switch (selectedRole) {
                case 1:
                    factory = new StudentInfor.StudentFactory();
                    break;
                case 2:
                    factory = new TeacherInfor.TeacherFactory();
                    break;
                case 3:
                    factory = new CounsellorInfor.CounsellorFactory();
                    break;
                default:
                    JOptionPane.showMessageDialog(this, "程序错误！", "错误", JOptionPane.ERROR_MESSAGE);
                    System.exit(0);
            }
            try{
                frame = factory.getFrame(number);
            }catch(Exception except){
                JOptionPane.showMessageDialog(this, except.getMessage(), "错误", JOptionPane.ERROR_MESSAGE);
                System.exit(0);
            }
            this.dispose();
            frame.setVisible(true);
        });
        try {
            queryObj = SqlQuery.getQueryObj();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e.getMessage(), "无法连接数据库", JOptionPane.ERROR_MESSAGE);
            System.exit(0);
        }
    }

    private void createUIComponents() {
        // TODO: place custom component creation code here
        role = new Tuple[4];
        role[0] = new Tuple(-1, "请选择您的角色...");
        role[1] = new Tuple(1, "学生");
        role[2] = new Tuple(2, "老师");
        role[3] = new Tuple(3, "辅导员");
        selector = new JComboBox<Tuple>(role);

        selector.addItemListener((e) -> {
            if (e.getStateChange() == ItemEvent.SELECTED) {
                selectedRole = ((Tuple) e.getItem()).getIndex();
            }
        });
    }

    private boolean varify(String id, int index) {
        StringBuilder build = new StringBuilder();
        build.append("select * from ");
        switch (index) {
            case 1:
                build.append("students where stu_id=\"");
                build.append(id);
                break;
            case 2:
                build.append("teacher where sta_id=\"");
                build.append(id);
                break;
            case 3:
                build.append("counsellor where sta_id=\"");
                build.append(id);
                break;
            default:
                JOptionPane.showMessageDialog(this, "程序错误！", "错误", JOptionPane.ERROR_MESSAGE);
                System.exit(0);
        }
        build.append("\";");
        try {
            return queryObj.existItem(build.toString());
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, e.getMessage(), "错误", JOptionPane.ERROR_MESSAGE);
            System.exit(0);
        }
        return false;
    }

    private class Tuple {
        private int index;
        private String label;

        private Tuple(int index, String label) {
            this.index = index;
            this.label = label;
        }

        public int getIndex() {
            return index;
        }

        @Override
        public String toString() {
            return label;
        }
    }
}
