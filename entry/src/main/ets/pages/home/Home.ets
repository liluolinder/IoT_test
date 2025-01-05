import {HomeTopButton} from './HomeTopButton'
import {HomeTitleSelect} from  './HomeTitleSelect'
import {HomeCard} from './HomeCard'
@Component
export struct Home {

  build() {

    Column() {

      HomeTopButton()
      HomeTitleSelect().margin({top:20})
      HomeCard().margin({top:20})
    }
    .height('100%')


  }

}