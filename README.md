### performBatchUpdates 崩溃测试
`insertItems`或者`reloadSections`时如果和数据的修改不一致就会导致崩溃，如下
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

如果你想要在 UICollectionView 中插入新的行而不是整个重新加载某个 section，建议使用 `insertItems` 方法。这可以提供更好的用户交互效果，而`reloadSections`会导致整个 section 重新加载，从而有闪烁的问题。
