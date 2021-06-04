"use strict";

DKTable.prototype = Object.create(DKPlugin.prototype);
function DKTable(identifier) {
    return DKPlugin.call(this, identifier);
}
dk.table = new DKTable("DKTable");
// https://developer.mozilla.org/en-US/docs/Web/API/HTMLTableElement

//The idea is to create a name for every row and every column.
//Currently, we cannot create a column name as eazy as we create row names
//We can name a row, but we have to name each cell in a column.
//This idea: pull a cell, row or column, just from names.
//If by chance a row or column moves, the naming scheme will still work.
// GetIndex(row, column) works until cells are moved and point to different cells.
// GetCellByName(rowName, CellName) should always return the correct cell 
// no matter where it is in the index chart. 

// Example:  DKGetCell("Peter", "Address");
// This should return the cell that is on the Peter Row and the Address Column
// If we add and remove rows or colums, this method should stay functional
// We can do this without altering id's and indexs using rowName and ColumnNama attributes

// (fName) | (age) | (address)   |  (email)
//------------------------------------------------------
//  David  |  28   | 123 Fun St  |  Dave@silly.com
//------------------------------------------------------
//  Mary   |  31   |  P.O. 567   |  Mar02@grape.com
//------------------------------------------------------
//  Peter  |  25   |  464 Go ln. |  PeterDotson@abc.com
//------------------------------------------------------
//  John   |  47   | 09 till pk. |  Johnboy1@mail.com

// The rowName is set to Peter on the <tr> element
// The columnName is set to address on the <td> element

dk.table.init = function dk_table_init() {
    dk.create("DKGui/DKTable.css");
}

dk.table.end = function dk_table_close() {
    dk.close("DKGui/DKTable.css");
}

dk.table.create = function dk_table_create(parent, id, top, bottom, left, right, width, height) {
    const table = document.createElement('table');
    table.setAttribute("dk_table", "table");
    table.id = id;
    table.style.position = "absolute";
    table.style.top = top;
    table.style.bottom = bottom;
    table.style.left = left;
    table.style.right = right;
    table.style.width = width;
    table.style.height = height;
    table.style.overflow = "auto";
    //table.setAttribute('border', '1');
    parent.appendChild(table);
    return table;
}

dk.table.insertRow = function dk_table_insertRow(table, name) {
    if (!name)
        return error("invalid name parameter");
    const row = table.insertRow(-1);
    row.id = "row" + table.rows.length;
    row.setAttribute("name", name);
    return row;
}

dk.table.insertCell = function dk_table_insertCell(table, row, name) {
    if (!name)
        return error("invalid name parameter");
    const cell = row.insertCell(-1);
    cell.id = String.fromCharCode(65 + (cell.cellIndex)) + (row.rowIndex + 1);
    cell.setAttribute("name", name);
    return cell;
}

dk.table.addRow = function dk_table_addRow(table, rowName, cellName) {
    const row = dk.table.insertRow(table, rowName);
    row.id = "row" + table.rows.length;
    //console.debug("dk.table.addRow() -> row.id = "+row.id);
    const row_count = table.rows.length;
    let cell_count = table.rows[0].cells.length;
    !cell_count && (cell_count = 1);

    for (let n = 0; n < cell_count; n++) {
        //Grab the name of the cell from the root column cell if it exists

        //if(!table.rows[0])
        //	return error("dk.table.addRow(): table.rows[0] is invalid");
        !cellName && (cellName = table.rows[0].cells[n].getAttribute("name"));
        const cell = dk.table.insertCell(table, row, cellName);
        //FIXME: The function above is NOT setting the cellName properly.
        //This line is a temporary fix for now. 
        cell.setAttribute("name", table.rows[0].cells[n].getAttribute("name"));
    }
    return row;
}

dk.table.addColumn = function dk_table_addColumn(table, name) {
    let row_count = table.rows.length;
    if (!row_count) {
        //FIXME: no name attribute for the row
        const row = dk.table.insertRow(table /*, name*/
        );
        row_count = 1;
    }
    const cell_count = table.rows[0].cells.length;
    for (let n = 0; n < row_count; n++) {
        const cell = dk.table.insertCell(table, table.rows[n], name);
    }
    //return the created column number
    return table.rows[0].cells.length;
}

dk.table.addRows = function dk_table_addRows(table, count) {
    //The rows added will have no name
    for (let n = 0; n < count; n++) {
        dk.table.addRow(table);
    }
    return table.rows.length;
}

dk.table.addColumns = function dk_table_addColumns(table, count) {
    //The columns added will have no name
    for (let n = 0; n < count; n++) {
        dk.table.addColumn(table);
    }
    return table.rows[0].cells.length;
}

dk.table.deleteRow = function dk_table_deleteRow(table, number) {
    table.deleteRow(number);
    dk.table.updateIds(table);
}

dk.table.deleteColumn = function dk_table_deleteColumn(table, number) {
    for (let n = 0; n < table.rows.length; n++) {
        const row = table.rows[n];
        if (row.cells[number])
            row.deleteCell(number - 1);
    }
    dk.table.updateIds(table);
}

dk.table.updateIds = function dk_table_updateIds(table) {
    for (let n = 0; n < table.rows.length; n++) {
        let row = table.rows[n];
        row.id = "row" + (n + 1);
        for (let nn = 0; nn < row.cells.length; nn++) {
            const cell = row.cells[nn];
            cell.id = String.fromCharCode(65 + (cell.cellIndex)) + (row.rowIndex + 1);
            //cell.innerHTML = cell.id; //For debug
        }
    }
}

dk.table.getCellByIndex = function dk_table_getCellByIndex(table, rowNum, columnNum) {
    const row = table.rows[rowNum];
    const cell = row.cells[columnNum];
    return cell;
}

dk.table.deleteCell = function dk_table_deleteCell(table, rowNum, columnNum) {
    console.debug("dk.table.deleteCell(table," + rowNum + "," + columnNum + ")")
    //FIXME: This doesn't seem to be working properly.
    //I'm using Brave browser which is a fork of chromium.
    //Bug? or user error? 
    const row = table.rows[rowNum];
    //row.deleteCell(columnNum);
    document.removeElement(row.cells[columnNum]);
}

dk.table.getIndex = function dk_table_getIndex(cell) {
    return cell.cellIndex;
}

dk.table.getRowByName = function dk_table_getRowByName(table, rowName) {
    return dk.table.getCellByName(table, rowName);
    /*
    for (let n = 0; n < table.rows.length; n++) {
        if (!table.rows[n].getAttribute("name")) {
            console.warn("row" + n + " has no name attribute");
            return;
        }
        if (table.rows[n].getAttribute("name") == rowName) {
            const row = table.rows[n];
            return row;
        }
    }
    */
}

dk.table.getCellByName = function dk_table_getCellByName(table, rowName, columnName) {
    //TODO: We would like to retrieve a cell by names
    // Example:  DKGetCell("Peter", "Address");
    // This should return the cell that is on the Peter Row and the Address Column
    // If we add and remove rows or colums, this method should stay functional
    // We can do this without altering id's and indexs using rowName and ColumnNama attributes

    // (fName) | (age) | (address)   |  (email)
    //------------------------------------------------------
    //  David  |  28   | 123 Fun St  |  Dave@silly.com
    //------------------------------------------------------
    //  Mary   |  31   |  P.O. 567   |  Mar02@grape.com
    //------------------------------------------------------
    //  Peter  |  25   |  464 Go ln. |  PeterDotson@abc.com
    //------------------------------------------------------
    //  John   |  47   | 09 till pk. |  Johnboy1@mail.com

    // The rowName is set to Peter on the <tr> element
    // The columnName is set to address on the <td> element

    for (let n = 0; n < table.rows.length; n++) {
        if (!table.rows[n].getAttribute("name"))
            return warn("row" + n + " has no name attribute");

        if (table.rows[n].getAttribute("name") == rowName) {
            let row = table.rows[n];
            //if the column name wasn't requested, return the row 
            if (!columnName)
                return row;

            for (let nn = 0; nn < row.cells.length; nn++) {
                if (!row.cells[nn].getAttribute("name"))
                    return warn("row" + n + ", cell" + nn + " has no name attribute");

                //we found the cell, return it's element
                if (row.cells[nn].getAttribute("name") == columnName)
                    return row.cells[nn];
            }
        }
    }
}

dk.table.sort = function dk_table_sort(table_id, columnName, reverse) {
    const table = byId(table_id);
    let col = -1;
    for (let n = 0; n < table.rows[0].cells.length; n++) {
        if (table.rows[0].cells[n].getAttribute("name") == columnName) {
            col = n;
            break;
        }
    }
    if (col < 0)
        return error("columnName invalid");

    const tb = table.tBodies[0];
    // use `<tbody>` to ignore `<thead>` and `<tfoot>` rows
    let tr = Array.prototype.slice.call(tb.rows, 1);
    // put rows into array, 1 to skip the header
    reverse = -((+reverse) || -1);
    tr = tr.sort(function(a, b) {
        // sort rows
        return reverse // `-1 *` if want opposite order
        * (a.cells[col].textContent.trim()// using `.textContent.trim()` for test
        .localeCompare(b.cells[col].textContent.trim()));
    });
    for (let i = 1; i < tr.length; ++i)
        tb.appendChild(tr[i]);
    // append each row in order
}

/*
//TODO
dk.table.sortRow = function dk_table_sortRow(table_id, row, col, reverse) {
    const table = byId(table_id);
    const tb = table.tBodies[0]; // use `<tbody>` to ignore `<thead>` and `<tfoot>` rows
    let tr = Array.prototype.slice.call(tb.rows, 1); // put rows into array, 1 to skip the header
    reverse = -((+reverse) || -1);
    tr = tr.sort(function (a, b) { // sort rows
        return reverse * (a.cells[col].textContent.trim().localeCompare(b.cells[col].textContent.trim()));
    });
    //just append the single row
    //return tb.insertBefore(row, referenceNode)
}
*/
