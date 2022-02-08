//
//  ViewController.swift
//  ToDoList
//
//  Created by Vadym Shemchuk on 09.01.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    private var table: UITableView!
    private var button = UIButton()
    private var textView = UITextField()
    private var mainView = UIView()
    var tasks: [Ticket] = []
    var userTicket = Ticket()
    let defaults = UserDefaults.standard
    var titleFromPopUp: String?
    
    @objc func didSelectRow(index:Int, ticketTitle: String, ticketDescription: String?, ticketDate: Date?) {
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
        setupTable()
        setupButton()
        setupTextView()
        //autoResizeCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //if let savedTasks = defaults.stringArray(forKey: "Saved Tasks"){
        //    tasks = savedTasks
        //}
        table.reloadData()
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//    }
    
    
}

private extension ViewController {
    
    
//    private func autoResizeCell(){
//        table.rowHeight = UITableView.automaticDimension
//    } delete
}

// MARK: - Private

private extension ViewController {
    
    func setupTable() {
        table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: "MyCell")
        table.estimatedRowHeight = UITableView.automaticDimension
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .systemGray5
        table.tableFooterView = UIView()
        table.separatorColor = UIColor.clear
        self.view.addSubview(table)
        table.snp.makeConstraints {
            $0.right.left.top.bottom.equalToSuperview()
        }
    }
    
    func setupButton() {
        
        button.setTitle("⊕ New Task", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints{
            $0.left.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(40)
        }
    }
    
    @objc func addTask() {
        let popUp = PopUpWindow.init(returnedPopUpText: { [self] in
            let userTitle = $0
            let ticket = Ticket.init(title: userTitle, description: nil, date: nil)
            self.tasks.insert(ticket, at: 0)
            self.table.reloadData()
    })
        self.present(popUp, animated: true, completion: nil)
    }
        
  
        
//        if let someText = textView.text, !someText.isEmpty {
//            title = someText }
//        else {
//            title = "New task"
//        }
//        let ticket = Ticket.init(title: title, description: nil, date: nil)
//        tasks.insert(ticket, at: 0)
//        table.reloadData()
    
    func setupTextView() {
        textView.frame = CGRect (x: 100, y: 80, width: 100, height: 44)
        textView.placeholder = "Print title"
        textView.textAlignment = NSTextAlignment.justified
        textView.textColor = .black
        textView.backgroundColor = .lightGray
        view.addSubview(textView)
        textView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(400)
            $0.left.right.equalToSuperview().inset(20)
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
        cell.titleLBL.text = tasks[indexPath.row].title
        cell.descrLBL.text = tasks[indexPath.row].description
        cell.dateLBL.text = tasks[indexPath.row].date?.formatted(date: .abbreviated, time: .shortened)
        return cell
    }
    
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
        didSelectRow(index: indexPath.row, ticketTitle:taskString, ticketDescription: "", ticketDate: nil)
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .overCurrentContext
    }
}

