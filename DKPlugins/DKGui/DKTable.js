"use strict";

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

function DKTable_Create(parent, id, top, bottom, left, right, width, height) {
    const table = document.createElement('table');
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

function DKTable_InsertRow(table, name) {
    if (!name)
        return error("invalid name parameter");

    const row = table.insertRow(-1);
    row.id = "row" + table.rows.length;
    row.setAttribute("name", name);
    return row;
}

function DKTable_InsertCell(table, row, name) {
    if (!name)
        return error("invalid name parameter");

    const cell = row.insertCell(-1);
    cell.id = String.fromCharCode(65 + (cell.cellIndex)) + (row.rowIndex + 1);
    cell.setAttribute("name", name);
    return cell;
}

function DKTable_AddRow(table, rowName, cellName) {
    const row = DKTable_InsertRow(table, rowName);
    row.id = "row" + table.rows.length;
    //console.debug("DKTableAddRow() -> row.id = "+row.id);
    const row_count = table.rows.length;
    let cell_count = table.rows[0].cells.length;
    !cell_count && (cell_count = 1);

    for (let n = 0; n < cell_count; n++) {
        //Grab the name of the cell from the root column cell if it exists
        
        //if(!table.rows[0])
        //	return error("DKTableAddRow(): table.rows[0] is invalid");
        !cellName && (cellName = table.rows[0].cells[n].getAttribute("name"));
        const cell = DKTable_InsertCell(table, row, cellName);
        //FIXME: The function above is NOT setting the cellName properly.
        //This line is a temporary fix for now. 
        cell.setAttribute("name", table.rows[0].cells[n].getAttribute("name"));
    }
    return row;
}

function DKTable_AddColumn(table, name) {
    let row_count = table.rows.length;
    if (!row_count) {
        //FIXME: no name attribute for the row
        const row = DKTable_InsertRow(table /*, name*/
        );
        row_count = 1;
    }
    const cell_count = table.rows[0].cells.length;
    for (let n = 0; n < row_count; n++) {
        const cell = DKTable_InsertCell(table, table.rows[n], name);
    }
    //return the created column number
    return table.rows[0].cells.length;
}

function DKTable_AddRows(table, count) {
    //The rows added will have no name
    for (let n = 0; n < count; n++) {
        DKTable_AddRow(table);
    }
    return table.rows.length;
}

function DKTable_AddColumns(table, count) {
    //The columns added will have no name
    for (let n = 0; n < count; n++) {
        DKTable_AddColumn(table);
    }
    return table.rows[0].cells.length;
}

function DKTable_DeleteRow(table, number) {
    table.deleteRow(number);
    DKTable_UpdateIds(table);
}

function DKTable_DeleteColumn(table, number) {
    for (let n = 0; n < table.rows.length; n++) {
        const row = table.rows[n];
        if (row.cells[number])
            row.deleteCell(number - 1);
    }
    DKTable_UpdateIds(table);
}

function DKTable_UpdateIds(table) {
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

function DKTable_GetCellByIndex(table, rowNum, columnNum) {
    const row = table.rows[rowNum];
    const cell = row.cells[columnNum];
    return cell;
}

function DKTable_DeleteCell(table, rowNum, columnNum) {
    console.debug("DKTableDeleteCell(table," + rowNum + "," + columnNum + ")")
    //FIXME: This doesn't seem to be working properly.
    //I'm using Brave browser which is a fork of chromium.
    //Bug? or user error? 
    const row = table.rows[rowNum];
    //row.deleteCell(columnNum);
    document.removeElement(row.cells[columnNum]);
}

function DKTable_GetIndex(cell) {
    return cell.cellIndex;
}

function DKTable_GetRowByName(table, rowName) {
    return DKTable_GetCellByName(table, rowName);
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

function DKTable_GetCellByName(table, rowName, columnName) {
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

function DKTable_Sort(table_id, columnName, reverse) {
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
function DKTable_SortRow(table_id, row, col, reverse) {
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
