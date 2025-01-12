import { promptAction } from "@kit.ArkUI";

@Component
export struct HomeTopButton {

  @State isShowAddDevice:boolean=false
  @State isShowAddGround:boolean=false

  @State isFirstStepNext:boolean=false

  @State HomeTitleSelectList:Array<SelectOption>=[{value:'我的家'},{value:'???'}];
  @State index:number=1;

  @Builder
  HomeAddDeviceBuildSheet() {
    Stepper(){
      StepperItem(){

        Column(){
          Text('选择设备类型')

          Grid(){
            ForEach([0,1,2,3,4,5,6,7,8,9],(id:number)=>{
              GridItem(){
                Column(){
                  Image('')
                  Row(){
                    Text(id.toString())
                    Blank()
                    Radio({value:id.toString(),group:'devicePicker'})
                      .onChange((isChecked)=>{this.isFirstStepNext=isChecked})
                  }



                }.width('150')
                .height("150")
                .backgroundColor(Color.White)
                .borderRadius('5%')
              }
            })
          }.columnsTemplate('repeat(auto-stretch, 150)')
          .rowsGap(10)
          .width('90%')
          .height('100%')
          .margin({top:5})
          .scrollBar(BarState.Off)
          .multiSelectable(true)

        }.height('100%')

      }.status(this.isFirstStepNext?ItemState.Normal:ItemState.Waiting)

      StepperItem(){
        Column(){
          Text('搜寻设备中')
          LoadingProgress().width('50')
        }.height('100%')
        .width('90%')

      }
      StepperItem(){
        Text('3')
      }
    }.margin({bottom:10})

  }

  @Builder
  HomeAddGroundBuildSheet() {
    Column()
    {
      Text('没做')
    }
  }

  @Builder
  TopAddMenu(){

    Menu(){

      MenuItem({content: "添加设备" })
        .onClick(()=>{
          this.isShowAddDevice=true;
          })



      MenuItem({content: "创建场景" })
        .onClick(()=>{
          this.isShowAddGround=true;
        })

      MenuItem({content: "扫一扫" })
        .onClick(()=>{
          promptAction.showToast({
            message: '没做',
          });
        })

    }

  }

  build() {

    Row(){
      Select(this.HomeTitleSelectList)
        .selected(0)
        .value(this.HomeTitleSelectList==null?'暂未创建场景':this.HomeTitleSelectList[0].value)
        .font({ size: 22, weight: FontWeight.Bolder })
        .fontColor('#182431')
        .selectedOptionFont({ size: 16, weight: 400 })
        .optionFont({ size: 16, weight: 400 })
        .menuAlign(MenuAlignType.START, {dx:0, dy:0})
        .optionWidth(200)
        .optionHeight(300)
        .width('60%')

      Blank()
        .bindSheet($$this.isShowAddGround,this.HomeAddGroundBuildSheet(),
        {
          title:{title:'添加场景',subtitle:'Add a new ground'},
        })


      Button(){
        Image($r('app.media.ic_public_add_filled'))
          .height('35')

      }.type(ButtonType.Circle)
      .backgroundColor(Color.White)
      .height('35')
      .bindMenu(this.TopAddMenu())
      .bindSheet($$this.isShowAddDevice,this.HomeAddDeviceBuildSheet(),
        {
          title:{title:'添加设备',subtitle:'Add a new device'},
          onDisappear:()=>{this.isFirstStepNext=false}
        })


    }
    .width('90%')

  }

}