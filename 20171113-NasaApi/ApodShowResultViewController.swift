//
//  ApodShowResultViewController.swift
//  20171113-NasaApi
//
//  Created by Iyuka on 2017/11/14.
//  Copyright © 2017年 Iyuka. All rights reserved.
//

import UIKit

class ApodShowResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var selectedDate: String = String()
    var jsonData: Dictionary = [String: Any]()
    var astronomyImageData: UIImage = UIImage()
    
    @IBOutlet weak var astronomyImageView: UIImageView!
    @IBOutlet weak var explanationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initUI()
        guard let url = createJsonUrl() else {
            return
        }
        print("before fetch")
        fetchJson(urlString: url)
        print("after fetch")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initUI() -> Void {
        // TableView初期設定
        explanationTableView.dataSource = self
        explanationTableView.delegate = self
        explanationTableView.register(UITableViewCell.self, forCellReuseIdentifier: "explanationTableViewCell")
        explanationTableView.estimatedRowHeight = 20
        explanationTableView.rowHeight = UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = explanationTableView.dequeueReusableCell(withIdentifier: "explanationTableViewCell", for: indexPath as IndexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "A"
        return cell
    }
    
    func createJsonUrl() -> String? {
        var url:String = "https://api.nasa.gov/planetary/apod"
        url += "?date=" + self.selectedDate
        guard let apiKey = readApiKey(keyName: "nasaapi") else {
            print("Error:createJsonUrl readApiKey not found")
            return nil
        }
        url += "&api_key=" + apiKey
        return url
    }
    
    func fetchJson(urlString: String) -> Void {
        print("start fetchJson")
        let url = URL(string: urlString)
/*
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        let fetchTask = session.downloadTask(with: url!)
        print("before resume")
        fetchTask.resume()
        print("after resume")
*/
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { data, response, error in
            if let data = data, let response = response {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                    print("JSONSerialization")
                    for(key, value) in json {
                        self.jsonData[key] = value
                    }
                    print(self.jsonData)

                    self.fetchImage(urlString: (self.jsonData["url"] as! String))
                } catch {
                    print("Error: Serialize")
                }
            } else {
                print(error ?? "Error")
            }
        })
        task.resume()
    }
    
    func fetchImage(urlString: String) -> Void {
        print("start fetchImage")
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { data, response, error in
            if let data = data, let response = response {
                print("finish fetchImage")
                self.astronomyImageData = UIImage(data:data)!
            } else {
                print(error ?? "Error fetchImage")
            }
            DispatchQueue.main.async(execute: {() -> Void in
                self.showAstronomyImageView()
            })
        })
        task.resume()
    }
    
    func showAstronomyImageView() -> Void {
        self.astronomyImageView.image = self.astronomyImageData
    }
    
    

    /*
     func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
     print("urlSession")
     
     }
     func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
     print("didSendBodyData")
     }
     func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
     print("didCompleteWithError \(error)")
     }
     */
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
