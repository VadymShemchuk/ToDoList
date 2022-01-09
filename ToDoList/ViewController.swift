//
//  ViewController.swift
//  ToDoList
//
//  Created by Vadym Shemchuk on 09.01.2022.
//

//import UIKit

//class ViewController: UIViewController {

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private var tasks: [String] = []
    private var table: UITableView!
    private var button = UIButton()
    private var textView = UITextView()
    
    // MARK: - Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

    // MARK: - Private

private extension ViewController {
    
    func setup() {
        setupTable()
        setupButton()
        setupTextView()
    }
    
    func setupTable() {
           let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
           let displayWidth: CGFloat = self.view.frame.width
           let displayHeight: CGFloat = self.view.frame.height
           
           table = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
           table.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
   //        table.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
           table.dataSource = self
           table.delegate = self
           self.view.addSubview(table)
       }
    
    func setupButton() {
        let taskButton = UIButton()
                taskButton.frame = CGRect (x: 100, y: 40, width: 100, height: 44)
                taskButton.setTitle("ADD", for: .normal)
                taskButton.setTitleColor(.blue, for: .normal)
                taskButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
                view.addSubview(taskButton)
    }
       
    @objc func addTask() {
        guard let someText = textView.text else { return }
        tasks.insert(someText, at: 0)
        table.reloadData()
    }
    
    func setupTextView() {
        textView.frame = CGRect (x: 100, y: 80, width: 100, height: 44)
        textView.text.self = "Print here"
        textView.textAlignment = NSTextAlignment.justified
        textView.textColor = .black
        textView.backgroundColor = .lightGray
        view.addSubview(textView)
    }
}

   // MARK: - UITableViewDataSource

   extension ViewController: UITableViewDataSource {
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return tasks.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
           cell.textLabel!.text = "\(tasks[indexPath.row])"
           return cell
       }
       
       func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == UITableViewCell.EditingStyle.delete {
               tasks.remove(at: indexPath.row)
               table.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        
             
             
         }
       }

   }

   // MARK: - table touch handling

   extension ViewController: UITableViewDelegate {
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           print("Num: \(indexPath.row)")
           print("Value: \(tasks[indexPath.row])")
           
       }
       
   }


