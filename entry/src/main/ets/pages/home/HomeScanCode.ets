import { scanCore, scanBarcode } from '@kit.ScanKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { storeRdb } from '../../entryability/EntryAbility';
import { relationalStore } from '@kit.ArkData';
import { newDeviceClass } from '../../classes/DeviceClass';
import { sceneArraySelect } from '../../tools/DoingToRdb';
import { CacheSHareDataData } from '../../classes/AppStorageV2/CacheShareData';
import { AppStorageV2 } from '@kit.ArkUI';

@ComponentV2
export struct HomeScanCode{

  @Local cacheSHareDataData:CacheSHareDataData = AppStorageV2.connect(CacheSHareDataData,()=>new CacheSHareDataData())!;

  @Param @Once result1:string=''

  @Local addNewDeviceType:newDeviceClass|undefined=undefined;

  @Local addNewDeviceName:string='';

  @Local addNewDeviceScene:string='';

  @Local valueBucket: relationalStore.ValuesBucket | undefined= undefined;

  @Consumer('isScanCode')isScanCode:boolean = false;

  @Local newDeviceArray:Array<newDeviceClass>=[
    new newDeviceClass('灯',$r('app.media.normalLightOff')),
    new newDeviceClass('温度计',$r('app.media.thermometer')),
    new newDeviceClass('电视',$r('app.media.startIcon')),
    new newDeviceClass('空调',$r('app.media.startIcon')),
  ]

  aboutToAppear(): void {
    if(this.result1=='light')
    {
      this.addNewDeviceType=this.newDeviceArray[0];
    }else if(this.result1=='thermometer'){
      this.addNewDeviceType=this.newDeviceArray[1];
    }
  }

  build() {

    Stepper(){

      StepperItem(){
        Column(){

          Image(this.addNewDeviceType?.devicePic)
            .height('100')
            .margin({bottom:10})

          TextInput({placeholder:'请输入新设备名称',text:$$this.addNewDeviceName})
            .margin({bottom:10})
            .width('100%')

          Select(sceneArraySelect).width('100%').onSelect((index:number, text: string )=>{
            this.addNewDeviceScene=text;
          })



        }.width('90%')
        .height('100%')

      }
    }.margin({bottom:10})
    .onFinish(()=>{

      if(this.addNewDeviceType?.deviceName=='灯')
      {
        this.valueBucket = {
          'DEVICE_NAME' : this.addNewDeviceName,
          'SCENE' :  this.addNewDeviceScene,
          'IS_OPEN' : 0,        //0为关,1为关开,2为不启用
          'DEVICE_TYPE':'light',
          'LIGHT_BRIGHTNESS':1,
        };

      }else if(this.addNewDeviceType?.deviceName=='温度计')
      {
        this.valueBucket = {
          'DEVICE_NAME' : this.addNewDeviceName,
          'SCENE' :  this.addNewDeviceScene,
          'IS_OPEN' :2 ,  //2表示不启用
          'DEVICE_TYPE':'thermometer',
          'LIGHT_BRIGHTNESS':0,//0表示不启用
        };
      }else{
        return
      }

      if (storeRdb !== undefined) {
        (storeRdb as relationalStore.RdbStore).insert('DEVICE_TABLE', this.valueBucket, (err: BusinessError, rowId: number) => {
          if (err) {
            console.error(`Failed to insert data. Code:${err.code}, message:${err.message}`);
            return;
          }
          console.info(`Succeeded in inserting data. rowId:${rowId}`);
        })
      }

      this.isScanCode=false;

      setTimeout(()=>{this.cacheSHareDataData.isRefresh=true;}
        ,50)

    })

    }



}