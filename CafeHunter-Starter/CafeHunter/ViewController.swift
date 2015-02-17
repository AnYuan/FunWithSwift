/*
* Copyright (c) 2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var loginView: FBLoginView!

  let searchDistance: CLLocationDistance = 1000
    
  private var locationManager: CLLocationManager!
  private var lastLocation: CLLocation?
  private var cafes = [Cafe]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.locationManager = CLLocationManager()
    self.locationManager.delegate = self
    
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    self.checkLocationAuthorizationStatus()
  }
  
  private func checkLocationAuthorizationStatus() {
    if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
        self.mapView.showsUserLocation = true
    } else {
      self.locationManager.requestWhenInUseAuthorization()
    }
  }

  private func centerMapOnLocation(location: CLLocation){
    let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, searchDistance, searchDistance)
    self.mapView.setRegion(coordinateRegion, animated: true)
  }
    
  private func fetchCafesAroundLocation(location: CLLocation) {
      if !FBSession.activeSession().isOpen {
          let alert = UIAlertController(title: "Error", message: "Login first!", preferredStyle: .Alert)
          alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
          self.presentViewController(alert, animated: true, completion: nil)
          return
      }
    
      var urlString = "https://graph.facebook.com/v2.0/search/"
      urlString += "?access_token="
      urlString += "\(FBSession.activeSession().accessTokenData.accessToken)"
      urlString += "&type=place"
      urlString += "&q=cafe"
      urlString += "&center=\(location.coordinate.latitude),"
      urlString += "\(location.coordinate.longitude)"
      urlString += "&distance=\(Int(searchDistance))"
    
      let url = NSURL(string: urlString)!
      println("Requesting from FB with URL: \(url)")
      let request = NSURLRequest(URL: url)
      NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
          (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
        
          if error != nil {
              let alert = UIAlertController(title: "Oops!", message: "An error occured", preferredStyle: .Alert)
              alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
              self.presentViewController(alert, animated: true, completion: nil)
              return
          }
        
          var error: NSError?
          let jsonObject: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &error)
          if let jsonObject = jsonObject as? [String:AnyObject] {
              if error == nil {
                  println("Data returned from FB:\n\(jsonObject)")
                  if let data = JSONValue.fromObject(jsonObject)?["data"]?.array {
                      var cafes: [Cafe] = []
                      for cafeJSON in data {
                          if let cafeJSON = cafeJSON.object {
                            if let cafe = Cafe.fromJSON(cafeJSON) {
                                cafes.append(cafe)
                            }
                          }
                      }
                      self.mapView.removeAnnotations(self.cafes)
                      self.cafes = cafes
                      self.mapView.addAnnotations(cafes)
                  }
              }
          }
      }
    }
}

extension ViewController: CLLocationManagerDelegate {
  
  func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    self.checkLocationAuthorizationStatus()
  }
  
}

extension ViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView!, didFailToLocateUserWithError error: NSError!) {
        println(error)
        let alert = UIAlertController(title: "Error", message: "Failed to obtain location!", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        let newLocation = userLocation.location
        
        let distance = self.lastLocation?.distanceFromLocation(newLocation)
        
        if distance == nil || distance! > searchDistance {
            self.lastLocation = newLocation
            self.centerMapOnLocation(newLocation)
            self.fetchCafesAroundLocation(newLocation)
        }
    }
    

}
