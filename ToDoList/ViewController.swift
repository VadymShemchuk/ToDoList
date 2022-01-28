//
//  ViewController.swift
//  ToDoList
//
//  Created by Vadym Shemchuk on 09.01.2022.
//

//import UIKit

//class ViewController: UIViewController {

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private var table: UITableView!
    private var button = UIButton()
    private var textView = UITextView()
    private var mainView = UIView()
    var tasks: [Ticket] = []
    var userTicket = Ticket()
    let defaults = UserDefaults.standard
    
    @objc func didSelectRow(index:Int, ticketTitle: String, ticketDescription: String?) {
        let secondController = secondViewController()
        secondController.receptionData = tasks[index].self
        secondController.returnedText = {[weak self] in
            self?.tasks[index] = $0
            self?.table.reloadData()
        }
        navigationController?.pushViewController(secondController, animated: true)
    }
    
    
    // MARK: - Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "To Do List"
        setup()
        autoResizeCell()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //if let savedTasks = defaults.stringArray(forKey: "Saved Tasks"){
        //    tasks = savedTasks
        //}
        table.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    
}

private extension ViewController {
    
    
    private func autoResizeCell(){
        table.estimatedRowHeight = 40
        table.rowHeight = UITableView.automaticDimension
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
        //let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        //let displayWidth: CGFloat = self.view.frame.width
        //let displayHeight: CGFloat = self.view.frame.height
        //table = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        table = UITableView()
        table.frame = self.view.frame
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: "MyCell")
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = UIColor.white
        table.separatorColor = UIColor.gray
        table.layer.cornerRadius = 5
        self.view.addSubview(table)
    }
    
    func setupButton() {
        button.setTitle("+", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 20.0
        button.clipsToBounds = true
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints{ (make) in
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
            make.size.equalTo(44)
        }
    }
    
    @objc func addTask() {
        guard let someText = textView.text else { return }
        let ticket = Ticket.init(title: someText, description: "")
        tasks.insert(ticket, at: 0)
        table.reloadData()
    }
    
    func setupTextView() {
        textView.frame = CGRect (x: 100, y: 80, width: 100, height: 44)
        textView.text.self = ""
        textView.textAlignment = NSTextAlignment.justified
        textView.textColor = .black
        textView.backgroundColor = .lightGray
        view.addSubview(textView)
        textView.snp.makeConstraints{
            $0.left.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
            $0.right.equalTo(button.snp.left).offset(-20)
            $0.height.equalTo(44)
            
        }
    }
}


// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as?
                CustomTableViewCell else {return UITableViewCell()}
//        cell.titleLbl.text = tasks[indexPath.row].title
//        cell.descriptionLbl.text = tasks[indexPath.row].description
        let task = tasks[indexPath.row]
        cell.textLabel!.text = task.title
        cell.descrLBL.text = tasks[indexPath.row].description
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 118
//    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            tasks.remove(at: indexPath.row)
            table.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            //defaults.set(tasks, forKey: "Saved Tasks")
        }
    }
}

// MARK: - table touch handling

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskString = "\(tasks[indexPath.row])"
        didSelectRow(index: indexPath.row, ticketTitle:taskString, ticketDescription: "")
    }
}
