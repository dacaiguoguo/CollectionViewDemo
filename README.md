### performBatchUpdates 崩溃测试
insertItems和数据的append，不一致就会导致崩溃，如下
```
        self.collectionView.performBatchUpdates {
            // 在数据源中插入新的数据
            self.data[0].append("\(self.data[0].count + 1)")
            //  self.data[1].append("\(self.data[1].count + 1)")
            
            // 插入新的 cell
            let indexPath1 = IndexPath(item: self.data[0].count - 1, section: 0)
            let indexPath2 = IndexPath(item: self.data[1].count - 1, section: 1)
            
            self.collectionView.insertItems(at: [indexPath1, indexPath2])
        }
```

建议`insertItems`以获得更好的交互效果，而不是简单的`reloadSections`导致闪一下，还需要额外处理闪一下的问题
