import {HomeTopButton} from './HomeTopButton'

@Entry
@Component
export struct Home {

  build() {

    Column() {

      HomeTopButton()

    }
    .height('100%')

  }

}