# [#SwiftUIレイアウト一本勝負](https://twitter.com/search?q=%23SwiftUI%E3%83%AC%E3%82%A4%E3%82%A2%E3%82%A6%E3%83%88%E4%B8%80%E6%9C%AC%E5%8B%9D%E8%B2%A0) - SwiftUIWeeklyLayoutChallenge

[#SwiftUIレイアウト一本勝負](https://twitter.com/search?q=%23SwiftUI%E3%83%AC%E3%82%A4%E3%82%A2%E3%82%A6%E3%83%88%E4%B8%80%E6%9C%AC%E5%8B%9D%E8%B2%A0) は、「お題」として Twitter に投稿されたスクリーンショットをもとに、その UI レイアウトを各々が SwiftUI で構成、それをインターネット上で共有し合うイベントです。

## イベントの意図
1つの UI レイアウトを SwiftUI によって実現するとき、さまざまな表現方法があると思っています。求められる要件などによって最適と思われるコーディングを行うことは、デベロッパの腕の見せどころです。

原則、1枚のスクリーンショットによって示されたお題に対して、多くの人が「自分なら SwiftUI でどう UI レイアウトを組むか？」について共有し合うことで、SwiftUI による UI レイアウトの理解を深めることを目的としています。

[ハッシュタグに「勝負」という単語が含まれていますが、「最も優れたコード・優勝者」を決めることはしません。](https://twitter.com/treastrain/status/1547115218664574976)

また、お題の「1枚のスクリーンショット」と非常に限定的なテキストによる補足情報のみから UI レイアウトを組むことになるため、それ以外で必要とされる情報については各自で補完する必要があります。そのため、各お題の「絶対的な正解」は存在せず、よって各お題の締め切りも設定しません。

## 取り組み方
[#SwiftUIレイアウト一本勝負](https://twitter.com/search?q=%23SwiftUI%E3%83%AC%E3%82%A4%E3%82%A2%E3%82%A6%E3%83%88%E4%B8%80%E6%9C%AC%E5%8B%9D%E8%B2%A0) のハッシュタグがついた、お題のツイートが定期的に [@treastrain](https://twitter.com/treastrain) より行われます。そのツイートのリプライにある、お題に対して適用されるレギュレーションを守りながら、SwiftUI による UI レイアウトコーディングを行なってください。

## 本リポジトリについて
本リポジトリには、[#SwiftUIレイアウト一本勝負](https://twitter.com/search?q=%23SwiftUI%E3%83%AC%E3%82%A4%E3%82%A2%E3%82%A6%E3%83%88%E4%B8%80%E6%9C%AC%E5%8B%9D%E8%B2%A0) に取り組む際に便利なテンプレートが含まれています。

1. Local Swift Package である `SwiftUIWeeklyLayoutChallenge` ディレクトリ下にある `TopicXXX.swift` を複製し、`TopicXXX` を適当な名前に変更する（`Topic001` など）。
1. `ContentView.swift` の中身を前ステップで変更した名前にあわせて変更する。
    ```diff
    - typealias ContentView = TopicXXXView
    + typealias ContentView = Topic001View
    ```
1. 前々ステップで複製した Swift ファイルを使ってコーディングを行う。

iOS・macOS・tvOS・watchOS でそれぞれの App としてビルド・実行するための Xcode Project も同梱しています。

また、レギュレーションやお題についての Markdown ファイル、お題のスクリーンショットを生成するために使用した SwiftUI によるコードも含まれています（そのコードがお題に対する絶対的な正解とは限りません）（お題のスクリーンショットを生成するために使用した SwiftUI によるコードは、お題ツイート日時より日をあけて公開されます）。

本リポジトリは、過去のお題をまとめたカタログ App となることは意図されていません。

## きっかけ
https://twitter.com/treastrain/status/1546884462738571265

[#SwiftUIレイアウト一本勝負](https://twitter.com/search?q=%23SwiftUI%E3%83%AC%E3%82%A4%E3%82%A2%E3%82%A6%E3%83%88%E4%B8%80%E6%9C%AC%E5%8B%9D%E8%B2%A0) に取り組んだ際には、ぜひ Twitter、Zenn、Qiita やブログ記事などであなたが書いた SwiftUI のコードを共有してください！個人による取り組みだけでなく、企業・団体の勉強会などでも自由にお使いいただけます。

## お題の提供
[#SwiftUIレイアウト一本勝負](https://twitter.com/search?q=%23SwiftUI%E3%83%AC%E3%82%A4%E3%82%A2%E3%82%A6%E3%83%88%E4%B8%80%E6%9C%AC%E5%8B%9D%E8%B2%A0) で取り上げたいお題についても募集しています。お題ができた方はぜひ [@treastrain](https://twitter.com/treastrain) に Twitter DM で連絡してください（すべて採用される保証はありませんのでご了承ください）。お題作成者の Twitter ID は、お題ツイートのリプライに記載されます（[第001回の例](https://twitter.com/treastrain/status/1547154248475234304)）。
