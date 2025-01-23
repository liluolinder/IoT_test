import { HomeCard } from './HomeCard'
import { HomeScene } from './HomeScene'
import { HomeSceneTab } from './HomeSceneTab'
import { HomeTopButtonBuilder } from './HomeTopButton'


@ComponentV2
export struct Home{

  build() {

    Navigation(){

      HomeScene()

    }.height('100%')
      .width('90%')
      .title('我的家')
      .titleMode(NavigationTitleMode.Free)
      .menus(HomeTopButtonBuilder())
      .mode(NavigationMode.Stack)


  }

}