//
//  BookViewController.swift
//  FunZone
//
//  Created by Philip Janzel Paradeza on 2022-06-01.
//

import UIKit
import PDFKit

class BookViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var bookList = [""]
    @IBOutlet weak var bookViewHeader: UILabel!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BookCollectionViewCell
        var pdfPath = Bundle.main.url(forResource: bookList[indexPath.row], withExtension: "pdf")
        cell.bookLabel.text = bookList[indexPath.row]
        cell.bookImage.image = pdfThumbnail(url: pdfPath!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pdfStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let pdfScreenVC = pdfStoryboard.instantiateViewController(withIdentifier: "PDFScreen") as! PDFScreenViewController
        pdfScreenVC.pdfName = bookList[indexPath.row]
        self.present(pdfScreenVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookViewHeader.text = LoginViewController.theUser! + " never reads anyway"
        bookList = getBooks("/Users/philipjanzelparadeza/Desktop/FunZone/FunZone/Books")
        
    }
    
    func pdfThumbnail(url: URL, width: CGFloat = 240) -> UIImage? {
      guard let data = try? Data(contentsOf: url),
            let page = PDFDocument(data: data)?.page(at: 0) else {
        return nil
      }

        let pageSize = page.bounds(for: .mediaBox)
      let pdfScale = width / pageSize.width

      // Apply if you're displaying the thumbnail on screen
      let scale = UIScreen.main.scale * pdfScale
      let screenSize = CGSize(width: pageSize.width * scale,
                              height: pageSize.height * scale)

        return page.thumbnail(of: screenSize, for: .mediaBox)
    }
    
    func getBooks(_ folderPath : String) -> [String]{
        let enumerator = FileManager.default.enumerator(atPath: folderPath)
        let filePaths = enumerator?.allObjects as! [String]
        var txtFilePaths = filePaths.filter{$0.contains(".pdf")}
        var i=0
        while(i < txtFilePaths.count)
        {
            txtFilePaths[i] = (txtFilePaths[i] as NSString).deletingPathExtension
            print(txtFilePaths[i])
            i += 1
        }
        return txtFilePaths
    }
    
    

}
