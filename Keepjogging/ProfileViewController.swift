//
//  ProfileViewController.swift
//  Keepjogging
//
//  Created by Uyen Thuc Tran on 4/10/22.
//

import UIKit
import Parse
import AlamofireImage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
   
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var textNameLabel: UILabel!
    @IBOutlet weak var textProgessLabel: UILabel!
    
    
    var posts = [PFObject]()
    var user = PFUser.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //fetch profile image
        if user?["profileImage"] != nil {
            let file = (user!["profileImage"] as! PFFileObject)
            
            file.getDataInBackground { (imageData: Data?, error: Error?) in
                if let error = error {
                    print(error.localizedDescription)
                } else if let imageData = imageData {
                    let image = UIImage(data: imageData)
                    self.profileImageView.image = image
                }
            }
        }
       
        profileImageView.layer.cornerRadius = 125
        profileImageView.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var countDays: UILabel!
    override func viewDidAppear(_ animated: Bool) {
        
        let layout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = -5
        
        let width = (view.frame.size.width - (-3*layout.minimumInteritemSpacing))/3
        layout.itemSize = CGSize(width: width, height: width*1.25)
        
        // fetch user name
        let userName = PFUser.current()?.username!
        let userId = PFUser.current()?.objectId
        print(userId)
        textNameLabel.text = userName
        
        // days count
        let post = PFObject(className: "Posts")
        let queryDay = PFQuery(className:"Posts")
        queryDay.whereKey("author", equalTo: post["author"] ?? 0)
        queryDay.countObjectsInBackground { (count: Int32, error: Error?) in
            if let error = error {
                // The request failed
                print(error.localizedDescription)
            } else {
                let cnt = count + 1
                //print(cnt)
                if cnt <= 1{
                    self.countDays.text = "\(cnt) day"
                }else{
                    self.countDays.text =  "\(cnt) days"
                }
            }
        }
        
    
        let query = PFQuery(className: "Posts")
        query.order(byDescending: "createdAt");
        query.whereKey("author", equalTo: PFUser.current()!)
        query.limit = 20
        
        query.findObjectsInBackground{ (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.collectionView?.reloadData()
            }
        }
        //self.collectionView.reloadData()
    }
   
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }else{
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width:250,height:250 )
        let scaledImage = image.af.imageScaled(to: size)
        
        //round profile image
        profileImageView.image = scaledImage
        profileImageView.layer.cornerRadius = 150
        profileImageView.clipsToBounds = true
        //profileImageView.layer.masksToBounds = false
        
        dismiss(animated: true, completion: nil)

        let profileImage = profileImageView.image!.pngData()
        let file = PFFileObject(name: "profile.png", data: profileImage!)
        
        user?["profileImage"] = file
        
        user?.saveInBackground {(success, error) in
            if success{
                print("saved!")
            }else{
                print("error!")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let post = self.posts[indexPath.item]

        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostGridCell", for: indexPath) as! PostGridCell
        /*
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url
        let url = URL(string: urlString!)
        cell.PostView.af.setImage(withURL: url!)
        cell.dayLabel.text = "2"*/
        
        cell.setup(with: post)
        
        return cell
        }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

