
# spanフラグ付与

抽出したSpanに対してSpanフラグを付与する(32種類)。sub_spanには不要。

## 種別

| 種別 | 概要 |
|---|---|
|シーン|どんな旅行シーンを目的とした旅行なのか、例えば家族旅行なのか(子供の有無)、恋人、友人との旅行かどうか。また、どこのエリアや地域に旅行したいと思っているのか。|
|人数|旅行者の人数やその内訳(子供、幼児が含まれているかどうか。)|
|子供|ユーザがホテル側に子供や幼児むけサービスを求めているかどうか。|
|日程|宿泊する際に必須な日付と泊数に関する要望。具体的ではない場合は、その時期、曜日などを含む。|
|ホテル|宿のタイプや求める宿の雰囲気や宿泊者が求めているイメージについて。|
|立地|宿泊したい宿から駅やランドマーク、施設までの距離や近さ。また、ホテル近くでできる体験について。|
|予算|宿泊する際の求める予算。上限や下限の情報だけでなくなるべく安くなど値を設定しにくい表現も含める。|
|食事|宿が提供する朝食夕食の有無。また要望する料理内容の種類や素材、量、味について。|
|部屋|泊まりたい部屋の条件について。部屋の広さ、清潔感、眺望、雰囲気などの表現、部屋の中の設備についての要望、部屋に設置しているアメニティを含む。|
|風呂|風呂全般に対する要望。風呂の種類やお風呂に関する広さ、眺望、雰囲気、清潔感、泉質や浴槽の素材などの表現を含む。|
|施設|ホテル内でできるレジャー施設やプールやスパなどへの要望。|
|サービス|その他のホテル側に期待しているサービス内容。|

## spanフラグの種類

| 種別 | spanフラグ |説明| スパンに含まれる単語 (entity)|
| --- | --- | --- | --- |
|シーン| Ts | 旅行シーン (travel scene)| ひとり旅、一人旅、出張、夫婦旅行、恋人旅行、友達旅行、子連れ旅行、家族旅行、団体旅行|
| | Te | 旅行エリア | 草津(温泉)、京都、沖縄(ビーチ)、大阪、北海道(自然、雪)、長野(ハイキング、登山、甲信越、アウトドア)|
|人数| Na | 大人 (Number of adults)| 大人の人数(子供の指定がない場合は、大人とカウント)|
| | Nc | 子供 (Number of children)| 小学生人数、幼児人数|
|子供| Sc | 子供用サービス (Services for children) | 小学生人数、幼児人数|
| | Sb | 幼児サービス (Services for baby) | 幼児・ベビー用に用意している備品(オムツ有無,ベビーベッド,ベビーチェア有無,離乳食)、幼児歓迎、ベビーフレンドリー,ベビーお風呂入れるか,料理の幼児対応|
|日程|Sd| 宿泊日 (Stay Date)| 宿泊開始日(ある場合は終了日も)|
| | Ss | 時期 (Season)| 土日、連休、平日、今週末、金土日、上旬、中旬、下旬、土日祝日、冬、紅葉の季節、最安の日程、上旬〜中旬、下旬〜翌月上旬、曜日指定、月指定、花見、夏休み、GW(季節や祝日、長期休みあるいは平日なのか)|
| | Sn | 宿泊数 (Number of Stays) | 何泊数|
|ホテル| Ht | 宿タイプ (Hotel type)| 宿の種類(ホテル,旅館,ペンション・民宿・ロッジ,貸別荘,公共の宿、ビジネスホテル)、ビジネスホテル以外、ゲストハウス・カプセルホテル以外、宿名 |
| | He | 宿環境 (Hotel environment) | 綺麗、新しい宿、落ち着いた感じの宿(宿の雰囲気や眺望など宿泊者が求めているイメージ)、妊婦歓迎、女性お一人様OK、ペットOK、こじんまりした宿、古民家風、和風な宿、静かな宿、外国人向け、インスタ映え、京都っぽい、バリアフリー/バリヤフリー(車いす、風呂に手すり)、非日常性|
|立地| En | 立地 (周辺環境) (Environment) | スーパー近い,コンビニ近い,繁華街に近い、近くに居酒屋、コンビニ近い、スーパー近い、バスターミナルに近い、外食に便利|
| | Ep | 立地 (場所) (Place) | 駅から徒歩5分以内(ホテルの駅、エリア、ランドマークなどからの距離)、交通の便の良い、指定駅周辺、指定施設周辺、指定バス停周辺|
| | Ea |立地 (アクティビ ティ) (activity) | 近くで釣りが可能,近くに温泉があるか、ビーチまで徒歩5分,観光に便利、近くに温泉があるか、近くで釣りが可能、寺院めぐりに適した立地、近くに子供が楽しめる場所、桜の名所周辺、スキー場の近く、[観光地名]の近く|
|予算| Bp | 予算 (Total buget per person) | 予算下限,予算上限、あるいはなし。|
| | Bt| 予算感 (Total budget)| リーズナブル、もう少し安い、予算は高すぎず安過ぎず、最安、コスパ|
|食事| Mc | 食事有無 (Meal charge) | 指定なし,食事なし,朝のみ,夕のみ,朝/夕あり、部屋で朝食、部屋で夕食、個室で朝食、個室で夕食|
| | Mt | 食事内容 (Meal type) | どんな食事を期待しているのか、【朝食】朝食はビュッフェ、朝食が美味しい、朝食はビュッフェ以外、朝食和食【夕食】ビュッフェ、ビュッフェ以外、料理が美味しい、特徴的な料理、併設レストラン、郷土料理海鮮料理、懐石料理、飲み放題、夜食、姿造り、舟盛、京料理、和食、洋食【2食対応】ベジタリアン対応、アレルギー対応、椅子に座って食事 |
|部屋 |Rn |部屋数 (Room Number) |部屋数|
| |Rt |部屋タイプ (Room type) |部屋の間取り(シングル,ツイン,ダブル,トリプル,4ベッド,和室,和洋室)|
| |Re |部屋環境 (Room environment) |景色がいい、ゆったりできる、清潔(宿泊者が求めている部屋への環境条件)|
| |Rc |部屋条件 (Room condition) |禁煙ルーム,完全禁煙室,特別室・離れ・スイート|
| |Rf |部屋設備 (Room facility) |露天風呂付き客室,部屋内トイレ,ウォシュレット,部屋に冷蔵庫,冷暖房完備,BS(衛星放送が見れるかどうか),WiFi,バス・トイレ付き,|
| |Rq |部屋備品 (Room equipment) |PCの貸し出しサービス,氷サービス,加湿器有,空気清浄機貸し出し,寝具が高級,湯沸しポット|
| |Ra |部屋アメニティ (Room amenity) |ドライヤー,シャンプー,タオル,浴衣,色浴衣,パジャマ、パジャマ、タオル|
|風呂|Bp|風呂種類(Bathtype)|温泉,内湯・大浴場,貸切風呂・貸切露天,展望風呂,露天風呂,温泉掛け流し,にごり湯、男女別大浴場、貸切露天風呂、貸切風呂、展望風呂、温泉掛け流し、岩風呂、硫黄泉、白濁温泉、にごり湯、お風呂の種類が多い、広い露天風呂|
| | Be | 風呂環境 (Bath environment) | 雰囲気、泉質、効能など|
|施設|Fp|施設条件(プール,スパ)(Pool and Spa)|屋外プール,屋内プール,サウナ,ジャグジー,エステ設備、エステ、マッサージ、ミストサウナ、フィットネス|
| | Fl | 施設条件(レジャー)(Leisure facilities) |卓球あり,宴会場,将棋,テニス,カラオケ,ゲームコーナー,麻雀,ペット,ラウンジ,売店、中庭、宴会場|
|サービス| Hs |ホテルサービス (Hotel service) | 駐車場無料,駐車場、送迎あり,貸しスキー,貸しボード,オンラインカード決済可能,バイク用駐輪場、大型車駐車場|
| | Hc | チェックイン条件 (Check-in conditions) | チェックイン14時以前|
| | Ho | チェックアウト条件 (Check-out conditions) | チェックアウト11時以降 |

- 「近くに○○」の○○が具体的観光スポット名の場合、``Ea``とする。 (例: 近くで釣りが可能,近くに温泉があるか、ビーチまで徒歩5分,観光に便利、近くに温泉があるか、近くで釣りが可能、寺院めぐりに適した立地、近くに子供が楽しめる場所、桜の名所周辺、スキー場の近く)
