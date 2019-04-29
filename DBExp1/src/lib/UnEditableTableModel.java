package lib;

import javax.swing.table.DefaultTableModel;

public class UnEditableTableModel extends DefaultTableModel {

    @Override
    public boolean isCellEditable(int row, int column) {
        return false;
    }
}
