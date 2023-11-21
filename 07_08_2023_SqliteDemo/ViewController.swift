//
//  ViewController.swift
//  07_08_2023_SqliteDemo
//
//  Created by Vishal Jagtap on 06/11/23.
//

import UIKit

class ViewController: UIViewController {
   
    var employees : [Employee] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        var dbHelper = DBHelper()
        print("-----Insert employee records called-----")
        dbHelper.insertEmployeeRecord(empId: 12, empName: "Prathamesh")
        dbHelper.insertEmployeeRecord(empId: 13, empName: "Rishikesh")
        dbHelper.insertEmployeeRecord(empId: 14, empName: "Shailesh")
        
        print("-----Retrive records-----")
        employees = dbHelper.retriveEmployeeRecords()
        for eachEmployee in employees{
            print("\(eachEmployee.empId) -- \(eachEmployee.empName)")
        }
        print("-----Delete Called------")
        dbHelper.deleteEmployeeRecord(empId: 11)
    }
}
