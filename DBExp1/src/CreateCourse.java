import com.mysql.cj.util.StringUtils;

import javax.swing.*;
import java.awt.event.*;

public class CreateCourse extends JDialog {
    private JPanel contentPane;
    private JButton buttonOK;
    private JButton buttonCancel;
    private JTextField courseId;
    private JTextField courseCap;
    private JTextField courseName;
    private JTextField credit;

    private String[] result = null;
    private CreateCourse() {
        setContentPane(contentPane);
        setModal(true);
        getRootPane().setDefaultButton(buttonOK);

        buttonOK.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                onOK();
            }
        });

        buttonCancel.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                onCancel();
            }
        });

        // call onCancel() when cross is clicked
        setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);
        addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {
                onCancel();
            }
        });

        // call onCancel() on ESCAPE
        contentPane.registerKeyboardAction(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                onCancel();
            }
        }, KeyStroke.getKeyStroke(KeyEvent.VK_ESCAPE, 0), JComponent.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT);
    }

    private void onOK() {
        result = new String[4];
        result[0] = courseId.getText().strip();
        result[1] = courseName.getText().strip();
        result[2] = courseCap.getText().strip();
        result[3] = credit.getText().strip();
        for(String str : result){
            if(str.isEmpty()){
                JOptionPane.showMessageDialog(this, "信息未输入完整，请检查输入的信息！");
                return;
            }
        }
        dispose();
    }

    private void onCancel() {
        dispose();
    }

    //显示dialog，返回收集到的课程信息。
    public static String[] showCourseInforDialog() {
        CreateCourse dialog = new CreateCourse();
        dialog.pack();
        dialog.setVisible(true);
        return dialog.result;
    }
}
