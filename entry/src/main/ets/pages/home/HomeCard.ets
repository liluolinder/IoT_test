import { NormalLightCard } from '../../components/cards/lights/NormalLightCard'
import { StandardThermometer } from '../../components/cards/thermometers/StandardThermometer'

import  { DeviceClass } from '../../classes/DeviceClass'
import { deviceArray, GetDeviceInfoFromRdb, GetSceneInfoFromRdb} from '../../tools/DoingToRdb'
import { AppStorageV2, PersistenceV2 } from '@kit.ArkUI';
import { CacheSHareDataData } from '../../classes/AppStorageV2/CacheShareData';
import { PersistentShareData } from '../../classes/PersistenceV2/PersistentShareData';
import { HomeTopButtonBuilder } from './HomeTopButton';
import { HomeScene } from './HomeScene';

@ComponentV2
export struct HomeCard{

  @Provider('isHomeRefresh') isRefresh:boolean=false;

  @Local cacheSHareDataData:CacheSHareDataData = AppStorageV2.connect(CacheSHareDataData,()=>new CacheSHareDataData())!;

  @Local persistentShareData:PersistentShareData=PersistenceV2.connect(PersistentShareData,()=>new PersistentShareData)!;

  @Param@Once localScene:string=''

  @Local deviceArray:Array<DeviceClass>=deviceArray;

  build() {

    Refresh({refreshing:$$this.cacheSHareDataData.isRefresh}){

      Column(){

        Grid(){

          ForEach(this.deviceArray,(item:DeviceClass,id:number)=>{
            if(item.scene==this.localScene)
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
            }else if(this.localScene=='全部')
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
        .width('100%')
        .height('100%')
        .margin({top:5})
        .scrollBar(BarState.Off)
        .multiSelectable(true)
        .borderRadius('20')
        .edgeEffect(EdgeEffect.Spring,{ alwaysEnabled: true })
        .editMode(true)
        .onAppear(()=>{
          GetDeviceInfoFromRdb();
          GetSceneInfoFromRdb()
          setTimeout(()=>{
            this.deviceArray=deviceArray;
          },100);           //100ms刷新
        })

      }.height('100%')
      .width('100%')

    }.onRefreshing(()=>{
      GetDeviceInfoFromRdb();
      GetSceneInfoFromRdb();
      setTimeout(()=>{
        this.cacheSHareDataData.isRefresh=false;
        this.deviceArray=deviceArray;
      },150);           //100ms


    }).height('100%')


  }

}