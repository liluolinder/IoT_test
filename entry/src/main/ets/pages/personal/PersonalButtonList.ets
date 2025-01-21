import {PersonalBodyButtonClass} from '../../classes/PersonalBodyButtonClass'

import { PersonalButtons } from './PersonalButtons';

@ComponentV2
export  struct PersonalButtonList {

  @Local isShowPrivacyManage:boolean=false;
  @Local isShowSetting:boolean=false;

  @Local PersonalButtonLists1:Array<PersonalBodyButtonClass>  = [
    new PersonalBodyButtonClass("0","设置","",true),
    new PersonalBodyButtonClass("1","关于我们","",false)];

  @Local PersonalButtonLists2:Array<PersonalBodyButtonClass>  = [
    new PersonalBodyButtonClass("2","反馈","",false),
    new PersonalBodyButtonClass("3","帮助","",false),
    new PersonalBodyButtonClass("4","隐私管理","",true)];


  build() {

    Column() {

      Column() {

        ForEach(this.PersonalButtonLists1, (item: PersonalBodyButtonClass, id: number) => {

          PersonalButtons({buttonItem:item})

          if (id < this.PersonalButtonLists1.length - 1) {
            Divider().width('76%').color(Color.Black)
          }

        }, (item: PersonalBodyButtonClass) => item.id)

      }.width('90%')
      .borderRadius('20')
      .backgroundColor(Color.White)

      Divider().strokeWidth(10).color('#F1F3F5')

      Column() {

        ForEach(this.PersonalButtonLists2, (item: PersonalBodyButtonClass, id: number) => {

          PersonalButtons({buttonItem:item})

          if (id < this.PersonalButtonLists2.length - 1) {
            Divider().width('76%').color(Color.Black)
          }

        }, (item: PersonalBodyButtonClass) => item.id)


      }.width('90%')
      .borderRadius('20')
      .backgroundColor(Color.White)

    }
  }

}