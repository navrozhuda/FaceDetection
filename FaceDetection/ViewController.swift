//
//  ViewController.swift
//  FaceDetection
//
//  Created by Navroz Huda on 25/09/20.
//

import UIKit
import Vision
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        guard let image = UIImage(named:"obama") else {return}
       
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        let scaleHeight = view.frame.size.width / image.size.width * image.size.height
        imageView.frame = CGRect(x:0, y: 100, width: self.view.frame.size.width, height: scaleHeight)
        imageView.backgroundColor = .blue
        self.view.addSubview(imageView)
        
        let request = VNDetectFaceLandmarksRequest { (req, error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
          
            req.results?.forEach({ (res) in
              
                if let faceObeservaton = res as? VNFaceObservation{
                  //  print(faceObeservaton.boundingBox)
                    
                    DispatchQueue.main.async {
                        let faceBox = UIView()
                        faceBox.backgroundColor = .red
                        faceBox.alpha = 0.5
                        let x = self.view.frame.width * faceObeservaton.boundingBox.origin.x
                        let height = scaleHeight * faceObeservaton.boundingBox.size.height
                        let y = (scaleHeight * (1 - faceObeservaton.boundingBox.origin.y) - height) + imageView.frame.origin.y
                        let width = self.view.frame.size.width * faceObeservaton.boundingBox.size.width
                        let frame = CGRect(x:x, y:y , width:width , height:height )
                        faceBox.frame = frame
                        print(frame)
                        self.view.addSubview(faceBox)
                    }
                   
                }
            })
        }
        guard let cgImage = image.cgImage else {
            return
        }
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        try? handler.perform([request])
        // Do any additional setup after loading the view.
    }


}

