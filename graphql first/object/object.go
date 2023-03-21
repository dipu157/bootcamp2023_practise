package object

import (
	"fmt"
	"graphapi/database"
	"strings"

	"github.com/graphql-go/graphql"
	"github.com/mateors/msql"
)

func CompanyRelationalField() *graphql.Field {

	return &graphql.Field{
		Type: CompanyType,
		Resolve: func(p graphql.ResolveParams) (interface{}, error) {

			fmt.Printf("%T %v\n", p.Source, p.Source)
			//map[string]interface {} map[cid:2 email:admin@mateors.com id:1 name:Mostain phone:01672710028]
			company := make(map[string]interface{})
			company["id"] = "sdsdsd1212"
			company["name"] = "MATEORS"
			return company, nil
			//return nil, nil
		},
	}
}

var StudentType = graphql.NewObject( //student
	graphql.ObjectConfig{
		Name:        "Student",
		Description: "Create a student",
		Fields: graphql.Fields{
			"id": &graphql.Field{Type: graphql.NewNonNull(graphql.String)},

			"cid": &graphql.Field{
				Type: CompanyType,
				Resolve: func(p graphql.ResolveParams) (interface{}, error) {

					fmt.Printf("%T %v\n", p.Source, p.Source)
					row, ok := p.Source.(map[string]interface{})
					if ok {
						cid := row["cid"].(string)
						fmt.Println("cid:", cid)
						// crow := tableFields(p.Info.FieldASTs)
						// scols, isOk := crow["cid"].([]string)
						// if isOk {
						// 	selcol := strings.Join(scols, ",")
						// 	sql := fmt.Sprintf("SELECT %s FROM %s WHERE id='%v';", "company", selcol, cid)
						// }
						sql := selectQuery(p.Info.FieldASTs, "cid", "company", cid)
						fmt.Println(">>", sql)

					}
					// company := make(map[string]interface{})
					// company["id"] = "sdsdsd1212"
					// company["name"] = "MATEORS"
					return nil, nil
				},
			},

			"name":   &graphql.Field{Type: graphql.NewNonNull(graphql.String)},
			"email":  &graphql.Field{Type: graphql.NewNonNull(graphql.String)},
			"phone":  &graphql.Field{Type: graphql.NewNonNull(graphql.String)},
			"status": &graphql.Field{Type: graphql.NewNonNull(graphql.Int)},
		},
	},
)

// Create
func CreateStudentField() *graphql.Field {

	return &graphql.Field{
		Type:        StudentType,
		Description: "Get Student info",
		Args: graphql.FieldConfigArgument{
			"name":   &graphql.ArgumentConfig{Type: graphql.NewNonNull(graphql.String)},
			"email":  &graphql.ArgumentConfig{Type: graphql.NewNonNull(graphql.String)},
			"phone":  &graphql.ArgumentConfig{Type: graphql.NewNonNull(graphql.String)},
			"status": &graphql.ArgumentConfig{Type: graphql.NewNonNull(graphql.Int)},
		},
		Resolve: func(p graphql.ResolveParams) (interface{}, error) {

			fmt.Printf("%T, %T\n", p.Source, p.Args) //
			//fmt.Println(p.Source, p.Args)
			// obj := make(map[string]interface{})
			// for key, val := range p.Args {
			// 	obj[key] = val
			// }

			// id := xid.New().String()
			// obj["id"] = id
			// obj["cid"] = cid()
			// obj["todo"] = "insert"
			// obj["table"] = "student"
			// obj["pkfield"] = "id"

			// err := msql.InsertUpdateMap(obj, database.DB)
			// if err != nil {
			// 	return nil, err
			// }
			return nil, nil
		},
	}
}

// Retrieve
func RetrieveStudentField() *graphql.Field {

	return &graphql.Field{
		Type:        StudentType,
		Description: "Get Student info",
		Args: graphql.FieldConfigArgument{
			"id": &graphql.ArgumentConfig{Type: graphql.NewNonNull(graphql.String)},
			//"email":  &graphql.ArgumentConfig{Type: graphql.NewNonNull(graphql.String)},

		},
		Resolve: func(p graphql.ResolveParams) (any, error) {

			//fmt.Printf("%T, %T\n", p.Source, p.Args) //
			fmt.Println(p.Source, p.Args, p.Info.VariableValues, p.Info.FieldASTs)
			row := tableFields(p.Info.FieldASTs)
			//fmt.Println(row)

			id := p.Args["id"]
			var tableName string
			var selectedCols []string
			// for key, val := range row {
			// 	tableName = key
			// 	selectedCols = val.([]string)
			// }
			tableName, selectedCols = rowToCols(row)

			// tableName := "student"
			// var selectCols string
			// cols, err := msql.ReadTable2Columns(tableName, database.DB)
			// if err != nil {
			// 	return nil, err
			// }

			// tmpCols := []string{}
			// for _, val := range selectedCols {

			// 	for _, c := range cols {
			// 		if c == val {
			// 			tmpCols = append(tmpCols, val)
			// 		}
			// 	}
			// }

			selectCols := strings.Join(selectedCols, ",") //tmpCols | selectedCols
			sql := fmt.Sprintf("SELECT %s FROM `%s` WHERE id='%v';", selectCols, tableName, id)
			fmt.Println(sql)
			rows, err := msql.GetAllRowsByQuery(sql, database.DB)
			if err != nil {
				return nil, err
			}

			for _, row := range rows {
				return row, nil
			}
			// vamp := make(map[string]interface{})
			// vamp["name"] = "rubel"
			// //vamp["email"] = "admin@mateors.com"
			// return vamp, nil
			return nil, fmt.Errorf("invalid id %v", id)
		},
	}
}

// Retrieve
func CompanyById() *graphql.Field {

	return &graphql.Field{
		Type:        CompanyType,
		Description: "Get Company info",
		Args: graphql.FieldConfigArgument{
			"id": &graphql.ArgumentConfig{Type: graphql.NewNonNull(graphql.Int)},
		},
		Resolve: func(p graphql.ResolveParams) (any, error) {

			//fmt.Printf("%T, %T\n", p.Source, p.Args) //
			fmt.Println(p.Source, p.Args, p.Info.VariableValues, p.Info.FieldASTs)
			colmap := tableFields(p.Info.FieldASTs)
			cols := colmap["company"].([]string)
			id := p.Args["id"]

			selectColumn := strings.Join(cols, ",")
			sql := fmt.Sprintf("SELECT %s FROM %s WHERE id='%v';", selectColumn, "company", id)
			rows, err := msql.GetAllRowsByQuery(sql, database.DB)
			if err != nil {
				return nil, err
			}

			rmap := make(map[string]interface{})
			if len(rows) == 1 {
				rmap = rows[0]
			}
			if len(rows) == 0 {
				return nil, fmt.Errorf("invalid id %v", id)
			}
			return rmap, nil
		},
	}
}

// List all company
func ListCompany() *graphql.Field {

	return &graphql.Field{
		Type:        graphql.NewList(CompanyType),
		Description: "Get Company list",
		Resolve: func(p graphql.ResolveParams) (interface{}, error) {

			//fmt.Printf("%T, %T\n", p.Source, p.Args) //
			fmt.Println(p.Source, p.Args, p.Info.VariableValues, p.Info.Path.Key)
			colmap := tableFields(p.Info.FieldASTs)
			funclabel := fmt.Sprint(p.Info.Path.Key)
			cols := colmap[funclabel].([]string) //

			selectColumn := strings.Join(cols, ",")
			sql := fmt.Sprintf("SELECT %s FROM %s WHERE status!=9;", selectColumn, "company")
			rows, err := msql.GetAllRowsByQuery(sql, database.DB)
			if err != nil {
				return nil, err
			}
			return rows, nil
		},
	}
}

// Object == Table
/*
type Company{
    id: Int!
    name: String!
	phone: String!
    email: Email
    create_date: DateTime
    status(=0): Int!
}
*/
var CompanyType = graphql.NewObject(graphql.ObjectConfig{
	Name:        "Company",
	Description: "Create company info",
	Fields: graphql.Fields{
		"id":          &graphql.Field{Type: graphql.NewNonNull(graphql.Int)},
		"name":        &graphql.Field{Type: graphql.NewNonNull(graphql.String)},
		"phone":       &graphql.Field{Type: graphql.NewNonNull(graphql.String)},
		"email":       &graphql.Field{Type: graphql.NewNonNull(graphql.String)},
		"create_date": &graphql.Field{Type: graphql.NewNonNull(graphql.String)},
		"status":      &graphql.Field{Type: graphql.NewNonNull(graphql.Int)},
	},
})

// Create|Insert,Update,Delete | Mutation
func CreateCompanyField() *graphql.Field {

	return &graphql.Field{
		Type:        CompanyType,
		Description: "Get Company info",
		Args: graphql.FieldConfigArgument{
			"name":        &graphql.ArgumentConfig{Type: graphql.NewNonNull(graphql.String)},
			"email":       &graphql.ArgumentConfig{Type: graphql.NewNonNull(graphql.String)},
			"phone":       &graphql.ArgumentConfig{Type: graphql.NewNonNull(graphql.String)},
			"create_date": &graphql.ArgumentConfig{Type: graphql.NewNonNull(graphql.String)},
			"status":      &graphql.ArgumentConfig{Type: graphql.NewNonNull(graphql.Int)},
		},
		Resolve: func(p graphql.ResolveParams) (interface{}, error) {

			fmt.Println(p.Args, p.Info.FieldASTs, p.Source)
			var id string
			sql := "SELECT IFNULL(max(id),0)+1 AS id FROM `company` WHERE 1;"
			rows, err := msql.GetAllRowsByQuery(sql, database.DB)
			if err != nil {
				return nil, err
			}
			if len(rows) == 1 {
				for _, row := range rows {
					fmt.Printf(">> %T %v\n", row, row)
				}
				id = fmt.Sprint(rows[0]["id"])
			}

			// //fmt.Println("id:", id)
			// //INSERT INTO `company` (`id`,`name`,`email`,`create_date`, `status`)VALUES ('21','mateors','admin@mateors.com','2023-03-15 17:41:32','1');
			obj := make(map[string]interface{})
			for key, val := range p.Args {
				obj[key] = val
			}
			//id := xid.New().String()
			obj["id"] = id
			obj["todo"] = "insert"
			obj["table"] = "company"
			obj["pkfield"] = "id"
			err = msql.InsertUpdateMap(obj, database.DB)
			if err != nil {
				return nil, err
			}
			//p.Args["id"] = id
			//p.Args["table"] = "company"
			//return singleInsert(p.Args)

			fmt.Println(">>", id)

			return obj, nil
		},
	}
}

// Update | Mutation
func UpdateCompanyField() *graphql.Field {

	return &graphql.Field{
		Type:        CompanyType,
		Description: "Get Company info",
		Args: graphql.FieldConfigArgument{
			"id":     &graphql.ArgumentConfig{Type: graphql.NewNonNull(graphql.Int)},
			"name":   &graphql.ArgumentConfig{Type: graphql.String},
			"email":  &graphql.ArgumentConfig{Type: graphql.String},
			"phone":  &graphql.ArgumentConfig{Type: graphql.String},
			"status": &graphql.ArgumentConfig{Type: graphql.NewNonNull(graphql.Int)},
		},
		Resolve: func(p graphql.ResolveParams) (interface{}, error) {

			//fmt.Println(p.Args, p.Info.FieldASTs, p.Source)
			colmap := tableFields(p.Info.FieldASTs)
			cols := colmap["updateCompany"].([]string)
			id := p.Args["id"]

			obj := make(map[string]interface{})
			for key, val := range p.Args {
				obj[key] = val
			}
			obj["todo"] = "update"
			obj["table"] = "company"
			obj["pkfield"] = "id"
			err := msql.InsertUpdateMap(obj, database.DB)
			if err != nil {
				return nil, err
			}

			selectColumn := strings.Join(cols, ",")
			sql := fmt.Sprintf("SELECT %s FROM %s WHERE id='%v';", selectColumn, "company", id)
			rows, err := msql.GetAllRowsByQuery(sql, database.DB)
			if err != nil {
				return nil, err
			}

			rmap := make(map[string]interface{})
			if len(rows) == 1 {
				rmap = rows[0]
			}
			if len(rows) == 0 {
				return nil, fmt.Errorf("invalid id %v", id)
			}
			return rmap, nil
		},
	}
}

// Delete | Mutation
func DeleteCompanyField() *graphql.Field {

	return &graphql.Field{
		Type:        CompanyType,
		Description: "Delete Company info",
		Args: graphql.FieldConfigArgument{
			"id": &graphql.ArgumentConfig{Type: graphql.NewNonNull(graphql.Int)},
		},
		Resolve: func(p graphql.ResolveParams) (interface{}, error) {

			//fmt.Println(p.Args, p.Info.FieldASTs, p.Source)
			colmap := tableFields(p.Info.FieldASTs)
			cols := colmap["deleteCompany"].([]string)
			id := p.Args["id"]

			obj := make(map[string]interface{})
			for key, val := range p.Args {
				obj[key] = val
			}
			obj["todo"] = "update"
			obj["table"] = "company"
			obj["pkfield"] = "id"
			obj["status"] = 9
			err := msql.InsertUpdateMap(obj, database.DB)
			if err != nil {
				return nil, err
			}

			selectColumn := strings.Join(cols, ",")
			sql := fmt.Sprintf("SELECT %s FROM %s WHERE id='%v';", selectColumn, "company", id)
			rows, err := msql.GetAllRowsByQuery(sql, database.DB)
			if err != nil {
				return nil, err
			}

			rmap := make(map[string]interface{})
			if len(rows) == 1 {
				rmap = rows[0]
			}
			if len(rows) == 0 {
				return nil, fmt.Errorf("invalid id %v", id)
			}
			return rmap, nil
		},
	}
}

// Retrieve
func ListStudentField() *graphql.Field {

	return &graphql.Field{
		Type:        graphql.NewList(StudentType),
		Description: "Get Student list",
		Args: graphql.FieldConfigArgument{
			"token": &graphql.ArgumentConfig{Type: graphql.NewNonNull(graphql.String)},
		},
		Resolve: func(p graphql.ResolveParams) (interface{}, error) {

			//fmt.Printf("%T, %v\n", p.Info.Path.Key, p.Info.Path.Key) //
			pathKey := fmt.Sprint(p.Info.Path.Key)
			//row := tableFields(p.Info.FieldASTs)
			//fmt.Println(row)
			sql := selectQueryList(p.Info.FieldASTs, pathKey, "student")
			fmt.Println(sql)
			rows, err := msql.GetAllRowsByQuery(sql, database.DB)
			if err != nil {
				return nil, err
			}
			return rows, nil
		},
	}
}
