import {HomeTopButton} from './HomeTopButton'
import {HomeTitleSelect} from  './HomeTitleSelect'

@Entry
@Component
export struct Home {

  build() {

    Column() {

      HomeTopButton()
      HomeTitleSelect().margin({top:20})
    }
    .height('100%')

  }

}