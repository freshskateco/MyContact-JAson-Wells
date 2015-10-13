//
//  ViewController.swift
//  MyContact
//
//  Created by webstudent on 10/12/15.
//  Copyright © 2015 Chuck Konkol. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    
    //1) Add ManageedCode
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    //2)
    
    var contactdb:NSManagedObject!
    
    
    @IBOutlet weak var fullname: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var btnSave: UIButton!
    
    @IBAction func btnBack(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        if (contactdb != nil)
        {
            fullname.text = contactdb.valueForKey("fullname") as? String
            email.text = contactdb.valueForKey("email") as? String
            phone.text = contactdb.valueForKey("phone") as? String
            btnSave.setTitle("Update", forState: UIControlState.Normal)
        }
        fullname.becomeFirstResponder()
        let tap:UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: "DismissKeyboard")
        
        view.addGestureRecognizer(tap)
        
        }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first as UITouch! {
            DismissKeyboard()
        }
        super.touchesBegan(touches , withEvent:event)
    }
    
    func DismissKeyboard() {
        fullname.endEditing(true)
        email.endEditing(true)
        phone.endEditing(true)
        
    }
    func textFieldShouldReturn (textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true;
        
    }





    @IBAction func btnSave(sender: AnyObject) {
        // add save logic
        if (contactdb != nil)
        {
            contactdb.setValue(fullname.text, forKey: "fullname")
            contactdb.setValue(email.text, forKey: "email")
            contactdb.setValue(phone.text, forKey: "phone")
        }
        else
        {
            let entityDescription = NSEntityDescription.entityForName("Contact",inManagedObjectContext: managedObjectContext)
            let contact = Contact(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
            
            contact.fullname = fullname.text!
            contact.email = email.text!
            contact.phone = phone.text!
        }
        var error: NSError?
        do {
            try managedObjectContext.save()
        } catch let error1 as NSError {
            error=error1
        }
        
        
        if let err = error {
            status.text = err.localizedFailureReason
        } else {
            self.dismissViewControllerAnimated(false, completion: nil) }
    }
      
    }

    
    




