//
//  DCUser.swift
//  TechAssistV2
//
//  Created by Raf on 3/4/23.
//

import Foundation

public struct DCUser:Codable{
    
    var dcDoorId: String
    var userName: String
    var userPWD: String
   var displayName: String
    
    init() {
        self.dcDoorId = ""
        self.userName = ""
        self.userPWD = ""
        self.displayName = ""
       }
}
