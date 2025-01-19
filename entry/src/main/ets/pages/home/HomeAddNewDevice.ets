import { DeviceClass, newDeviceClass} from '../../classes/DeviceClass'
import {HomeTitleSelectList} from  '../home/HomeTopButton'
import { relationalStore } from '@kit.ArkData';
import { BusinessError } from '@kit.BasicServicesKit';
import { storeRdb } from '../../entryability/EntryAbility'
import { GetDeviceInfoFromRdb, deviceArray} from '../../tools/DoingToRdb'

@Component
export struct HomeAddNewDevice{

  @StorageLink('isAddDeviceSheetShow') isShowAddDevice: boolean = false;

  @State isFirstStepNext:boolean=false

  @State addNewDeviceType:newDeviceClass=new newDeviceClass('',$r('app.media.addNew'))

  @State addNewDeviceName:string=''

  @State addNewDeviceScene:string=''

  @State isOpen:boolean=false

  @State valueBucket: relationalStore.ValuesBucket | undefined= undefined

  @State newDevice:DeviceClass|undefined=undefined

  @State newDeviceArrary:Array<newDeviceClass>=[
    new newDeviceClass('灯',$r('app.media.normalLightOff')),
    new newDeviceClass('温度计',$r('app.media.thermometer')),
    new newDeviceClass('电视',$r('app.media.startIcon')),
    new newDeviceClass('空调',$r('app.media.startIcon')),
  ]

  build() {
    Stepper(){
      StepperItem(){

        Column(){
          Text('选择设备类型')

          Grid(){
            ForEach(this.newDeviceArrary,(item:newDeviceClass,id:number)=>{
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

          Select(HomeTitleSelectList).width('100%').onSelect((index:number, text: string )=>{
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
          };

        }else if(this.addNewDeviceType.deviceName=='温度计')
        {
          this.valueBucket = {
            'DEVICE_NAME' : this.addNewDeviceName,
            'SCENE' :  this.addNewDeviceScene,
            'IS_OPEN' :2 ,  //2表示不启用
            'DEVICE_TYPE':'thermometer',
          };
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

      this.isShowAddDevice=false;''

      setTimeout(()=>{GetDeviceInfoFromRdb()},1000);

    })
  }
}