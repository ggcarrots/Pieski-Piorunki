//
//  NewsViewModel.swift
//  carrots
//
//  Created by Mateusz Orzoł on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit

final class NewsViewModel {
    
    
    public var newsCategoriesContent: [NewsCategoryContent] = []
    
    var newsCategoriesContentUpdated: (() -> ())?
    
    var doneMinutes: Int {
        var minutes = 0
        for content in newsCategoriesContent {
            for con in content.newsContent {
                if con.finished { minutes += con.time }
            }
        }
        return minutes
    }
    let maxMinutes: Int = 14
    
    
    init() {
        newsCategoriesContent = generateContent()
        newsCategoriesContentUpdated?()
    }
    
    
    func select(from category: NewsCategory, at index: Int, vc: UIViewController) {
        guard let modelCategory = newsCategoriesContent.first(where: { $0.category == category}) else { return }
        let model = modelCategory.newsContent[index]
        if model.isFromCloud {
            UIApplication.shared.open(model.URL, options: [:]) { [weak self] (_) in
                self?.updateNewsContent(for: category, at: index)
                self?.newsCategoriesContentUpdated?()
            }
        } else {
            guard let info = model.articleInfo else { return }
            print(info.title)
            vc.performSegue(withIdentifier: "htmlText", sender: info)
            self.updateNewsContent(for: category, at: index)
            self.newsCategoriesContentUpdated?()
        }
    }
    
    private func updateNewsContent(for category: NewsCategory, at index: Int) {
        guard let indexOfCategory = newsCategoriesContent.firstIndex(where: {$0.category == category }) else { return }
        newsCategoriesContent[indexOfCategory].newsContent[index].finished = true
    }
    
    private func generateContent() -> [NewsCategoryContent] {
        let one = NewsCategoryContent(category: .politology,
                                      newsContent: [
                                        NewsContent(isFromCloud: true, time: 6, newsType: .article, title: "Trump Kim Summit", finished: false, image: #imageLiteral(resourceName: "polityka"), URL: URL(string: "https://www.washingtonpost.com/news/worldviews/wp/2018/06/13/was-the-trump-kim-summit-a-huge-success-or-a-colossal-failure/?utm_term=.2ecbaa2bb628")!, articleInfo: nil),
                                        NewsContent(isFromCloud: true, time: 5, newsType: .movie, title: "Huawei", finished: false, image: #imageLiteral(resourceName: "polixdtyka"), URL: URL(string: "https://www.youtube.com/watch?v=5K4jwvFvZSk")!, articleInfo: nil),
                                        NewsContent(isFromCloud: true, time: 1, newsType: .twitter, title: "Trump", finished: false, image: #imageLiteral(resourceName: "politycka"), URL: URL(string: "https://twitter.com/realDonaldTrump/status/1137035722043547649")!, articleInfo: nil),
                                        NewsContent(isFromCloud: false, time: 5, newsType: .article, title: "Mathew Rojansky", finished: false, image: nil, URL: URL(string: "https://twitter.com/realDonaldTrump/status/1137035722043547649")!, articleInfo: Info.i1),
                                        NewsContent(isFromCloud: true, time: 6, newsType: .article, title: "Trump Kim Summit", finished: false, image: #imageLiteral(resourceName: "polityka"), URL: URL(string: "https://www.washingtonpost.com/news/worldviews/wp/2018/06/13/was-the-trump-kim-summit-a-huge-success-or-a-colossal-failure/?utm_term=.2ecbaa2bb628")!, articleInfo: nil),
                                        NewsContent(isFromCloud: true, time: 5, newsType: .movie, title: "Huawei", finished: false, image: #imageLiteral(resourceName: "polixdtyka"), URL: URL(string: "https://www.youtube.com/watch?v=5K4jwvFvZSk")!, articleInfo: nil),
                                        NewsContent(isFromCloud: true, time: 1, newsType: .twitter, title: "Trump", finished: false, image: #imageLiteral(resourceName: "politycka"), URL: URL(string: "https://twitter.com/realDonaldTrump/status/1137035722043547649")!, articleInfo: nil),
                                        NewsContent(isFromCloud: false, time: 5, newsType: .twitter, title: "Mathew Rojansky", finished: false, image: nil, URL: URL(string: "https://twitter.com/realDonaldTrump/status/1137035722043547649")!, articleInfo: Info.i1)
            ])
        let two = NewsCategoryContent(category: .mathematics,
                                      newsContent: [
                                        NewsContent(isFromCloud: true, time: 5, newsType: .movie, title: "Wartość oczekiwana", finished: false, image: #imageLiteral(resourceName: "matma2"), URL: URL(string: "https://www.youtube.com/watch?v=4RGobx7PN0U")!, articleInfo: nil),
                                        NewsContent(isFromCloud: true, time: 6, newsType: .movie, title: "Rozkład dwupunktowy", finished: false, image: #imageLiteral(resourceName: "matma"), URL: URL(string: "https://www.youtube.com/watch?v=_wauTjyoEYg")!, articleInfo: nil),
                                        NewsContent(isFromCloud: false, time: 6, newsType: .article, title: "Zależność zmiennych losowych.", finished: false, image: nil, URL: URL(string: "https://www.youtube.com/watch?v=_wauTjyoEYg")!, articleInfo: Info.i2),
                                        NewsContent(isFromCloud: true, time: 5, newsType: .movie, title: "Wartość oczekiwana", finished: false, image: #imageLiteral(resourceName: "matma2"), URL: URL(string: "https://www.youtube.com/watch?v=4RGobx7PN0U")!, articleInfo: nil),
                                        NewsContent(isFromCloud: true, time: 6, newsType: .movie, title: "Rozkład dwupunktowy", finished: false, image: #imageLiteral(resourceName: "matma"), URL: URL(string: "https://www.youtube.com/watch?v=_wauTjyoEYg")!, articleInfo: nil),
                                        NewsContent(isFromCloud: false, time: 6, newsType: .article, title: "Zależność zmiennych losowych.", finished: false, image: nil, URL: URL(string: "https://www.youtube.com/watch?v=_wauTjyoEYg")!, articleInfo: Info.i2)
                                                    ])
        let three = NewsCategoryContent(category: .politology,
                                      newsContent: [
                                        NewsContent(isFromCloud: true, time: 6, newsType: .article, title: "Trump Kim Summit", finished: false, image: #imageLiteral(resourceName: "polityka"), URL: URL(string: "https://www.washingtonpost.com/news/worldviews/wp/2018/06/13/was-the-trump-kim-summit-a-huge-success-or-a-colossal-failure/?utm_term=.2ecbaa2bb628")!, articleInfo: nil),
                                        NewsContent(isFromCloud: true, time: 5, newsType: .movie, title: "Huawei", finished: false, image: #imageLiteral(resourceName: "polixdtyka"), URL: URL(string: "https://www.youtube.com/watch?v=5K4jwvFvZSk")!, articleInfo: nil),
                                        NewsContent(isFromCloud: true, time: 1, newsType: .twitter, title: "Trump", finished: false, image: #imageLiteral(resourceName: "politycka"), URL: URL(string: "https://twitter.com/realDonaldTrump/status/1137035722043547649")!, articleInfo: nil),
                                        NewsContent(isFromCloud: false, time: 5, newsType: .twitter, title: "Mathew Rojansky", finished: false, image: nil, URL: URL(string: "https://twitter.com/realDonaldTrump/status/1137035722043547649")!, articleInfo: Info.i1),
                                        NewsContent(isFromCloud: true, time: 6, newsType: .article, title: "Trump Kim Summit", finished: false, image: #imageLiteral(resourceName: "polityka"), URL: URL(string: "https://www.washingtonpost.com/news/worldviews/wp/2018/06/13/was-the-trump-kim-summit-a-huge-success-or-a-colossal-failure/?utm_term=.2ecbaa2bb628")!, articleInfo: nil),
                                        NewsContent(isFromCloud: true, time: 5, newsType: .movie, title: "Huawei", finished: false, image: #imageLiteral(resourceName: "polixdtyka"), URL: URL(string: "https://www.youtube.com/watch?v=5K4jwvFvZSk")!, articleInfo: nil),
                                        NewsContent(isFromCloud: true, time: 1, newsType: .twitter, title: "Trump", finished: false, image: #imageLiteral(resourceName: "politycka"), URL: URL(string: "https://twitter.com/realDonaldTrump/status/1137035722043547649")!, articleInfo: nil),
                                        NewsContent(isFromCloud: false, time: 5, newsType: .twitter, title: "Mathew Rojansky", finished: false, image: nil, URL: URL(string: "https://twitter.com/realDonaldTrump/status/1137035722043547649")!, articleInfo: Info.i1)
            ])
        let four = NewsCategoryContent(category: .mathematics,
                                      newsContent: [
                                        NewsContent(isFromCloud: true, time: 5, newsType: .movie, title: "Wartość oczekiwana", finished: false, image: #imageLiteral(resourceName: "matma2"), URL: URL(string: "https://www.youtube.com/watch?v=4RGobx7PN0U")!, articleInfo: nil),
                                        NewsContent(isFromCloud: true, time: 6, newsType: .movie, title: "Rozkład dwupunktowy", finished: false, image: #imageLiteral(resourceName: "matma"), URL: URL(string: "https://www.youtube.com/watch?v=_wauTjyoEYg")!, articleInfo: nil),
                                        NewsContent(isFromCloud: false, time: 6, newsType: .article, title: "Zależność zmiennych losowych.", finished: false, image: nil, URL: URL(string: "https://www.youtube.com/watch?v=_wauTjyoEYg")!, articleInfo: Info.i2),
                                        NewsContent(isFromCloud: true, time: 5, newsType: .movie, title: "Wartość oczekiwana", finished: false, image: #imageLiteral(resourceName: "matma2"), URL: URL(string: "https://www.youtube.com/watch?v=4RGobx7PN0U")!, articleInfo: nil),
                                        NewsContent(isFromCloud: true, time: 6, newsType: .movie, title: "Rozkład dwupunktowy", finished: false, image: #imageLiteral(resourceName: "matma"), URL: URL(string: "https://www.youtube.com/watch?v=_wauTjyoEYg")!, articleInfo: nil),
                                        NewsContent(isFromCloud: false, time: 6, newsType: .article, title: "Zależność zmiennych losowych.", finished: false, image: nil, URL: URL(string: "https://www.youtube.com/watch?v=_wauTjyoEYg")!, articleInfo: Info.i2)
            ])
        return [one, two, three, four]
    }
}

