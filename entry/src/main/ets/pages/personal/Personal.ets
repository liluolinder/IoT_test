import {PersonalTopTittle} from './PersonalTopTittle'
import {PersonalInfo} from './PersonalInfo'

@Entry
@Component
export struct  Personal {

  build() {



    Column(){

      PersonalTopTittle()             //调用同目录下PersonalTopTittle.ets

      Scroll(){

        PersonalInfo()

      }.scrollable(ScrollDirection.Vertical)        //垂直方向滑动
      .scrollBar(BarState.Off)                      //不显示滑动条
      .edgeEffect(EdgeEffect.Spring,{alwaysEnabled: true})    //弹性滑动动效

    }
    .height('100%')

  }

}