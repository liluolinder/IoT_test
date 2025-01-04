@Entry
@Component
export  struct HomeTitleSelect {

  @State HomeTitleSelectList:Array<SelectOption>=[{value:'我的家'},{value:'???'}];
  @State index:number=1;

  build() {

    Column(){

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


    }.width('90%')
    .alignItems(HorizontalAlign.Start)

  }

}