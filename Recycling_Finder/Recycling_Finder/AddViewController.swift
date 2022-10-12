//
//  AddViewController.swift
//  Recycling_Finder
//
//  Created by Muharrem Köroğlu on 10.10.2022.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class AddViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var saveButton: UIButton!
    
    
    var locationManager = CLLocationManager()
    
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    
    var selectedType = ""
    var selectedId : UUID?
    
    var annotationTitle = ""
    var annotationLatitude = Double()
    var annotationLongitude = Double()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(annotation(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 2
        mapView.addGestureRecognizer(gestureRecognizer)
        
        imageView.isUserInteractionEnabled = true
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pickedImage))
        imageView.addGestureRecognizer(imageGestureRecognizer)
        
        
        if selectedType != "" {
            
            saveButton.isHidden = true
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DataSource")
            fetchRequest.returnsObjectsAsFaults = false
            let idString = selectedId?.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
            
            do{
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if let type = result.value(forKey: "type") as? String {
                            typeTextField.text = type
                            annotationTitle = type
                            if let image = result.value(forKey: "image") as? Data {
                                imageView.image = UIImage(data: image)
                                if let latitude = result.value(forKey: "latitude") as? Double {
                                    annotationLatitude = latitude
                                    if let longitude = result.value(forKey: "longitude") as? Double {
                                        annotationLongitude = longitude
                                        
                                        
                                        let annotation = MKPointAnnotation()
                                        annotation.title = annotationTitle
                                        annotation.subtitle = "Tap the button to go"
                                        let coordinate = CLLocationCoordinate2D(latitude: annotationLatitude, longitude: annotationLongitude)
                                        annotation.coordinate = coordinate
                                        mapView.addAnnotation(annotation)
                                        locationManager.stopUpdatingLocation()
                                        
                                        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                                        let region = MKCoordinateRegion(center: coordinate, span: span)
                                        mapView.setRegion(region, animated: true)
  
                                    }
                                }
                            }
                        }
                    }
                }
            }catch{
                print("Error!")
            }
        }else{
            saveButton.isHidden = false
            saveButton.isEnabled = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if selectedType == ""{
            let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
            
        }
    }
    
    @objc func annotation (gestureRecognizer : UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == .began {
            
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
            let touchedPointCoordinate = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            
            chosenLatitude = touchedPointCoordinate.latitude
            chosenLongitude = touchedPointCoordinate.longitude
                
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedPointCoordinate
            annotation.title = typeTextField.text
            
            self.mapView.addAnnotation(annotation)
            saveButton.isEnabled = true
           
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {//This func customize the annotations
        if annotation is MKUserLocation {
            return nil
        }
        let reuseId = "newAnnotation"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKMarkerAnnotationView
        
        if pinView == nil {
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            pinView?.tintColor = UIColor.blue
            
            let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        }else{
            pinView?.annotation = annotation
        }

        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {//We can open the navigation with this func
        
        if selectedType != "" {
            
            let requestLocation = CLLocation(latitude: annotationLatitude, longitude: annotationLongitude)
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placeMarks, error) in
                
                if let placeMark = placeMarks {
                    if placeMark.count > 0 {
                        let newPlaceMark = MKPlacemark(placemark: placeMark[0])
                        let item = MKMapItem(placemark: newPlaceMark)
                        item.name = self.annotationTitle
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                        item.openInMaps(launchOptions: launchOptions)
                    }
                }
            }
        }
    }

    
    @objc func pickedImage () {
        
        let pickedImage = UIImagePickerController()
        pickedImage.delegate = self
        pickedImage.sourceType = .photoLibrary
        pickedImage.allowsEditing = true
        present(pickedImage, animated: true)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    

    
    @IBAction func saveButton(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newObject = NSEntityDescription.insertNewObject(forEntityName: "DataSource", into: context)
        
        newObject.setValue(typeTextField.text, forKey: "type")
        newObject.setValue(chosenLatitude, forKey: "latitude")
        newObject.setValue(chosenLongitude, forKey: "longitude")
        newObject.setValue(UUID(), forKey: "id")
        
        let imageData = imageView.image?.jpegData(compressionQuality: 0.5)
        newObject.setValue(imageData, forKey: "image")
        
        do{
            try context.save()
            let alert = UIAlertController(title: "Successful", message: "Recycle bin successfully saved. Now you can check the recycle bin list ", preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { UIAlertAction in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(action)
            present(alert, animated: true)
        }catch{
            print("Error!")
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newData"), object: nil)
    
    }

}
