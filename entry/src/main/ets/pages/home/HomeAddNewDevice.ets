import {DeviceClass} from '../../classes/DeviceClass'
import {HomeTitleSelectList} from  '../home/HomeTopButton'

@Component
export struct HomeAddNewDevice{

  @State isFirstStepNext:boolean=false
  @State addNewDeviceType:DeviceClass=new DeviceClass('',$r('app.media.addNew'))

  @State newDeviceArrary:Array<DeviceClass>=[
    new DeviceClass('灯',$r('app.media.normalLightOff')),
    new DeviceClass('温度计',$r('app.media.thermometer')),
    new DeviceClass('电视',$r('app.media.startIcon')),
    new DeviceClass('空调',$r('app.media.startIcon')),
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

          TextInput({placeholder:'请输入新设备名称'})
            .margin({bottom:10})
            .width('100%')

          Select(HomeTitleSelectList).width('100%')




        }.width('90%')
        .height('100%')

      }
    }.margin({bottom:10})
  }
}