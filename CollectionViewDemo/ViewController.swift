//
//  ViewController.swift
//  CollectionViewDemo
//
//  Created by yanguo sun on 2024/1/2.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        // 创建和配置 titleLabel
        titleLabel = UILabel(frame: contentView.bounds)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.black
        contentView.addSubview(titleLabel)
    }
}


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addButton: UIButton!

    // 假设数据源是一个字符串数组
    var data = [["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"],["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")

        // 设置集合视图的委托和数据源
        collectionView.delegate = self
        collectionView.dataSource = self
        // 注册集合视图单元格
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        // 设置集合视图的布局
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: 100, height: 100)
            flowLayout.minimumLineSpacing = 10  // 设置行间距
            flowLayout.minimumInteritemSpacing = 10  // 设置列间距（可选，根据需要设置）
        }
        // 将按钮与插入数据的方法连接
        addButton.addTarget(self, action: #selector(insertDataAndReload), for: .touchUpInside)
    

    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCollectionViewCell

        // 配置单元格的内容
//        cell.backgroundColor = UIColor.blue
        cell.titleLabel.text = data[indexPath.section][indexPath.row]

        return cell
    }

    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 处理单元格的点击事件
        print("Selected item: \(data[indexPath.item])")
    }
    
    // MARK: Button Action

     @objc func insertDataAndReload() {


         // 刷新集合视图
         collectionView.performBatchUpdates {
             // 在数据源中插入新的数据
             data[0].append("\(data[0].count + 1)")
             data[1].append("\(data[1].count + 1)")

             // 插入新的 cell
//             let indexPath = IndexPath(item: data[0].count - 1, section: 0)
//             collectionView.insertItems(at: [indexPath])
             let sectionsToReload = IndexSet([0, 1])
             collectionView.reloadSections(sectionsToReload)
         }
     }
}


