//
//  ViewController.swift
//  MMTransition
//
//  Created by millmanyang@gmail.com on 03/27/2017.
//  Copyright (c) 2017 millmanyang@gmail.com. All rights reserved.
//

import UIKit
import MMTransition

let headerArr = ["Dialog","Menu","Navigation Push"]
let titleArr = [["DialogType : PreferSize Animate: Scale(0 to 1)" ,
                 "DialogType : CustomSize Animate: Alpha(0 to 1)" ,
                 "Animate - Left",
                 "Animate - Right",
                 "Animate - Top",
                 "Animate - Bottom"],
                 ["Menu height 200 - Bottom",
                  "Menu screen height rate 0.5 - Bottom",
                  "Menu width 200 - Left",
                  "Menu screen width 0.5 - Left",
                  "Menu full screen - Left",
                  "Menu width 200 - Right",
                  "Menu screen width 0.5 - Right",
                  "Menu full screen - Right"],
                  ["Alpha"]]

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            switch indexPath.section {
            case 0:
                self.dialog(row: indexPath.row)
            case 1:
                self.menu(row: indexPath.row)
            case 2:
                self.push(row: indexPath.row)
            default:
                break
            }
        }
    }
}
// Push
extension ViewController {
    fileprivate func push(row:Int) {
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let second = story.instantiateViewController(withIdentifier: "Second")
        
        self.navigationController?.mmT.push.alpha(setting: { (config) in
            
        })
        self.navigationController?.pushViewController(second, animated: true)
    }
}
// Menu
extension ViewController {
    fileprivate func menu(row:Int) {

        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let second = story.instantiateViewController(withIdentifier: "Second")
        
        second.mmT.present.menu { (config) in
            config.isDraggable = true
            switch row {
            case 0:
                config.presentingScale = 1.0
                config.menuType = .bottomHeight(h: 200)
            case 1:
                config.presentingScale = 1.0
                config.menuType = .bottomHeightFromViewRate(rate: 0.5)
            case 2:
                config.presentingScale = 1.0
                config.menuType = .leftWidth(w: 300)
            case 3:
                config.presentingScale = 1.0
                config.menuType = .leftWidthFromViewRate(rate: 0.5)
            case 4:
                config.presentingScale = 1.0
                config.menuType = .leftFullScreen
            case 5:
                config.presentingScale = 1.0
                config.menuType = .rightWidth(w: 300)
            case 6:
                config.presentingScale = 1.0
                config.menuType = .rightWidthFromViewRate(rate: 0.5)
            case 7:
                config.presentingScale = 0.9
                config.menuType = .rightFullScreen
            default:
                break
            }
        }
        self.present(second, animated: true, completion: nil)
    }
}

// Dialog
extension ViewController  {
    
    fileprivate func dialog(row:Int) {
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let second = story.instantiateViewController(withIdentifier: "Second")
        
        second.mmT.present.dialog { (config) in
            switch row {
            case 0:
                self.dialogPreferSize()
            case 1:
                self.dialogSize()
            case 2:
                self.dialog(direction: .left)
            case 3:
                self.dialog(direction: .right)
            case 4:
                self.dialog(direction: .top)
            case 5:
                self.dialog(direction: .bottom)
            default:
                break
            }
        }
        self.present(second, animated: true, completion: nil)
    }
    
    fileprivate func dialogPreferSize() {
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let second = story.instantiateViewController(withIdentifier: "DialogCoder")
        self.present(second, animated: true, completion: nil)
    }
    
    fileprivate func dialogSize() {
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let second = story.instantiateViewController(withIdentifier: "Second")
        
        second.mmT.present.dialog { (config) in
            config.dialogType = .preferSize
            config.animateType = .alpha(from: 0.0, to: 1.0)
        }
        self.present(second, animated: true, completion: nil)
    }
    
    fileprivate func dialog(direction:DirectionType) {
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let second = story.instantiateViewController(withIdentifier: "Second")
        
        second.mmT.present.dialog { (config) in
            config.presentingScale = 0.95
            config.dialogType = .preferSize
            config.animateType = .direction(type: direction)
        }
        
        self.present(second, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath)
        if let label = cell.viewWithTag(100) as? UILabel {
            label.text = titleArr[indexPath.section][indexPath.row]
        }
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerArr.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerArr[section]
    }
}
