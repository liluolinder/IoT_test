import {PersonalBodyButtonClass} from '../../classes/PersonalBodyButtonClass'

@Component
export  struct PersonalButtonList {

  @State isShowPrivacyManage:boolean=false;

  @State PersonalButtonLists1:Array<PersonalBodyButtonClass>  = [
    new PersonalBodyButtonClass("0","设置","",false),
    new PersonalBodyButtonClass("1","关于我们","",false)];

  @State PersonalButtonLists2:Array<PersonalBodyButtonClass>  = [
    new PersonalBodyButtonClass("0","反馈","",false),
    new PersonalBodyButtonClass("1","帮助","",false),
    new PersonalBodyButtonClass("2","隐私管理","",true)];

  @Builder
  PersonalPrivacyManageBuildSheet()
  {
    Column()
    {
      Text('没做完')
    }
  }




  build() {

    Column() {

      Column() {

        ForEach(this.PersonalButtonLists1, (item: PersonalBodyButtonClass, id: number) => {

          Button() {

            Row() {

              Text(item.buttonInfo)
                .fontColor(Color.Black)
                .width('90%')

              Blank()

              SymbolGlyph($r('sys.symbol.chevron_right')).fontSize(30)
            }

          }
          .width('100%')
          .height('50')
          .backgroundColor(Color.White)
          .margin('5')
          .borderRadius('5%')

          if (id < this.PersonalButtonLists1.length - 1) {
            Divider().width('80%').color(Color.Black)
          }

        }, (item: PersonalBodyButtonClass) => item.id)

      }.width('90%')
      .borderRadius('5%')
      .backgroundColor(Color.White)

      Divider().strokeWidth(10).color('#F1F3F5')

      Column() {
        ForEach(this.PersonalButtonLists2, (item: PersonalBodyButtonClass, id: number) => {
          Button() {
            Row() {

              Text(item.buttonInfo)
                .fontColor(Color.Black)
                .width('90%')

              Blank()

              SymbolGlyph($r('sys.symbol.chevron_right')).fontSize(30)

            }

          }
          .width('100%')
          .height('50')
          .backgroundColor(Color.White)
          .margin('5')
          .borderRadius('5%')
          .onClick(()=>{if(id==2){this.isShowPrivacyManage=true}})
          .bindSheet(item.isNeedBuildSheet && this.isShowPrivacyManage,this.PersonalPrivacyManageBuildSheet(),{
            onDisappear:()=>{this.isShowPrivacyManage=false}
          })

          if (id < this.PersonalButtonLists2.length - 1) {
            Divider().width('80%').color(Color.Black)
          }

        }, (item: PersonalBodyButtonClass) => item.id)


      }.width('90%')
      .borderRadius('5%')
      .backgroundColor(Color.White)


    }
  }

}