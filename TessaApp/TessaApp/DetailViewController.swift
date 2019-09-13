//
//  DetailViewController.swift
//  selene
//
//  Created by Tessa.Ganser on 9/12/19.
//  Copyright © 2019 Tessa.Ganser. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var TextView: UITextView!
    var text:String = ""
    var masterView:ViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        TextView.text = text
        TextView.becomeFirstResponder()
    }
    
    func setText(t:String){
        text = t
        if isViewLoaded {
            TextView.text = t
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        masterView.newRowText = TextView.text
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
