package object

import (
	"errors"
	"fmt"
	"graphapi/database"
	"strings"

	"github.com/graphql-go/graphql/language/ast"
	"github.com/mateors/msql"
)

func selectQueryList(FieldASTs []*ast.Field, colkey, tableName string) (sql string) {
	crow := tableFields(FieldASTs)
	scols, isOk := crow[colkey].([]string)
	if isOk {
		selcol := strings.Join(scols, ",")
		sql = fmt.Sprintf("SELECT %s FROM %s;", selcol, tableName)
	}
	return
}

func selectQuery(FieldASTs []*ast.Field, colkey, tableName, id string) (sql string) {
	crow := tableFields(FieldASTs)
	scols, isOk := crow[colkey].([]string)
	if isOk {
		selcol := strings.Join(scols, ",")
		sql = fmt.Sprintf("SELECT %s FROM %s WHERE id='%v';", tableName, selcol, id)
	}
	return
}

func rowToCols(row map[string]interface{}) (tableName string, cols []string) {

	for key, val := range row {
		tableName = key
		cols = val.([]string)
	}
	return
}

func idMapToSQL(id interface{}, selectCols map[string]interface{}) (sql string) {

	tableName, cols := rowToCols(selectCols)
	stext := strings.Join(cols, ",")
	sql = fmt.Sprintf("SELECT %s FROM `%s` WHERE id='%v';", stext, tableName, id)
	return
}

func tableRowById(id interface{}, selectCols map[string]interface{}) (map[string]interface{}, error) {

	sql := idMapToSQL(id, selectCols)
	rows, err := msql.GetAllRowsByQuery(sql, database.DB)
	if err != nil {
		return nil, err
	}
	for _, row := range rows {
		return row, nil
	}
	return nil, fmt.Errorf("invalid id %v", id)
}

func tableFields(FieldASTs []*ast.Field) map[string]interface{} {

	var fields = make(map[string]interface{})
	for _, val := range FieldASTs {
		var cols []string
		for _, sel := range val.SelectionSet.Selections {
			field, ok := sel.(*ast.Field)
			if ok {
				//fmt.Println(">>>>>", field.Name.Kind, field.Name.Value)
				if field.Name.Kind == "Name" {
					cols = append(cols, field.Name.Value)
				}
			}
		}
		fields[val.Name.Value] = cols
	}
	return fields
}

func cid() int {
	return 1
}

func singleInsert(args map[string]interface{}) (map[string]interface{}, error) {

	id, isExist := args["id"]
	if !isExist {
		return nil, errors.New("id value required")
	}
	tableName, isExist := args["table"]
	if !isExist {
		return nil, errors.New("table value required")
	}
	obj := make(map[string]interface{})
	for key, val := range args {
		obj[key] = val
	}
	obj["id"] = id
	obj["table"] = tableName
	obj["todo"] = "insert"
	obj["pkfield"] = "id"
	err := msql.InsertUpdateMap(obj, database.DB)
	if err != nil {
		return nil, err
	}
	return obj, nil
}
