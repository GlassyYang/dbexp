import lib.SqlQuery;
import lib.UnEditableTableModel;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.sql.ResultSet;

public class CounsellorInfor extends MainWindow {
    private JTextField staIdShow;
    private JTextField name;
    private JTextField sex;
    private JTextField college;
    private JButton modify;
    private JTextField type;
    private JTable stuInfor;
    private JTable scoreShow;
    private JButton findByCla;
    private JButton findByStu;
    private JButton backToLogin;
    private JButton quit;
    private JPanel root;
    private JTextField age;

    //model
    private DefaultTableModel stuInforModel;
    private DefaultTableModel scoreModel;

    //查询语句
    private static String queryBaseInfo = "select * from counsellorInfo where sta_id = \"%s\";";
    private static String queryStuInfo = "select stu_id, stu_name, stu_sex, stu_age, class_id from students natural inner join class where counsellor_id=\"%s\";";
    private static String queryStuScore = "select stu_id, stu_name, class_id, averageScore from stuScore where counsellor_id=\"%s\";";
    private static String queryclassScore = "select class_id, sum(averageScore) / count(*) score from stuScore " +
            "where counsellor_id=\"%s\" group by class_id;";
    private static String updateBaseInfo = "update staff set sta_name=\"%s\", sta_sex=\"%s\", sta_age=\"%s\" where sta_id=\"%s\";";
    //标题
    private static String[] classScoreTitle = {"班号", "平均成绩"};
    private static String[] stuScoreTitle = {"学号", "姓名", "班号", "成绩"};
    private static String[] stuInfoTitle = {"学号", "姓名", "性别", "年龄", "班号"};
    private String staId;
    private SqlQuery query;

    private CounsellorInfor(String staId) {
        this.staId = staId;
        quit.addActionListener(e -> System.exit(0));
        backToLogin.addActionListener(e -> {
            parent.dispose();
            LoginIn login = new LoginIn();
            login.setVisible(true);
        });
        modify.addActionListener((event) -> {
            String newName = name.getText();
            String newSex = sex.getText();
            String newAge = age.getText();
            try {
                query.modifyData(String.format(updateBaseInfo, newName, newSex, newAge, staId));
            } catch (Exception e) {
                JOptionPane.showMessageDialog(parent, e.getMessage(), "错误", JOptionPane.ERROR_MESSAGE);
                return;
            }
            JOptionPane.showMessageDialog(parent, "修改成功！");
        });
        findByCla.addActionListener((event) -> {
            scoreModel.setNumRows(0);
            scoreModel.setColumnIdentifiers(classScoreTitle);
            try {
                query.queryStatement(String.format(queryclassScore, staId), scoreModel);
            } catch (Exception e) {
                JOptionPane.showMessageDialog(parent, e.getMessage(), "错误", JOptionPane.ERROR_MESSAGE);
            }
        });
        findByStu.addActionListener((event) -> {
            scoreModel.setNumRows(0);
            scoreModel.setColumnIdentifiers(stuScoreTitle);
            try {
                query.queryStatement(String.format(queryStuScore, staId), scoreModel);
            } catch (Exception e) {
                JOptionPane.showMessageDialog(parent, e.getMessage(), "错误", JOptionPane.ERROR_MESSAGE);
            }
        });
    }

    @Override
    public void prepareInformation() throws Exception {
        //设置基本信息
        query = SqlQuery.getQueryObj();
        ResultSet set = query.queryStatement(String.format(queryBaseInfo, staId));
        staIdShow.setText(staId);
        set.next();
        name.setText(set.getString("sta_name"));
        sex.setText(set.getString("sta_sex"));
        age.setText(set.getString("sta_age"));
        college.setText(set.getString("col_name"));
        type.setText(set.getString("type"));
        //设置学生信息
        stuInforModel = new UnEditableTableModel();
        stuInforModel.setColumnIdentifiers(stuInfoTitle);
        stuInfor.setModel(stuInforModel);
        query.queryStatement(String.format(queryStuInfo, staId), stuInforModel);
        //初始化成绩model
        scoreModel = new UnEditableTableModel();
        scoreShow.setModel(scoreModel);
    }

    @Override
    public JPanel getRoot() {
        return root;
    }

    public void setParent(JFrame parent) {
        this.parent = parent;
    }

    static class CounsellorFactory extends MainWindowFactory {
        @Override
        JFrame getFrame(String id) throws Exception {
            JFrame frame = new JFrame("辅导员信息管理系统");
            CounsellorInfor infor = new CounsellorInfor(id);
            super.setWindowOption(frame, infor);
            return frame;
        }
    }
}
