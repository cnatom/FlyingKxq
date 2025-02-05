//
//  NewsModel.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/31.
//

struct NewsModel {
    var typeList: [NewsSource] = []

    var tab1List: [String] {
        var result = [String]()
        for item in typeList {
            if let name = item.categoryName {
                result.append(name)
            }
        }
        return result
    }

    func tab2List(at index: Int) -> [String] {
        var result = [String]()
        if typeList.indices.contains(index),
           let categoryList = typeList[index].categoryList {
            for category in categoryList {
                if let shortName = category.shortName {
                    result.append(shortName)
                }
            }
        }
        return result
    }

    func tab3List(index1: Int,index2: Int) -> [String] {
        var result = [String]()
        if typeList.indices.contains(index1),
           typeList[index1].categoryList?.indices.contains(index2) == true,
           let item = typeList[index1].categoryList?[index2].sourceName {
            for source in item {
                result.append(source)
            }
        }
        return result
    }

    func listModel(index1: Int, index2: Int, index3: Int) -> NewsListModel {
        var result = NewsListModel()
        guard typeList.indices.contains(index1),
              let categoryList = typeList[index1].categoryList else {
            return result
        }
        guard categoryList.indices.contains(index2),
              let sourceNameList = categoryList[index2].sourceName else {
            return result
        }
        guard sourceNameList.indices.contains(index3) else {
            return result
        }
        result.newsCategory = typeList[index1].categoryName ?? ""
        result.newsType = categoryList[index2].newsType ?? ""
        result.sourceName = sourceNameList[index3]
        result.shortName = categoryList[index2].shortName ?? ""
        return result
    }
}
