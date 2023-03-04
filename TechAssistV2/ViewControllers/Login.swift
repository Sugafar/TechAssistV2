//
//  Login.swift
//  TechAssist
//
//  Created by Raf on 3/1/23.
//

import UIKit







class Login:UIViewController{
    
    
    //UI
    let lblTitle = UILabel()
    let lblUserName = UILabel()
    let tfUserName = UITextField()
    let lblUserPWD = UILabel()
    let tfUserPWD = UITextField()
    let btnLogin = UIButton()
   
   
    var dbm = DBManager(mydb: "")
    var aUser = DCUser()
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor.lightGray
        self.navigationController?.navigationBar.tintColor = UIColor.blue
       
       
        tfUserName.delegate = self
         tfUserPWD.delegate = self
        tfUserName.tag = 1
         tfUserPWD.tag = 2
        tfUserName.text = aUser.displayName
        
       
        setupUI()
        
    }
    
   

    
    @objc func sendItHome(){
        
        var sendUser = DCUser()
        sendUser.userName = tfUserName.text ?? ""
        sendUser.userPWD = tfUserPWD.text ?? ""
        
        fetchingAPIDataWithData(usr:sendUser){
            
            result in self.aUser = result
            print("My Display Name is: \(self.aUser.displayName)")
            
            // this will access the main thread
            DispatchQueue.main.async { [self] in
                // Set the text field's text to the response
                self.tfUserName.text = self.aUser.displayName
                
                if(self.aUser.displayName.count > 5) // we have a user
                {
                    print("I have a user: \(aUser) ")
                    dbm.addRecord(usr: aUser)
                    
                  
                    let nextScreenMenu = Menu()
                    
                   
                    
                    nextScreenMenu.title = "Menu"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        self.navigationController?.pushViewController(nextScreenMenu, animated: true)
                    })
                }
                
            }
            
            
        }
    }
        
 //   }
    
    func fetchingAPIDataWithData(usr:DCUser,completion: @escaping (DCUser) ->Void){
        
       // var aUser = usr
             guard let url = URL(string: "https://dctemp.azurewebsites.net/api/apiUser/") else {
                 print("Error: cannot create URL")
                 return
             }
             
        print(usr.userPWD)
        print(usr.userName)
             // Convert model to JSON data
             guard let jsonData = try? JSONEncoder().encode(usr) else {
                 print("Error: Trying to convert model to JSON data")
                 return
             }
             
             // Create the request
             var request = URLRequest(url: url)
             request.httpMethod = "PUT"
             request.setValue("application/json", forHTTPHeaderField: "Content-Type")
             request.httpBody = jsonData
          let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if (data != nil) && error == nil{
                do {
                    let parsingData = try JSONDecoder().decode(DCUser.self, from: data!)
                    print(parsingData)
                    completion(parsingData)
                }catch {
                    
                    print("Parsing Error")
                }
            }
        }
    dataTask.resume()
        
    }
    
    
    func fetchingAPIData(completion: @escaping (DCUser) ->Void){
        
       // var aUser = usr
             guard let url = URL(string: "https://dctemp.azurewebsites.net/api/apiUser/") else {
                 print("Error: cannot create URL")
                 return
             }
             
            
             // Convert model to JSON data
//             guard let jsonData = try? JSONEncoder().encode(usr) else {
//                 print("Error: Trying to convert model to JSON data")
//                 return
//             }
             
             // Create the request
             var request = URLRequest(url: url)
             request.httpMethod = "PUT"
             request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            // request.httpBody = jsonData
          let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if (data != nil) && error == nil{
                do {
                    let parsingData = try JSONDecoder().decode(DCUser.self, from: data!)
                    print(parsingData)
                    completion(parsingData)
                }catch {
                    
                    print("Parsing Error")
                }
            }
        }
    dataTask.resume()
        
    }
    
    func setupUI(){
        //Begin the image
        // Get the screen width
        let screenWidth = UIScreen.main.bounds.width
        
        // Set the desired width of the image
        let desiredWidth: CGFloat = screenWidth * 0.9
        
        
        
        // Load the original image
        let image = UIImage(named: "dcleftjpg")
        
        // Calculate the scale factor
        let scaleFactor = image!.size.width / desiredWidth
        
        // Calculate the new size
        let newSize = CGSize(width: image!.size.width / scaleFactor, height: image!.size.height / (scaleFactor * 1.30))
        
        // Create a new image that is scaled
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image!.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let padding2 = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 30)
      //  imageView = UIImageView(image:paddedImage?.withAlignmentRectInsets(padding2))
        
        //******end of add padding
        
        // Display the scaled image in an image view
        let imageView = UIImageView(image:newImage?.withAlignmentRectInsets(padding2))
      //  imageView.contentMode = .scaleAspectFit
        //imageView.center = view.center
        view.addSubview(imageView)
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
           
           // imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20)
            
        ])
        
        //Begin the label
        //let lblTitle = UILabel()
        lblTitle.text = "Technician Assistant Login"
        lblTitle.textColor = UIColor.black
       // lblTitle.font = .systemFont(ofSize: 20)
        lblTitle.font = .systemFont(ofSize: 26, weight: .medium)
        
        view.addSubview(lblTitle)
        
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        lblTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        lblTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 10)
        ])
        //end of lable
        
        //Begin userName row
                
                lblUserName.text = "TD User Name:"
                                                lblUserName.textColor = UIColor.black
                                               // lblTitle.font = .systemFont(ofSize: 20)
                                                lblUserName.font = .systemFont(ofSize: 18, weight: .medium)
                                                
                                                view.addSubview(lblUserName)
                                                
                                                lblUserName.translatesAutoresizingMaskIntoConstraints = false
                                                
                                                NSLayoutConstraint.activate([
                                                    lblUserName.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
                                                lblUserName.topAnchor.constraint(equalTo: lblTitle.bottomAnchor,constant: 45)
                                                ])
                                                
                                                //end of lblHydroTemplblHydroTemp
                                        
                                         // begin tfUserName
                                        
                                        
                                        view.addSubview(tfUserName)
                                        tfUserName.translatesAutoresizingMaskIntoConstraints = false
                                       
                                        tfUserName.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
                                        NSLayoutConstraint.activate([
                                            tfUserName.topAnchor.constraint(equalTo: lblTitle.bottomAnchor,constant: 35),
                                            tfUserName.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
                                            tfUserName.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -5),
                                            tfUserName.heightAnchor.constraint(equalToConstant: 40),
                                            
                                            ])
                                        tfUserName.textColor = UIColor.black
                                        tfUserName.textAlignment = NSTextAlignment.center
                                        tfUserName.layer.cornerRadius = 5
                                        tfUserName.layer.masksToBounds = true
                                    //    tfUserName.keyboardType = .decimalPad //can use decimalPad for period or decimal
                                      
                
        //End UserName row
        
        //Begin UserPWD row
                       
                       lblUserPWD.text = "TD Password:"
                                                       lblUserPWD.textColor = UIColor.black
                                                      // lblTitle.font = .systemFont(ofSize: 20)
                                                       lblUserPWD.font = .systemFont(ofSize: 18, weight: .medium)
                                                       
                                                       view.addSubview(lblUserPWD)
                                                       
                                                       lblUserPWD.translatesAutoresizingMaskIntoConstraints = false
                                                       
                                                       NSLayoutConstraint.activate([
                                                           lblUserPWD.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
                                                       lblUserPWD.topAnchor.constraint(equalTo: lblUserName.bottomAnchor,constant: 45)
                                                       ])
                                                       
                                                       //end of lblHydroTemplblHydroTemp
                                               
                                                // begin tfUserPWD
                                               
                                               
                                               view.addSubview(tfUserPWD)
                                               tfUserPWD.translatesAutoresizingMaskIntoConstraints = false
                                              
                                               tfUserPWD.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
                                               NSLayoutConstraint.activate([
                                                   tfUserPWD.topAnchor.constraint(equalTo: lblUserName.bottomAnchor,constant: 35),
                                                   tfUserPWD.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
                                                   tfUserPWD.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -5),
                                                   tfUserPWD.heightAnchor.constraint(equalToConstant: 40),
                                                   
                                                   ])
                                               tfUserPWD.textColor = UIColor.black
                                               tfUserPWD.textAlignment = NSTextAlignment.center
                                               tfUserPWD.layer.cornerRadius = 5
                                               tfUserPWD.layer.masksToBounds = true
                                           //    tfUserPWD.keyboardType = .decimalPad //can use decimalPad for period or decimal
                                             
                       
               //End UserPWD row
        
        //Begin Send button
            
                view.addSubview(btnLogin)
                
              
               // btnLogin.backgroundColor = .systemGreen
                btnLogin.titleLabel?.textColor = UIColor.black
                //scanButton.titleLabel?.text = "Scan for PPC"
                btnLogin.setTitle("Login", for: .normal)
               
                
                btnLogin.translatesAutoresizingMaskIntoConstraints = false
                
                btnLogin.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
                btnLogin.topAnchor.constraint(equalTo:lblUserPWD.bottomAnchor,constant: 45).isActive = true
                btnLogin.widthAnchor.constraint(equalToConstant: 200).isActive = true
                btnLogin.heightAnchor.constraint(equalToConstant: 50).isActive = true
                btnLogin.addTarget(self,action: #selector(sendItHome),for:.touchUpInside)
                btnLogin.layer.cornerRadius = 5
                btnLogin.layer.masksToBounds = true
                btnLogin.setTitleColor(UIColor.white, for: .normal)
                btnLogin.setTitleColor(UIColor.systemBlue, for: .selected)
                btnLogin.isEnabled = true
                
                let button = UIButton(type: .system)
                if let hs1Color = UIColor(hex: "#198754") {
                    btnLogin.backgroundColor = hs1Color
                }
               
                
                
        //End Send Button
                
        
        
    }
}

extension UIColor {
    convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000ff) / 255
                    a = 1
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

extension Login: UITextFieldDelegate {
 func textFieldShouldReturn(_ textField: UITextField) -> Bool {
 //Check if there is any other text-field in the view whose tag is +1 greater than the current text-field on which the return key was pressed. If yes → then move the cursor to that next text-field. If No → Dismiss the keyboard
 if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
 nextField.becomeFirstResponder()
 } else {
 textField.resignFirstResponder()
 }
 return false
 }
 }


