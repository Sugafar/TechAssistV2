//
//  Menu.swift
//  TechAssistV2
//
//  Created by Raf on 3/4/23.
//

import UIKit

class Menu:UIViewController{
    
    let lblTitle = UILabel()
    var dbm = DBManagerV2(mydb: "")
   // var aDBM = DBManager(mydb: "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor.lightGray
        self.navigationController?.navigationBar.tintColor = UIColor.blue
       
        
        
        setupUI()
        getUser()
    }
    
    func getUser(){
        
        var myUser = DCUser()
        myUser = dbm.readRecord()
        lblTitle.text = myUser.displayName
        
        
        
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
        lblTitle.font = .systemFont(ofSize: 26, weight: .medium)
        
        view.addSubview(lblTitle)
        
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        lblTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        lblTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 10)
        ])
        //end of lable
        
        
        
    }
    
    
}

