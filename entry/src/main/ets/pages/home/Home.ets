import {HomeTopButton} from './HomeTopButton'
import {HomeCard} from './HomeCard'

@ComponentV2
export struct Home {

  build() {

    Column() {

      HomeTopButton()

      HomeCard().margin({top:10}).height('90%')


    }.height('100%')



  }

}