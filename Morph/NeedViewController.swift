//
//  DarenViewController.swift
//  Morph
//
//  Created by JinTian on 6/2/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class NeedViewController: UIViewController {
    
    
    @IBOutlet weak var needtableview: UITableView!
    
    var needs: [NeedModal?] = []
    var needtosend: NeedModal?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.needtableview.dataSource = self
        self.needtableview.delegate = self
        self.needtableview.rowHeight = UITableViewAutomaticDimension
        self.needtableview.estimatedRowHeight = 120
        self.needtableview.tableFooterView = UIView(frame: CGRect.zero)
        
        let need1 = NeedModal(avatar: UIImage(named: "f_6"), needtitle: "找一个人帮我设计一张海报", needname: "韩轩", needdiscription:
            "社团招新需要设计一张海报, 可是我啥也不会, 求大神来帮忙", needlocation: "新校区A座306",needmoney: "38", needtime: "2分钟前", needphone: "15612345231")
        let need2 = NeedModal(avatar: UIImage(named: "f_5"), needtitle: "求帮我买一张回家的火车票", needname: "刘媛", needdiscription:
            "回不了家, 求各位帮帮忙", needlocation: "升华公寓28栋", needmoney: "20", needtime: "4分钟前", needphone: "18874192014")
        let need3 = NeedModal(avatar: UIImage(named: "f_2"), needtitle: "求一个帅哥陪我去看电影, 我请客", needname: "小璐", needdiscription:
            "一定要帅哥! 175以下不考虑, 非诚勿扰, 谢谢!", needlocation: "天马", needmoney: "38", needtime: "20分钟前", needphone: "15612476521")
        self.needs.append(need1)
        self.needs.append(need2)
        self.needs.append(need3)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toneeddetail"{
            let needdetailvc = segue.destination as! NeedDetailViewController
            needdetailvc.fromsend_avatar = self.needtosend?.avatar
            needdetailvc.fromsend_name = self.needtosend?.needname
            needdetailvc.fromsend_needtitle = self.needtosend?.needtitle
            needdetailvc.fromsend_needdiscription = self.needtosend?.needdiscription
            needdetailvc.fromsend_needlocation = self.needtosend?.needlocation
            needdetailvc.fromsend_needtime = self.needtosend?.needtime
            needdetailvc.fromsend_needmoney = self.needtosend?.needmoney
            needdetailvc.fromsend_needphone = self.needtosend?.needphone
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension NeedViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.needs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.needtableview.dequeueReusableCell(withIdentifier: "needcell") as! NeedsTableViewCell
        cell.need = needs[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            //先删除数据源在删除列表, 否则会报错!!!!
            self.needs.remove(at: indexPath.row)
            self.needtableview.deleteRows(at: [indexPath], with: .middle)
            
            self.needtableview.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.needtosend = needs[indexPath.row]
        self.performSegue(withIdentifier: "toneeddetail", sender: needtosend)
        self.needtableview.deselectRow(at: indexPath, animated: true)
    }
}
