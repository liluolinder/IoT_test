import {PersonalBodyButtonClass} from '../../classes/PersonalBodyButtonClass'
import App from '@system.app';

@Entry
@Component
export  struct PersonalButtonList {

  @State PersonalButtonLists1:Array<PersonalBodyButtonClass>  = [
    new PersonalBodyButtonClass("0","设置",""),
    new PersonalBodyButtonClass("1","关于我们","")];

  @State PersonalButtonLists2:Array<PersonalBodyButtonClass>  = [
    new PersonalBodyButtonClass("0","隐私管理",""),
    new PersonalBodyButtonClass("1","反馈",""),
    new PersonalBodyButtonClass("2","帮助","")];

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

              Image($r('app.media.ic_public_arrow_right')).height('80%')
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

              Image($r('app.media.ic_public_arrow_right')).height('80%')
            }

          }
          .width('100%')
          .height('50')
          .backgroundColor(Color.White)
          .margin('5')
          .borderRadius('5%')

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