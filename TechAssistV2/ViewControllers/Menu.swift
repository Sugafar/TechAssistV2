//
//  Menu.swift
//  TechAssistV2
//
//  Created by Raf on 3/4/23.
//

import UIKit

class Menu:UIViewController{
    
    let lblTitle = UILabel()
    let btnTime = UIButton()
    let btnProving = UIButton()
    let btnAPI = UIButton()
    var dbm = DBManagerV2(mydb: "")
   // var aDBM = DBManager(mydb: "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor.lightGray
        self.navigationController?.navigationBar.tintColor = UIColor.blue
        navigationItem.hidesBackButton = true
        
        
        setupUI()
        getUser()
    }
    
    func getUser(){
        
        var myUser = DCUser()
        myUser = dbm.readRecord()
        lblTitle.text = "Logged in as " + myUser.displayName
    }
    
    @objc func openTimeEntry(){
        
        let nextScreen = TimeEntry()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.navigationController?.pushViewController(nextScreen, animated: true)
        })
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
        lblTitle.text = "Menu"
        lblTitle.textColor = UIColor.black
       // lblTitle.font = .systemFont(ofSize: 20)
        lblTitle.font = .systemFont(ofSize: 18, weight: .medium)
        
        view.addSubview(lblTitle)
        
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        lblTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        lblTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 10)
        ])
        //end of lable
        
        //Begin Time Btn
        
        
        view.addSubview(btnTime)
        
        btnTime.configuration = .tinted()
        btnTime.configuration?.image = UIImage(systemName: "clock.fill")
        btnTime.configuration?.imagePadding = 6
        btnTime.configuration?.imagePlacement = .leading
        
        btnTime.titleLabel?.textColor = UIColor.black
        btnTime.setTitle("Enter Time", for: .normal)
        
        
        btnTime.translatesAutoresizingMaskIntoConstraints = false
        btnTime.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        btnTime.topAnchor.constraint(equalTo:lblTitle.bottomAnchor,constant: 45).isActive = true
        btnTime.widthAnchor.constraint(equalToConstant: 200).isActive = true
        btnTime.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnTime.addTarget(self,action: #selector(openTimeEntry),for:.touchUpInside)
        btnTime.layer.cornerRadius = 5
        btnTime.layer.masksToBounds = true
        // btnTime.setTitleColor(UIColor.white, for: .normal)
        btnTime.setTitleColor(UIColor.systemBlue, for: .selected)
        btnTime.isEnabled = true
        
        _ = UIButton(type: .system)
        if let hs1Color = UIColor(hex: "#198754") {
            btnTime.configuration?.baseBackgroundColor = hs1Color
            btnTime.configuration?.baseForegroundColor = hs1Color
        }
        
        //End time Button
        
        //Begin Proving button
             
                   
                       view.addSubview(btnProving)
                       
                     
                      // btnProving.backgroundColor = .systemGreen
                       btnProving.titleLabel?.textColor = UIColor.black
                       //scanButton.titleLabel?.text = "Scan for PPC"
                       btnProving.setTitle("Proving Example", for: .normal)
                      
                       
                       btnProving.translatesAutoresizingMaskIntoConstraints = false
                       
                       btnProving.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
                       btnProving.topAnchor.constraint(equalTo:btnTime.bottomAnchor,constant: 45).isActive = true
                       btnProving.widthAnchor.constraint(equalToConstant: 200).isActive = true
                       btnProving.heightAnchor.constraint(equalToConstant: 50).isActive = true
                      // btnProving.addTarget(self,action: #selector(modRecord),for:.touchUpInside)
                       btnProving.layer.cornerRadius = 5
                       btnProving.layer.masksToBounds = true
                       btnProving.setTitleColor(UIColor.white, for: .normal)
                       btnProving.setTitleColor(UIColor.systemBlue, for: .selected)
                       btnProving.isEnabled = true
                       
                       _ = UIButton(type: .system)
                       if let hs1Color = UIColor(hex: "#198754") {
                           btnProving.backgroundColor = hs1Color
                       }
                      
        //End proving Button
        
        //Begin API button
            
                view.addSubview(btnAPI)
                
              
               // btnAPI.backgroundColor = .systemGreen
                btnAPI.titleLabel?.textColor = UIColor.black
                //scanButton.titleLabel?.text = "Scan for PPC"
                btnAPI.setTitle("Gravity Helper", for: .normal)
               
                
                btnAPI.translatesAutoresizingMaskIntoConstraints = false
                
                btnAPI.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
                btnAPI.topAnchor.constraint(equalTo:btnProving.bottomAnchor,constant: 45).isActive = true
                btnAPI.widthAnchor.constraint(equalToConstant: 200).isActive = true
                btnAPI.heightAnchor.constraint(equalToConstant: 50).isActive = true
              //  btnAPI.addTarget(self,action: #selector(readRecord),for:.touchUpInside)
                btnAPI.layer.cornerRadius = 5
                btnAPI.layer.masksToBounds = true
                btnAPI.setTitleColor(UIColor.white, for: .normal)
                btnAPI.setTitleColor(UIColor.systemBlue, for: .selected)
                btnAPI.isEnabled = true
                
                _ = UIButton(type: .system)
                if let hs1Color = UIColor(hex: "#198754") {
                    btnAPI.backgroundColor = hs1Color
                }
               
                
                
        //End read record Button
        
    }
    
    
}

