//
//  DBManagerV2.swift
//  TechAssistV2
//
//  Created by Raf on 3/4/23.
//


import Foundation
import SQLite

class DBManagerV2{
    
    var db: Connection?
    
    let dcDoor = Table("dcDoor")
    let dcDoorId = Expression<String>("dcDoorId")
    let userName = Expression<String?>("userName")
    let userPWD = Expression<String>("userPwd")
    let displayName = Expression<String>("displayName")
   
    
//    var databaseURL: URL = {
//
//        return (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("db.sqlite3"))!
//      }()
    //end of mine
    
    // this becomes the final path to the db
    var mydb = String()
    
    init(mydb:String){
        
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("db.emdb")

        if FileManager.default.fileExists(atPath: fileURL!.path) {
            do {
                 db = try Connection(fileURL!.path)
                print(" thinks it exista")
                // Connection is now established to the existing database file
            } catch {
                // Handle error
                print("Error: \(error.localizedDescription)")
            }
        } else {
            do {
                
                print("thinks it does not exist")
                db = try Connection(fileURL!.path)
               // try db.execute("CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)")
                setupDB()
                // create a new "users" table in the database
            } catch {
                // Handle error
                print("Error: \(error.localizedDescription)")
            }
        }
      






        
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

