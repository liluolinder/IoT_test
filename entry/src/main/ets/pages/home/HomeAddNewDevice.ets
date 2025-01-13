import {DeviceClass} from '../../classes/DeviceClass'
import { radio } from '@kit.TelephonyKit'

@Component
export struct HomeAddNewDevice{

  @State isFirstStepNext:boolean=false
  @State addNewDeviceName:string=''

  @State newDeviceArrary:Array<DeviceClass>=[
    new DeviceClass('灯',''),
    new DeviceClass('温度计',''),
    new DeviceClass('?',''),
    new DeviceClass('??',''),
    new DeviceClass('???',''),
    new DeviceClass('????',''),
    new DeviceClass('?????',''),
    new DeviceClass('??????',''),
  ]

  build() {
    Stepper(){
      StepperItem(){

        Column(){
          Text('选择设备类型')

          Grid(){
            ForEach(this.newDeviceArrary,(item:DeviceClass,id:number)=>{
              GridItem(){
                Column(){
                  Image('')
                  Blank()
                  Row(){
                    Text(item.deviceName)
                    Blank()
                    Radio({value:item.deviceName,group:'devicePicker'})
                      .onChange((isChecked)=>{
                        this.isFirstStepNext=isChecked;
                        if(isChecked)
                        {
                          this.addNewDeviceName=item.deviceName;
                        }
                      }).id(item.deviceName)
                  }.width('90%')




                }.width('150')
                .height("150")
                .backgroundColor(Color.White)
                .borderRadius('5%')
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

        }.height('90%')

      }.status(this.isFirstStepNext?ItemState.Normal:ItemState.Waiting)

      StepperItem(){
        Column(){
          Text('搜寻设备中')
          Text(this.addNewDeviceName)
          LoadingProgress().width('50')
        }.height('100%')
        .width('90%')

      }
      StepperItem(){
        Text('3')
      }
    }.margin({bottom:10})
  }
}