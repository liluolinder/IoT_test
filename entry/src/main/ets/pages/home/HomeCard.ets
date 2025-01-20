import { NormalLightCard } from '../../components/cards/lights/NormalLightCard'
import { StandardThermometer } from '../../components/cards/thermometers/StandardThermometer'

import  { DeviceClass } from '../../classes/DeviceClass'
import { deviceArray, GetDeviceInfoFromRdb} from '../../tools/DoingToRdb'
import { AppStorageV2 } from '@kit.ArkUI';
import { HomeCardData } from '../../classes/AppStorageV2/HomeCardData';

@ComponentV2
export struct HomeCard{

  @Local myDeviceArray:Array<DeviceClass>=[];

  @Provider('isHomeRefresh') isRefresh:boolean=false;

  @Local homeCardData:HomeCardData = AppStorageV2.connect(HomeCardData,()=>new HomeCardData())!;


  build() {

    Refresh({refreshing:$$this.homeCardData.isRefresh}){

      Column(){

        Grid(){

          ForEach(this.myDeviceArray,(item:DeviceClass,id:number)=>{
            if(item.scene=='我的家')
            {
              GridItem()
              {
                if(item.deviceType=='light')
                {
                  NormalLightCard({normalLightName:item.deviceName,scene:item.scene,idInRdb:item.id,isOpen:item.isOpen==1?true:false,lightBrightness:item.lightBrightness})
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
        this.homeCardData.isRefresh=false;
      },700);           //700ms后刷新

    })


  }

}