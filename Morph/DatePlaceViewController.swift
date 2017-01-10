//
//  DatePlaceTableViewController.swift
//  Morph
//
//  Created by JinTian on 7/11/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit
import MapKit

class DatePlaceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

   
   
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet var placetableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置searchbar
        self.searchbar.delegate = self
        self.placetableview.dataSource = self
        self.placetableview.delegate = self
        
        mapView.showsUserLocation = true
        mapView.showsBuildings = true
        mapView.showsPointsOfInterest = true
        _ = locationManager
        //mapView.showsScale = true
        mapView.mapType = .standard
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        //创建一个MKCoordinateSpan对象，设置地图的范围（越小越精确）
        let latDelta = 0.05
        let longDelta = 0.05
        let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        //使用自定义位置
        let center:CLLocation = CLLocation(latitude: 32.029171, longitude: 118.788231)
        let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center.coordinate, span: currentLocationSpan)
        //设置显示区域
        self.mapView.setRegion(currentRegion, animated: true)
        //创建一个大头针对象
        let objectAnnotation = MKPointAnnotation()
        //设置大头针的显示位置
        objectAnnotation.coordinate = CLLocation(latitude: 32.029171, longitude: 118.788231).coordinate
        //设置点击大头针之后显示的标题
        objectAnnotation.title = "南京夫子庙"
        //设置点击大头针之后显示的描述
        objectAnnotation.subtitle = "南京市秦淮区秦淮河北岸中华路"
        //添加大头针
        self.mapView.addAnnotation(objectAnnotation)
        
        
        //根据经纬度获取真实地理位置名称
        let geocoder = CLGeocoder()
        let currentLocation = CLLocation(latitude: 32.029171, longitude: 118.788231)
        
        
    }
    
    fileprivate lazy var locationManager : CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        return locationManager
    }()
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //重写tableview三个方法
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.placetableview.dequeueReusableCell(withIdentifier: "placecell")! as UITableViewCell
        cell.textLabel?.text = "哇哈哈"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint(indexPath.row)
        let cell = placetableview.cellForRow(at: indexPath)! as UITableViewCell
        
        var arry = placetableview.visibleCells
        for i in 0..<arry.count{
            let cells = arry[i] as UITableViewCell!
            cells?.accessoryType = .none
        }
        cell.accessoryType = .checkmark
        cell.setSelected(false, animated: true)
    }
  
}
extension DatePlaceViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchbar.resignFirstResponder()
    }
}


extension DatePlaceViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        userLocation.title = "你的位置"
        userLocation.subtitle = "找个地方约会吧"
        
    }
}
