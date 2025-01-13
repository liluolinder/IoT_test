import {NormalLightCard} from '../../components/cards/lights/NormalLightCard'

@Component
export struct HomeCard{
  build() {

    Grid(){

      ForEach([0,1,2,3,4,5,6,7,8,9,10,11],()=>{

        GridItem()
        {

          NormalLightCard()

        }

      })


    }.columnsTemplate('repeat(auto-stretch, 150)')
    .rowsGap(20)
    .width('90%')
    .height('100%')
    .margin({top:5})
    .scrollBar(BarState.Off)
    .multiSelectable(true)


  }

}