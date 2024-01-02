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
        contentView.backgroundColor = UIColor.lightGray
    }
}


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var animationSwitch: UISwitch!
    
    // 假设数据源是一个字符串数组
    var data = [["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"],
                ["B 1", "B 2", "B 3"]]
    
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
            flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        }
        // 将按钮与插入数据的方法连接
        addButton.addTarget(self, action: #selector(insertDataAndReload), for: .touchUpInside)
        // 添加一个 UISwitch，用于切换动画效果
        animationSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        animationSwitch.isOn = true
        
        
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
    
    // MARK: Switch Value Changed
    
    @objc func switchValueChanged() {
        // Switch 状态改变时
        print("Switch value changed: \(animationSwitch.isOn)")
        titleLabel.text = animationSwitch.isOn ? "Insert" : "reloadSections"
    }
    
    
    // MARK: Button Action
    
    @objc func insertDataAndReload() {
        if animationSwitch.isOn {
            insertItems()
        } else {
            reloadSections()
        }
    }
    
    func reloadSections() {
        // reloadSections为了去掉闪一下动画，不太精准，插入的数据没有动画了，交互不太友好
        UIView.animate(withDuration: 0.0) {
            // 刷新集合视图
            self.collectionView.performBatchUpdates {
                // 在数据源中插入新的数据
                self.data[0].append("\(self.data[0].count + 1)")
                self.data[1].append("\(self.data[1].count + 1)")
                
                let sectionsToReload = IndexSet([0, 1])
                self.collectionView.reloadSections(sectionsToReload)
            }
        }
    }
    
    func insertItems() {
        // insertItems控制精准，更合适，交互更友好
        self.collectionView.performBatchUpdates {
            // 在数据源中插入新的数据
            self.data[0].append("\(self.data[0].count + 1)")
            self.data[1].append("\(self.data[1].count + 1)")
            
            // 插入新的 cell
            let indexPath1 = IndexPath(item: self.data[0].count - 1, section: 0)
            let indexPath2 = IndexPath(item: self.data[1].count - 1, section: 1)
            
            self.collectionView.insertItems(at: [indexPath1, indexPath2])
        }
    }
}


