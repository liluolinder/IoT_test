import {PersonalBodyButtonClass} from '../../classes/PersonalBodyButtonClass'

@ComponentV2
export struct PersonalPrivacyButton{

  @Local personalPrivacyButtonArray:Array<PersonalBodyButtonClass>=[
    new PersonalBodyButtonClass('0','隐私声明摘要','',false),
    new PersonalBodyButtonClass('1','已收集个人信息清单','',false)
  ];

  build() {

    Column(){

      Scroll(){

        Column(){
          Column(){
            ForEach(this.personalPrivacyButtonArray,(item:PersonalBodyButtonClass,id:number)=>{

              Button(){

                Row() {

                  Text(item.buttonInfo)
                    .fontColor(Color.Black)
                    .width('90%')

                  Blank()

                  SymbolGlyph($r('sys.symbol.chevron_right')).fontSize(30)

                }

              }.width('100%')
              .height('50')
              .backgroundColor(Color.White)
              .margin('5')
              .borderRadius('10')

              if (id < this.personalPrivacyButtonArray.length - 1) {
                Divider().width('80%').color(Color.Black)
              }

            })
          }
          .borderRadius('20')
          .backgroundColor(Color.White)

        }.width('90%')
        .height('100%')

      }.width('100%')
      .height('100%')
      .scrollable(ScrollDirection.Vertical)        //垂直方向滑动
      .scrollBar(BarState.Off)                      //不显示滑动条
      .edgeEffect(EdgeEffect.Spring,{alwaysEnabled: true})    //弹性滑动动效

    }
    .borderRadius('20')
    .height('100%')

  }

}