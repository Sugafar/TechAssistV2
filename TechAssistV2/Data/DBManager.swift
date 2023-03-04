//
//  DBManager.swift
//  TechAssistV2
//
//  Created by Raf on 3/4/23.
//

import Foundation
import SQLite

class DBManager{
    
    var db: Connection?
    
    let dcDoor = Table("dcDoor")
    let dcDoorId = Expression<String>("dcDoorId")
    let userName = Expression<String?>("userName")
    let userPWD = Expression<String>("userPwd")
    let displayName = Expression<String>("displayName")
   
    
    static let databaseURL: URL = {
           // Get the document directory path
           guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
               fatalError("Could not access document directory")
           }
           
           // Add the database filename to the document directory path
           return documentsDirectory.appendingPathComponent("db.sqlite3")
       }()
    
    
    // this becomes the final path to the db
    var mydb = String()
    
    init(mydb:String){
        
        //start
        
       
        
        
        //end
        
        
        self.mydb = DBManager.databaseURL.absoluteString
        db = try Connection(mydb)
       
        
       
       
    }
    
    func setupDB(){
        do {
            try db!.run(dcDoor.create { t in
                t.column(dcDoorId, primaryKey: true)
                t.column(userName)
                t.column(userPWD)
                t.column(displayName)
                
                print("db is setup")
            })
            
        }
        catch{
            print("hi")
        }
        
        
    }//end of setupDB Func
    
    public func addRecord(usr:DCUser){
        
        do{
            let insert = dcDoor.insert(dcDoorId <- usr.dcDoorId,userName <- usr.userName, userPWD <- usr.userPWD,displayName <- usr.displayName)
            let rowid = try db!.run(insert)
        }
        catch{
            let errorMessage = error.localizedDescription
            print("error adding record: \(errorMessage)")
        }
        
    }// end of add record func
    
    public func readRecord() -> DCUser{
        var myUser = DCUser()
        do{
            for user in try db!.prepare(dcDoor) {
                myUser.dcDoorId = (user[dcDoorId])
                myUser.userName = (user[userName]!)
                myUser.userPWD = (user[userPWD])
                myUser.displayName = (user[displayName])
                print("dcDoorId: \(user[dcDoorId]), userName: \(String(describing: user[userName])), userPWD: \(user[userPWD]), displayName: \(user[displayName])")
                // id: 1, name: Optional("Alice"), email: alice@mac.com
            }
        }
        catch{
            print("error")
        }
        
        
        return myUser
    } // end of readRecord func
    
    public func modifyRecord(usr:DCUser){
        
        do{
           
                       let id = Expression<String>(usr.dcDoorId)
           
            let email = Expression<String>("email")
            
            
            let myRecord = dcDoor.filter(dcDoorId == usr.dcDoorId)
            try db!.run(myRecord.update(userName <- usr.userName))

        }
        catch{
            print("error reading record")
        }
        
        
    }
    
}
