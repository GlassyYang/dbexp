import javax.swing.*;
import java.awt.*;

public abstract class MainWindow {
    abstract void prepareInformation() throws Exception;
    protected JFrame parent;

    void setParent(JFrame parent) {
        this.parent = parent;
    }

    abstract JPanel getRoot();
    static void setMediate(JFrame frame){
        int windowWidth = frame.getWidth();
        int windowHeight = frame.getHeight();
        Toolkit kit = Toolkit.getDefaultToolkit();
        Dimension screenSize = kit.getScreenSize();
        int screenWidth = screenSize.width;
        int screenHeight = screenSize.height;
         frame.setLocation(screenWidth/2-windowWidth/2, screenHeight/2-windowHeight/2);
    }
}
abstract class MainWindowFactory{
    abstract JFrame getFrame(String id) throws Exception;
    protected void setWindowOption(JFrame frame, MainWindow window) throws Exception{
        window.setParent(frame);
        window.prepareInformation();
        frame.setContentPane(window.getRoot());
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(500, 400);
    }
}