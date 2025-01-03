@Entry
@Component
export struct HomeTopButton {

  @Builder
  TopAddMenu(){

    Menu(){

      MenuItem({content: "添加设备" })
      MenuItem({content: "创建场景" })
      MenuItem({content:   "扫一扫" })

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