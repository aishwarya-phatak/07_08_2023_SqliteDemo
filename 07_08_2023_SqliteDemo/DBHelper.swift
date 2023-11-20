//
//  DBHelper.swift
//  07_08_2023_SqliteDemo
//
//  Created by Vishal Jagtap on 07/11/23.
//

import Foundation
import SQLite3

class DBHelper{
    var dbPath : String = "my_dbiOS.sqlite"
    var db : OpaquePointer?
    
    init() {
        self.db = openDatabase()
        print("db is : \(db)")
        self.createEmployeeTable()
    }
    
    func openDatabase()->OpaquePointer?{
        let fileUrl = try! FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false).appendingPathExtension(dbPath)
        print("File Url -- \(fileUrl)")
        
        if sqlite3_open(
            fileUrl.path,&db) == SQLITE_FAIL{
            print("Error while creating database")
           return nil
        } else {
            print("Database created successfully -- \(dbPath)")
            print("Database is : \(db)")
            return db
        }
    }
    
    func createEmployeeTable(){
        let createTableQueryString = "CREATE TABLE IF NOT EXISTS employee(EmpId INTEGER, EmpName TEXT);"
        var createTableStatment : OpaquePointer? = nil
        if sqlite3_prepare_v2(db,createTableQueryString,-1,&createTableStatment,nil) == SQLITE_OK {
        
            print("The table statement prepared successfully")
            
            if sqlite3_step(createTableStatment) == SQLITE_DONE{
                print("create table statement done")
            } else {
                print("Table creation Unsuccessful")
            }
        } else {
            print("Statement Preparartion Unsuccessful")
        }
        sqlite3_finalize(createTableStatment)
    }
    
    func insertEmployeeRecord(empId : Int, empName : String){
        let insertQueryString = "INSERT INTO Employee(EmpId,EmpName) VALUES(?,?);"
        var insertStatement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db,
                              insertQueryString,
                              -1,
                              &insertStatement,
                              nil) == SQLITE_OK{
            
            sqlite3_bind_int(insertStatement, 0, Int32(empId))
            sqlite3_bind_text(insertStatement,
                              1,
                              (empName as NSString).utf8String,
                              -1,
                              nil)
        } else {
            print("Insert Statement Preparation Failed")
        }
        sqlite3_finalize(insertStatement)
    }
    
    
    func deleteEmployeeRecord(empId : Int){
        let deleteQueryString = "DELETE FROM Employee WHERE EmpId = ?;"
        var deleteStatement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteQueryString, -1, &deleteStatement, nil) == SQLITE_OK{
            print("Delete Statement Prepared Successfully")
            sqlite3_bind_int(deleteStatement, 1, Int32(empId))
        } else {
            print("Delete Statement Preparation Failed")
        }
        sqlite3_finalize(deleteStatement)
    }

    
}
