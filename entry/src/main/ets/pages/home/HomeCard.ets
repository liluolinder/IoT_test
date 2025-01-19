import { NormalLightCard } from '../../components/cards/lights/NormalLightCard'
import { StandardThermometer } from '../../components/cards/thermometers/StandardThermometer'

import  { DeviceClass } from '../../classes/DeviceClass'
import { deviceArray, GetDeviceInfoFromRdb} from '../../tools/DoingToRdb'

@Component
export struct HomeCard{

  @State myDeviceArray:Array<DeviceClass>=[]
  @StorageLink('isHomeRefresh') isRefresh:boolean=false

  build() {

    Refresh({refreshing:$$this.isRefresh}){

      Column(){

        Grid(){

          ForEach(this.myDeviceArray,(item:DeviceClass,id:number)=>{
            if(item.scene=='我的家')
            {
              GridItem()
              {
                if(item.deviceType=='light')
                {
                  NormalLightCard({normalLightName:item.deviceName,scene:item.scene,idInRdb:item.id})
                }
                else if(item.deviceType=='thermometer')
                {
                  StandardThermometer({standardThermometerName:item.deviceName,scene:item.scene,idInRdb:item.id})
                }
              }
            }
          })
        }.columnsTemplate('repeat(auto-stretch, 150)')
        .rowsGap(20)
        .width('90%')
        .height('100%')
        .margin({top:5})
        .scrollBar(BarState.Off)
        .multiSelectable(true)
        .borderRadius('20')
        .edgeEffect(EdgeEffect.Spring,{ alwaysEnabled: true })
        .editMode(true)
        .onAppear(()=>{
          setTimeout(()=>{GetDeviceInfoFromRdb();
            this.myDeviceArray=deviceArray;},100)
        })

      }

    }.onRefreshing(()=>{
      GetDeviceInfoFromRdb();
      setTimeout(()=>{
        this.myDeviceArray=deviceArray;
        this.isRefresh=false
      },500);

    })


  }

}