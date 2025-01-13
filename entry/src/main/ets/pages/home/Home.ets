import {HomeTopButton} from './HomeTopButton'
import {HomeCard} from './HomeCard'

@Component
export struct Home {

  build() {

    Column() {

      HomeTopButton()
      HomeCard()

    }
    .height('100%')


  }

}