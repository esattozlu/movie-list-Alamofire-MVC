//
//  ViewController.swift
//  MoviesList
//
//  Created by Hasan Esat Tozlu on 27.09.2022.
//

import UIKit
import Alamofire

class CategoryListVC: UIViewController {
    
    @IBOutlet weak var categoryListTableView: UITableView!
    var categoryList = [Category]()
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryListTableView.delegate = self
        categoryListTableView.dataSource = self
        
        getCategories()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let index = sender as? Int {
            let destinationVC = segue.destination as! MoviesVC
            destinationVC.selectedCategory = categoryList[index]
        }
    }
    
    func getCategories() {
        AF.request("http://kasimadalan.pe.hu/filmler/tum_kategoriler.php", method: .get).response { response in
            if let data = response.data {
                
                do {
                    let categoryResponse = try JSONDecoder().decode(CategoryResponse.self, from: data)
                    if let categories = categoryResponse.kategoriler {
                        self.categoryList = categories
                    }
                    DispatchQueue.main.async {
                        self.categoryListTableView.reloadData()
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
            }
        }
    }

}


extension CategoryListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedCategory = categoryList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesCell", for: indexPath) as! CategoriesCell
        cell.categoryLabel.text = selectedCategory.kategori_ad
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toMovies", sender: indexPath.row)
    }
    
    
}
