import { Home } from './home/Home'
import { Personal } from './personal/Personal'
import {DefaultHardVibration} from '../tools/Vibrator'
import { PersistentShareData } from '../classes/PersistenceV2/PersistentShareData';
import { PersistenceV2 } from '@kit.ArkUI';

@Entry
@ComponentV2
struct Index {
  @Local persistentShareData:PersistentShareData=PersistenceV2.connect(PersistentShareData,()=>new PersistentShareData)!;


  build() {

    Tabs({ barPosition: this.persistentShareData.curBp === "lg" ? BarPosition.Start : BarPosition.End }) {

      TabContent() {

        Column() {

          Home() //调用pages_home_home.ets

        }

      }.tabBar('主页').expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])//沉浸式拓展安全区


      TabContent() {

        Column() {

          Personal()    //调用pages_personal_Personal.ets

        }

      }.tabBar('我的').expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])//沉浸式拓展安全区

    }
    .onChange(()=>{DefaultHardVibration()})
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])//沉浸式拓展安全区
    .vertical(false) //水平索引
    .scrollable(false) //允许左右滑动切换
    .backgroundColor('#F1F3F5') //背景色 (灰色，hw经典色)
    .barMode(BarMode.Fixed)
    .barWidth(this.persistentShareData.curBp === "lg" ? 96 : '100%')
    .barHeight(this.persistentShareData.curBp === "lg" ? '60%' : 56)
    .vertical(this.persistentShareData.curBp === "lg")
    .divider({
      strokeWidth: 0.5,
      color: '#0D182431'
    }) //TabBar导航页签栏与TabContent进行分割

  }

}