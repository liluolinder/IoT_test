import { DeviceClass, newDeviceClass} from '../../classes/DeviceClass'

import { relationalStore } from '@kit.ArkData';
import { BusinessError } from '@kit.BasicServicesKit';
import { storeRdb } from '../../entryability/EntryAbility'
import { CacheSHareDataData } from '../../classes/AppStorageV2/CacheShareData';
import { AppStorageV2, PersistenceV2 } from '@kit.ArkUI';
import { PersistentShareData } from '../../classes/PersistenceV2/PersistentShareData';
import { sceneArray, sceneArraySelect } from '../../tools/DoingToRdb';

@ComponentV2
export struct HomeAddNewDevice{

   @Local cacheSHareDataData:CacheSHareDataData = AppStorageV2.connect(CacheSHareDataData,()=>new CacheSHareDataData())!;
   @Local persistentShareData:PersistentShareData=PersistenceV2.connect(PersistentShareData,()=>new PersistentShareData)!;

   @Local sceneSelectArray:Array<SelectOption>=[];


  @Consumer('isShowAddDevice')isShowAddDevice:boolean = false;

   @Local isFirstStepNext:boolean=false;

   @Local addNewDeviceType:newDeviceClass=new newDeviceClass('',$r('app.media.addNew'));

   @Local addNewDeviceName:string='';

   @Local addNewDeviceScene:string='';

   @Local isOpen:boolean=false;

   @Local valueBucket: relationalStore.ValuesBucket | undefined= undefined;

   @Local newDevice:DeviceClass|undefined=undefined;

   @Local newDeviceArrary:Array<newDeviceClass>=[
    new newDeviceClass('灯',$r('app.media.normalLightOff')),
    new newDeviceClass('温度计',$r('app.media.thermometer')),
    new newDeviceClass('电视',$r('app.media.startIcon')),
    new newDeviceClass('空调',$r('app.media.startIcon')),
  ];



  build() {
    Stepper(){
      StepperItem(){

        Column(){
          Text('选择设备类型')

          Grid(){
            ForEach(this.newDeviceArrary,(item:newDeviceClass)=>{
              GridItem(){
                Column(){
                  Image(item.devicePic)
                    .height('70')
                    .margin({top:10})
                  Blank()
                  Row(){
                    Text(item.deviceName)
                    Blank()
                    Radio({value:item.deviceName,group:'devicePicker'})
                      .onChange((isChecked)=>{
                        this.isFirstStepNext=isChecked;
                        if(isChecked)
                        {
                          this.addNewDeviceType=item;
                        }
                      }).id(item.deviceName)
                  }.width('90%')

                }.width('150')
                .height("150")
                .backgroundColor(Color.White)
                .borderRadius('20')
                .clickEffect({level:ClickEffectLevel.LIGHT,scale:0.7})
                .onClick(()=>sendEventByKey(item.deviceName,10,''))

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

        }.height('90%')

      }.status(this.isFirstStepNext?ItemState.Normal:ItemState.Waiting)

      StepperItem(){
        Column(){
          Text('搜寻设备中')
          Text(this.addNewDeviceType.deviceName)
          LoadingProgress().width('50')
        }.height('100%')
        .width('90%')

      }
      StepperItem(){
        Column(){

          Image(this.addNewDeviceType.devicePic)
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

        if(this.addNewDeviceType.deviceName=='灯')
        {
         this.valueBucket = {
            'DEVICE_NAME' : this.addNewDeviceName,
            'SCENE' :  this.addNewDeviceScene,
            'IS_OPEN' : 0,        //0为关,1为关开,2为不启用
            'DEVICE_TYPE':'light',
            'LIGHT_BRIGHTNESS':1,
          };

        }else if(this.addNewDeviceType.deviceName=='温度计')
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

      this.isShowAddDevice=false;

      setTimeout(()=>{this.cacheSHareDataData.isRefresh=true;}
      ,50)

    })

  }
}