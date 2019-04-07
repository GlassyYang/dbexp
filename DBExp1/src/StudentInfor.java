import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StudentInfor implements MainWindow{
    private JPanel root;
    private JButton quit;
    private JButton backToLogin;
    private JTextField stuIdShow;
    private JTextField stuName;
    private JTextField stuSex;
    private JButton commitModify;
    private JTextField collage;
    private JTextField discipiline;
    private JTextField counName;
    private JButton refresh;
    private JButton chooseCourse;
    private JTextField headTeacher;
    private JTextField instructorName;
    private JLabel instructorLabel;
    private JTextField className;
    private JTextField stuAge;
    private JTextField paperText;
    private JLabel paperLabel;
    private JTable scoreShow;
    private DefaultTableModel scoreModel;
    private DefaultTableModel courseInfo;
    private JFrame parent;
    private JTable courseInfoTable;
    private String stuId;
    private static String existQuery = "select 1 where exists(select * from undergraduate where stu_id=\"";
    private static String undergraduateInfo = "select * from undergraduateInfo where stu_id=\"";
    private static String postgraduateInfo = "select * from postgraduateInfo where stu_id=\"";
    private SqlQuery query = null;

    //用于更新显示的成绩的语句
    private static String scoreQuery = "Select * from score where student_id = \"";
    private static String[] columnName = {"课程号", "授课教师", "成绩"};
    //用于更新基本信息的语句
    private static String updateBaseInfo = "update students set stu_name=\"%s\", stu_age=%s, stu_sex=\"%s\" where stu_id=\"%s\";";
    //用于选课信息的语句
    private static String[] courseColumn = {"课程号", "课程名", "授课教师", "容量", "已选人数"};
    private static String courseInfoQuery = "select * from courseInfo";
    //查询是否已经有存在的选课记录了，这里的要求是课程id不能相同，即使是选了不同老师的相同的课也是不行的。
    private static String checkInsert = "select * from curricula_variable where course_id=\"%s\" and student_id=\"%s\";";
    private static String insert = "insert into curricula_variable(student_id, course_id, teacher_id) values(\"%s\", \"%s\", \"%s\")";
    //记住课程的开课老师的职工号
    private List<Tuple> teacherInfo;
    private StudentInfor(String stuId){
        this.stuId = stuId;
        scoreModel = new DefaultTableModel();
        courseInfo = new DefaultTableModel();
        quit.addActionListener(e -> {
            System.exit(0);
        });
        backToLogin.addActionListener(e -> {
            parent.dispose();
            LoginIn login = new LoginIn();
            login.setVisible(true);
        });
        refresh.addActionListener(new RefreshScore());
        commitModify.addActionListener(e -> {
            String newName = stuName.getText();
            String newAge = stuAge.getText();
            String newSex = stuSex.getText();
            try {
                query.modifyData(String.format(updateBaseInfo, newName, newAge, newSex, stuId));
                JOptionPane.showMessageDialog(parent, "更新信息成功！");
            }catch(SQLException except){
                JOptionPane.showMessageDialog(parent, "更新信息失败！" + except.getMessage());
            }
        });
        chooseCourse.addActionListener(e -> {
            int[] selectedRow = courseInfoTable.getSelectedColumns();
            for(int i = 0; i < selectedRow.length; i++){
                String courseId = (String)courseInfoTable.getValueAt(selectedRow[i], 0);
                try {
                    if (query.existItem(String.format(checkInsert, courseId, stuId))) {
                        query.modifyData(String.format(insert, stuId, courseId, teacherInfo.get(selectedRow[i])));
                    }
                }catch(Exception except){
                    JOptionPane.showMessageDialog(parent, except.getMessage(), "错误", JOptionPane.ERROR_MESSAGE);
                }
            }
        });
    }

    @Override
    public void prepareInformation() throws Exception {
        query = SqlQuery.getQueryObj();
        scoreModel.setColumnIdentifiers(columnName);
        scoreShow.setModel(scoreModel);
        courseInfo.setColumnIdentifiers(courseColumn);
        courseInfoTable.setModel(courseInfo);
        courseInfoTable.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        courseInfoTable.getTableHeader().setReorderingAllowed(false);
        StringBuilder build = new StringBuilder();
        build.append(existQuery);
        build.append(stuId);
        build.append("\");");
        boolean isUndergraduate = false;
        if(query.existItem(build.toString())){
            isUndergraduate = true;
        }
        build.setLength(0);
        if(isUndergraduate){
            build.append(undergraduateInfo);
        }else{
            build.append(postgraduateInfo);
        }
        build.append(stuId);
        build.append("\";");
        ResultSet set = query.queryStatement(build.toString());
        if(!set.next()){
            throw new Exception("程序内部错误！");
        }
        stuIdShow.setText(stuId);
        stuAge.setText(set.getString("stu_age"));
        stuName.setText(set.getString("stu_name"));
        stuSex.setText(set.getString("stu_sex"));
        collage.setText(set.getString("col_name"));
        discipiline.setText(set.getString("dis_name"));
        className.setText(set.getString("class_id"));
        headTeacher.setText(set.getString("teacher_name"));
        counName.setText(set.getString("counsellor_name"));
        if(!isUndergraduate){
            paperLabel.setText("论文数量：");
            paperText.setText(set.getString("paper_num"));
            instructorName.setText(set.getString("instructor_name"));
        }else{
            paperLabel.setVisible(false);
            paperText.setVisible(false);
            instructorLabel.setText("创新学分数：");
            instructorName.setText(set.getString("extra_credit"));
        }
        //显示成绩信息
        RefreshScore refresh = new RefreshScore();
        refresh.actionPerformed(null);
        //显示可选课程
        set = query.queryStatement(String.format(courseInfoQuery));
        String[] temp = new String[5];
        int count = 0;
        teacherInfo = new ArrayList<>();
        while(set.next()){
            for(int i = 0; i < temp.length; i++){
                temp[i] = set.getString(courseColumn[i]);
            }
            courseInfo.addRow(temp);
            teacherInfo.add(new Tuple(count, set.getString("teacher_id")));
            count++;
        }
    }

    public void setParent(JFrame parent) {
        this.parent = parent;
    }

    private class RefreshScore implements ActionListener{
        @Override
        public void actionPerformed(ActionEvent e) {
            scoreModel.setNumRows(0);
            StringBuilder build = new StringBuilder();
            build.append(scoreQuery);
            build.append(stuId);
            build.append("\";");
            try {
                query.queryStatement(build.toString(), scoreModel);
            }catch(SQLException except){
                JOptionPane.showMessageDialog(parent, except.getMessage(), "错误", JOptionPane.ERROR_MESSAGE);
                System.exit(0);
            }
        }
    }

    public class Tuple{
        final private int index;
        final private String teacherId;

        public Tuple(int index, String teacherId) {
            this.index = index;
            this.teacherId = teacherId;
        }

        public int getIndex() {
            return index;
        }

        public String getTeacherId() {
            return teacherId;
        }
    }

    public static JFrame getFrame(String id){
        JFrame frame = new JFrame("学生个人信息管理");
        StudentInfor infor = new StudentInfor(id);
        try {
            infor.prepareInformation();
        }catch(Exception e){
            JOptionPane.showMessageDialog(null, e.getMessage(), "错误", JOptionPane.ERROR_MESSAGE);
            System.exit(0);
        }
        infor.setParent(frame);
        frame.setContentPane(infor.root);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(500, 400);
        return frame;
    }
}


