import { Home } from './home/Home'
import { Personal } from './personal/Personal'
import {ChangeTabVibrator} from '../tools/ChangeTabVibrator'

@Entry
@Component
struct Index {

  build() {

    Tabs({ barPosition: BarPosition.End }) {

      TabContent() {

        Column() {

          Home() //调用pages_home_home.ets

        }

      }.tabBar('主页').expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])//沉浸式拓展安全区

      TabContent() {



      }.tabBar('场景').expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])//沉浸式拓展安全区

      TabContent() {

        Column() {

          Personal()    //调用pages_personal_Personal.ets

        }

      }.tabBar('我的').expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])//沉浸式拓展安全区

    }
    .onChange(()=>{ChangeTabVibrator()})
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])//沉浸式拓展安全区
    .vertical(false) //水平索引
    .scrollable(false) //允许左右滑动切换
    .backgroundColor('#F1F3F5') //背景色 (灰色，hw经典色)
    .divider({
      strokeWidth: 0.5,
      color: '#0D182431'
    }) //TabBar导航页签栏与TabContent进行分割

  }
}