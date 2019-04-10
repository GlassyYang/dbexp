package lib;

import javax.swing.table.DefaultTableModel;

public class SingleColumnEditableTableModel extends DefaultTableModel {

    private int column;

    public SingleColumnEditableTableModel(int column) {
        this.column = column;
    }

    @Override
    public boolean isCellEditable(int row, int column) {
        return column == this.column;
    }
}
