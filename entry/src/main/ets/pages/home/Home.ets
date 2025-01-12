import {HomeTopButton} from './HomeTopButton'

import {HomeCard} from './HomeCard'
@Component
export struct Home {

  build() {

    Column() {

      HomeTopButton()

      HomeCard().margin({top:20})


    }
    .height('100%')


  }

}