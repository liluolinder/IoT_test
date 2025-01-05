import { promptAction } from "@kit.ArkUI";

@Component
export struct HomeTopButton {

  @Builder
  TopAddMenu(){

    Menu(){

      MenuItem({content: "添加设备" })
        .onClick(()=>{
          promptAction.showToast({
            message: '没做',
          });
        })
      MenuItem({content: "创建场景" })
        .onClick(()=>{
          promptAction.showToast({
            message: '没做',
          });
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

    }
    .justifyContent(FlexAlign.End)
    .width('90%')

  }

}