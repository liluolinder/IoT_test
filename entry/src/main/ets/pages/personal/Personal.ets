import {PersonalTopTittle} from './PersonalTopTittle'
import {PersonalInfo} from './PersonalInfo'
import {PersonalButtonList} from './PersonalButtonList'
import { LengthMetrics } from '@kit.ArkUI'

@ComponentV2
export struct  Personal {

  build() {

    Navigation(){
      PersonalTopTittle()             //调用同目录下PersonalTopTittle.ets

      Scroll(){

        Column(){

          PersonalInfo()
          PersonalButtonList().margin({top:20})

        }.height('100%').borderRadius('20')


      }.scrollable(ScrollDirection.Vertical)        //垂直方向滑动
      .scrollBar(BarState.Off)                      //不显示滑动条
      .edgeEffect(EdgeEffect.Spring,{alwaysEnabled: true})    //弹性滑动动效
      .height('100%')
    }.height('100%')
    .minContentWidth(400)
    .mode(NavigationMode.Stack)



    /*Column(){




    }
    .height('100%')*/

  }

}