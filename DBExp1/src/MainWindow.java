import javax.swing.*;

public abstract class MainWindow {
    abstract void prepareInformation() throws Exception;
    protected JFrame parent;

    void setParent(JFrame parent) {
        this.parent = parent;
    }

    abstract JPanel getRoot();

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