import { promptAction } from "@kit.ArkUI";

@Component
export struct HomeTopButton {

  @State isShowAddDevice:boolean=false
  @State isShowAddGround:boolean=false

  @Builder
  HomeAddDeviceBuildSheet() {
    Column()
    {
      Text('没做')
    }
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

      MenuItem({content:   "扫一扫" })
        .onClick(()=>{
          promptAction.showToast({
            message: '没做',
          });
        })

    }

  }

  build() {

    Row(){

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
        })


    }
    .justifyContent(FlexAlign.End)
    .width('90%')

  }

}