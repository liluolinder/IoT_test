import { Home } from './home/Home'
import { Personal } from './personal/Personal'
import { vibrator } from '@kit.SensorServiceKit';

@Entry
@Component
struct Index {


  ChangeTabVibrator()             //切换Tab页面时候的震动
  {
    try {
      vibrator.startVibration({
        type: 'preset',           //默认
        effectId: 'haptic.effect.hard',   //https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V13/js-apis-vibrator-V13#effectid
        count: 2,          //震动次数
      }, {
        usage: 'touch'          //使用场景，系统决定优先级
      })
    }catch (err)
    {
      return ;
    }
  }

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
    .onChange(()=>{this.ChangeTabVibrator()})
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