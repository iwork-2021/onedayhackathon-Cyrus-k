//
//  PhotoViewController.swift
//  albumapp
//
//  Created by nju on 2021/12/21.
//

import UIKit

import CoreMedia
import CoreML
import Vision

class PhotoViewController: UIViewController {

    @IBOutlet weak var photolibrarybutton: UIButton!
    @IBOutlet weak var camerabutton: UIButton!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var resultView: UIVisualEffectView!
    @IBOutlet weak var resultLabel: UILabel!
    var resultstring:String = ""
    
    lazy var classificationRequest: VNCoreMLRequest = {
            do{
                let classifier = try snacks(configuration: MLModelConfiguration())
                
                let model = try VNCoreMLModel(for: classifier.model)
                let request = VNCoreMLRequest(model: model, completionHandler: {
                    [weak self] request,error in
                    self?.processObservations(for: request, error: error)
                })
                request.imageCropAndScaleOption = VNImageCropAndScaleOption.centerCrop
                return request
                
                
            } catch {
                fatalError("Failed to create request")
            }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        camerabutton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        self.resultView.alpha = 0
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func takepicture(_ sender: Any) {
        presentPhotoPicker(sourceType: .camera)
    }
    
    @IBAction func choosephotolibrary(_ sender: Any) {
        presentPhotoPicker(sourceType: .photoLibrary)
    }
    
    func hideResultsView() {
      UIView.animate(withDuration: 0.3) {
        self.resultView.alpha = 0
      }
    }
    
    func presentPhotoPicker(sourceType: UIImagePickerController.SourceType) {
      let picker = UIImagePickerController()
      picker.delegate = self
      picker.sourceType = sourceType
      present(picker, animated: true)
      hideResultsView()
    }
    
    func classify(image: UIImage) {
        DispatchQueue.main.async {
            let handler = VNImageRequestHandler(cgImage: image.cgImage!)
            do {
                try handler.perform([self.classificationRequest])
                
            } catch {
                print("Failed to perform classification: \(error)")
            }
            //self.semphore.signal()
        }
    }

}

extension PhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    picker.dismiss(animated: true)

    let image = info[.originalImage] as? UIImage
      if image != nil{
          imageview.image = image
          print("start classify")
          classify(image: image!)
          print("classify finished")
          DispatchQueue.main.async {
              if self.resultstring == "Nothing found" || self.resultstring == "Error" || self.resultstring == "???" || self.resultstring == ""{
                  print("nothing")
              }
              else{
                  for i in 0..<items.count{
                      if items[i].title == self.resultstring{
                          items[i].photoimage.append(image!)
                          print(items[i].photoimage[0])
                          print("good",i)
                          break
                      }
                  }
              }
          }
      }
      
  }
}

extension PhotoViewController {
    func processObservations(for request: VNRequest, error: Error?) {
        if let results = request.results as? [VNClassificationObservation] {
            if results.isEmpty {
                self.resultstring = "Nothing found"
                print(1)
            } else {
                let result = results[0].identifier
                let confidence = results[0].confidence
                let stringtemp = String(format: "%.1f%%", confidence * 100)
                //self.showResultsView()
                //self.confidenceLabel.text = String(format: "%.1f%%", confidence * 100)
                self.resultView.alpha = 0.5
                if confidence > 0.7{
                    self.resultstring = result
                }
                else{
                    self.resultstring = "other"
                }
                self.resultLabel.text = stringtemp + result
                print(result)
            }
        } else if let error = error {
            self.resultstring = "Error"
        } else {
            self.resultstring = "???"
        }
    }
}
