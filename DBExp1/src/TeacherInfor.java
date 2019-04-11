import lib.*;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.sql.ResultSet;

public class TeacherInfor extends MainWindow{
    private JButton backToLogin;
    private JButton quit;
    private JButton newCourse;
    private JTextField staName;
    private JTextField staSex;
    private JTextField college;
    private JTextField oritation;
    private JTextField staIdShow;
    private JButton modify;
    private JButton courseList;
    private JPanel root;
    private JTextField staAge;
    private JTable courseTable;
    private JTable xuankeTable;
    private JTable studentTable;
    private JTextField jobTitle;
    private JButton addScoreSingle;

    private String staId;
    private SqlQuery query;

    //用于显示查询结果的语句
    private DefaultTableModel courseInfo;
    private DefaultTableModel postgraduateInfo;
    private DefaultTableModel courseChosen;
    private String[] stuTitle = {"学号", "姓名", "性别", "年龄", "论文数量"};
    private String[] courseTitle = {"课程号", "课程名", "容量", "学分"};
    private String[] chooseCourseTitle = {"学号", "姓名", "学院", "专业", "成绩"};
    //用于查询的语句
    private static String queryBaseInfo = "select * from teacherInfo where `sta_id`=\"%s\";";
    private static String queryCourse = "select cour_id, cour_name, capacity, credit from course where teacher_id=\"%s\";";
    private static String queryPostgraduateInfo = "select stu_id, stu_name, stu_sex, stu_age, paper_num from students natural inner join postgraduate where instructor_id=\"%s\";";
    private static String queryStudent = "select stu_id, stu_name, col_name, dis_name, score from stuInfo natural inner join " +
            "(select student_id stu_id, score from curricula_variable where course_id=\"%s\" and teacher_id=\"%s\") as choose;";

    //用于创建课程和更新选课成绩的语句
    private static String insertCourse = "insert into course values(\"%s\", \"%s\", \"%s\", %s, %s);";
    private static String updateScore = "update curricula_variable set score = %s where teacher_id=\"%s\" and course_id=\"%s\" and student_id=\"%s\"";
    private String chosenCourseId;
    private TeacherInfor(String staId) {
        this.staId = staId;
        quit.addActionListener(e -> System.exit(0));
        backToLogin.addActionListener(e -> {
            parent.dispose();
            LoginIn login = new LoginIn();
            login.setVisible(true);
        });
        //为需要的按钮添加listener
        newCourse.addActionListener(e-> {
            String[] infor = CreateCourse.showCourseInforDialog();
            if(infor == null){
                return;
            }
            try {
                int capacity = Integer.parseInt(infor[2]);
                int credit = Integer.parseInt(infor[3]);
                if(infor[0].length() != 6)
                    throw new Exception("课程号输入错误，只能是6位！");
                query.modifyData(String.format(insertCourse, infor[0], staId, infor[1], infor[2], infor[3]));
            }catch(Exception except){
                JOptionPane.showMessageDialog(parent, except.getMessage(), "错误", JOptionPane.ERROR_MESSAGE);
            }
            JOptionPane.showMessageDialog(parent, "创建课程信息成功！");
            //显示新的开课信息
            courseInfo.setNumRows(0);
            try {
                query.queryStatement(String.format(queryCourse, staId), courseInfo);
            }catch(Exception except){
                JOptionPane.showMessageDialog(parent, except.getMessage(), "错误", JOptionPane.ERROR_MESSAGE);
            }
        });
        courseList.addActionListener(e-> {
            int[] rows = courseTable.getSelectedRows();
            if(rows.length != 1){
                JOptionPane.showMessageDialog(parent, "没有选择课程或选择的课程多于一个，请重新选择！", "错误" ,JOptionPane.ERROR_MESSAGE);
                return;
            }
            chosenCourseId = (String)courseInfo.getValueAt(rows[0], 0);
            courseChosen = new SingleColumnEditableTableModel(4);
            courseChosen.setColumnIdentifiers(chooseCourseTitle);
            xuankeTable.setModel(courseChosen);
            try{
                query.queryStatement(String.format(queryStudent, chosenCourseId, staId), courseChosen);
            }catch(Exception except){
                JOptionPane.showMessageDialog(parent, except.getMessage(), "错误", JOptionPane.ERROR_MESSAGE);
                return;
            }
            JOptionPane.showMessageDialog(parent, "请到选课列表中查看名单");
        });
        modify.addActionListener((event)-> {
            String updateInfor = "update staff set sta_name=\"%s\", sta_sex=\"%s\", sta_age=\"%s\" where sta_id=\"%s\";";
            String age = staAge.getText();
            String name = staName.getText();
            String sex = staSex.getText();
            try {
                query.modifyData(String.format(updateInfor, name, sex, age, staId));
            }catch(Exception e){
                JOptionPane.showMessageDialog(parent, e.getMessage(), "错误", JOptionPane.ERROR_MESSAGE);
            }
            JOptionPane.showMessageDialog(parent, "信息修改成功！");
        });
        addScoreSingle.addActionListener((event)-> {
            int rowNum = courseChosen.getRowCount();
            for(int i = 0; i < rowNum; i++){
                String stuId = (String)courseChosen.getValueAt(i, 0);
                String score = (String)courseChosen.getValueAt(i, 4);
                System.out.print(stuId);
                System.out.print(score);
                try{
                    System.out.print(String.format(updateScore, score, staId, chosenCourseId, stuId));
                    query.modifyData(String.format(updateScore, score, staId, chosenCourseId, stuId));
                }catch(Exception e){
                    JOptionPane.showMessageDialog(parent, String.format("更新学号为%s的学生成绩时发生错误：%s", stuId, e.getMessage()), "错误", JOptionPane.ERROR_MESSAGE);
                }
            }
            JOptionPane.showMessageDialog(parent, "成绩更新完成！");
        });
    }

    @Override
    public void prepareInformation() throws Exception {
        query = SqlQuery.getQueryObj();
        //添加老师基本信息到面板
        ResultSet set = query.queryStatement(String.format(queryBaseInfo, staId));
        if(!set.next()){
            throw new Exception("内部程序错误！");
        }
        staIdShow.setText(staId);
        staAge.setText(set.getString("sta_age"));
        staName.setText(set.getString("sta_name"));
        staSex.setText(set.getString("sta_sex"));
        jobTitle.setText(set.getString("job_title"));
        college.setText(set.getString("col_name"));
        oritation.setText(set.getString("dis_name"));
        //显示开课信息
        courseInfo = new UnEditableTableModel();
        courseInfo.setColumnIdentifiers(courseTitle);
        courseTable.setModel(courseInfo);
        courseTable.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        query.queryStatement(String.format(queryCourse, staId), courseInfo);
        //显示研究生信息
        postgraduateInfo = new UnEditableTableModel();
        postgraduateInfo.setColumnIdentifiers(stuTitle);
        studentTable.setModel(postgraduateInfo);
        studentTable.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        query.queryStatement(String.format(queryPostgraduateInfo, staId), postgraduateInfo);
    }

    @Override
    public JPanel getRoot() {
        return this.root;
    }

    static class TeacherFactory extends MainWindowFactory{
        @Override
        public JFrame getFrame(String id) throws Exception{
            JFrame frame = new JFrame("教师个人信息管理系统");
            TeacherInfor infor = new TeacherInfor(id);
            super.setWindowOption(frame, infor);
            return frame;
        }
    }
}
