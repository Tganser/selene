//
//  ViewController.swift
//  TessaApp
//
//  Created by Tessa.Ganser on 9/12/19.
//  Copyright © 2019 Tessa.Ganser. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var Table: UITableView!
    var data:[String] = []
    var selectedRow:Int = -1
    var newRowText:String = ""
    var file:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Cycles"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPeriod))
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = editButtonItem
        let docsDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        file = docsDir[0].appending("periods.txt")
        load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if selectedRow == -1 {
            return
        }
        data[selectedRow] = newRowText
        if newRowText == "" {
            data.remove(at: selectedRow)
        }
        Table.reloadData()
        save()
    }
    
    @objc func addPeriod() {
        //let name:String = "Row \(data.count + 1)"
        if (Table.isEditing) {
            return
        }
        let df = DateFormatter()
        df.dateFormat = "MMM dd, YYY"
        let now = df.string(from: Date())
        let periodDate = "\(now)"
        data.insert(periodDate, at: 0)
        let indexPath:IndexPath = IndexPath(row: 0, section: 0)
        Table.insertRows(at: [indexPath], with: .automatic)
        Table.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        self.performSegue(withIdentifier: "detail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        Table.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        data.remove(at: indexPath.row)
        Table.deleteRows(at: [indexPath], with: .fade)
        save()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailView:DetailViewController = segue.destination as! DetailViewController
        selectedRow = Table.indexPathForSelectedRow!.row
        detailView.masterView = self
        detailView.setText(t: data[selectedRow])
    }
    
    func save() {
        //UserDefaults.standard.set(data, forKey: "periods")
        //UserDefaults.standard.synchronize()
        let newData:NSArray = NSArray(array: data)
        newData.write(toFile: file, atomically: true)
    }
    
    func load() {
        if let loadedData = NSArray(contentsOfFile:file) as? [String]
        {
            data = loadedData
            Table.reloadData()
        }
    }

}

